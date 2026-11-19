# Utilities ---------------------------------------------------------------

#' @keywords internal
aec_cache_dir <- function() {
  d <- getOption("readaec.cache_dir", default = tools::R_user_dir("readaec", "cache"))
  if (!dir.exists(d)) dir.create(d, recursive = TRUE)
  d
}

#' Build a request to the AEC
#'
#' The one place requests are built. httr2 sets no transfer timeout, so a
#' server that accepts the connection and then stalls would hang the session
#' indefinitely. The curl options abort a connection that takes more than 20
#' seconds to open, or a transfer that moves less than 1 byte per second for
#' 60 seconds, while letting slow but progressing downloads finish.
#'
#' @keywords internal
aec_request <- function(url) {
  req <- httr2::request(url)
  req <- httr2::req_user_agent(
    req, "readaec R package (https://github.com/charlescoverdale/readaec)"
  )
  req <- httr2::req_options(
    req, connecttimeout = 20L, low_speed_limit = 1L, low_speed_time = 60L
  )
  req <- httr2::req_retry(req, max_tries = 3)
  # Disable httr2's default error-on-4xx/5xx so we can report the status
  # code with a readable message instead of a raw httr2 condition
  httr2::req_error(req, is_error = function(resp) FALSE)
}

#' Download a file from the AEC, with caching
#'
#' Downloads are written to a temporary file first and only moved into the
#' cache once complete, so a failed download never leaves a corrupt file
#' behind. Requests identify the package, retry on transient failures, and
#' report HTTP errors with the status code.
#'
#' @keywords internal
aec_download <- function(url, basename, refresh = FALSE) {
  cache_file <- file.path(aec_cache_dir(), basename)

  if (file.exists(cache_file) && !refresh) {
    cli::cli_inform("Loading from cache: {basename}")
  } else {
    cli::cli_inform("Downloading from AEC: {basename}")
    resp <- tryCatch(
      httr2::req_perform(aec_request(url)),
      httr2_failure = function(e) {
        cli::cli_abort(
          c(
            "Failed to download {basename} from the AEC.",
            "i" = "The connection failed or stalled: {conditionMessage(e)}",
            "i" = "URL: {.url {url}}"
          ),
          parent = e
        )
      }
    )

    if (httr2::resp_status(resp) != 200) {
      cli::cli_abort(
        "Failed to download {basename} (HTTP {httr2::resp_status(resp)})."
      )
    }

    tmp <- tempfile(tmpdir = aec_cache_dir(), fileext = ".part")
    writeBin(httr2::resp_body_raw(resp), tmp)
    file.rename(tmp, cache_file)
  }

  # AEC CSVs have a metadata header row — skip it. Guess column types from
  # the whole file: some AEC files (e.g. polling places) only reveal a
  # column's true type thousands of rows in
  readr::read_csv(cache_file, skip = 1, show_col_types = FALSE,
                  guess_max = Inf)
}

#' @keywords internal
aec_fetch <- function(event_id, filename, refresh = FALSE) {
  aec_download(
    url = aec_url(event_id, filename),
    basename = paste0(filename, "-", event_id, ".csv"),
    refresh = refresh
  )
}

#' Clear the local AEC data cache
#'
#' Deletes all files downloaded and cached by readaec. The next function call
#' will re-download fresh data from the AEC.
#'
#' @return Invisibly returns `NULL`. Called for its side effect of deleting
#'   cached files.
#'
#' @export
#' @examples
#' \donttest{
#' op <- options(readaec.cache_dir = tempdir())
#' clear_cache()
#' options(op)
#' }
clear_cache <- function() {
  d <- aec_cache_dir()
  files <- list.files(d, full.names = TRUE)
  file.remove(files)
  cli::cli_inform("Cleared {length(files)} cached file{?s}.")
  invisible(NULL)
}
