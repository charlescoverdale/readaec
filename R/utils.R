# Utilities ---------------------------------------------------------------

#' @keywords internal
aec_cache_dir <- function() {
  d <- getOption("readaec.cache_dir", default = tools::R_user_dir("readaec", "cache"))
  if (!dir.exists(d)) dir.create(d, recursive = TRUE)
  d
}

#' @keywords internal
aec_fetch <- function(event_id, filename) {
  url <- aec_url(event_id, filename)
  cache_file <- file.path(aec_cache_dir(), paste0(filename, "-", event_id, ".csv"))

  if (file.exists(cache_file)) {
    cli::cli_inform("Loading from cache: {filename}")
  } else {
    cli::cli_inform("Downloading from AEC: {filename}")
    req <- httr2::request(url)
    resp <- httr2::req_perform(req)

    if (httr2::resp_status(resp) != 200) {
      cli::cli_abort("Failed to download {filename} (HTTP {httr2::resp_status(resp)})")
    }

    writeBin(httr2::resp_body_raw(resp), cache_file)
  }

  # AEC CSVs have a metadata header row — skip it
  readr::read_csv(cache_file, skip = 1, show_col_types = FALSE)
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
