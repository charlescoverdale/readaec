# By-elections ------------------------------------------------------------

#' @keywords internal
aec_by_elections <- data.frame(
  division = c(
    "Farrer", "Cook", "Dunkley", "Fadden", "Aston",
    "Groom", "Eden-Monaro", "Wentworth",
    "Perth", "Mayo", "Longman", "Fremantle", "Braddon",
    "Batman", "Bennelong", "New England",
    "North Sydney", "Canning", "Griffith",
    "Bradfield", "Higgins", "Lyne", "Mayo", "Gippsland",
    "Werriwa"
  ),
  state = c(
    "NSW", "NSW", "VIC", "QLD", "VIC",
    "QLD", "NSW", "NSW",
    "WA", "SA", "QLD", "WA", "TAS",
    "VIC", "NSW", "NSW",
    "NSW", "WA", "QLD",
    "NSW", "VIC", "NSW", "SA", "VIC",
    "NSW"
  ),
  date = as.Date(c(
    "2026-05-09", "2024-04-13", "2024-03-02", "2023-07-15", "2023-04-01",
    "2020-11-28", "2020-07-04", "2018-10-20",
    "2018-07-28", "2018-07-28", "2018-07-28", "2018-07-28", "2018-07-28",
    "2018-03-17", "2017-12-16", "2017-12-02",
    "2015-12-05", "2015-09-19", "2014-02-08",
    "2009-12-05", "2009-12-05", "2008-09-06", "2008-09-06", "2008-06-28",
    "2005-03-19"
  )),
  event_id = c(
    31633, 29807, 29778, 29422, 28791,
    25881, 25820, 22844,
    22696, 22695, 22694, 22693, 22692,
    21751, 21379, 21364,
    19402, 18126, 17552,
    14357, 14358, 13827, 13826, 13813,
    12426
  ),
  # AEC CSV downloads exist for by-elections from 2008 onwards
  has_downloads = c(rep(TRUE, 24), FALSE),
  stringsAsFactors = FALSE
)

#' List all federal by-elections
#'
#' Lists House of Representatives by-elections with results published on the
#' AEC tally room, from 2005 onwards. The 2014 WA Senate special election is
#' not included as it was not a House by-election.
#'
#' @return A data frame with one row per by-election, including columns
#'   `division`, `state`, `date`, `year`, `event_id`, and `has_downloads`.
#'   The `has_downloads` column is `TRUE` where AEC CSV downloads are
#'   available (2008 onwards).
#' @export
#' @examples
#' list_by_elections()
list_by_elections <- function() {
  df <- aec_by_elections
  df$year <- as.integer(format(df$date, "%Y"))
  df[, c("division", "state", "date", "year", "event_id", "has_downloads")]
}

#' @keywords internal
by_election_lookup <- function(division, year = NULL) {
  df <- list_by_elections()
  match <- df[tolower(df$division) == tolower(division), ]

  if (nrow(match) == 0) {
    cli::cli_abort(
      "No by-election found for division {.val {division}}. Use {.fn list_by_elections} to see available by-elections."
    )
  }
  if (!is.null(year)) {
    match <- match[match$year == year, ]
    if (nrow(match) == 0) {
      cli::cli_abort(
        "No {division} by-election in {year}. Use {.fn list_by_elections} to see available by-elections."
      )
    }
  }
  if (nrow(match) > 1) {
    cli::cli_abort(
      "Multiple {division} by-elections found ({match$year}). Specify {.arg year}."
    )
  }
  if (!match$has_downloads) {
    cli::cli_abort(
      "AEC CSV downloads are not available for the {match$year} {division} by-election."
    )
  }
  match
}

#' Get by-election first preference votes by polling place
#'
#' By-election results are published at polling place level. Use
#' [list_by_elections()] to see which by-elections are available.
#'
#' @param division Division name (e.g. "Farrer").
#' @param year By-election year. Only needed where a division has had more
#'   than one by-election (e.g. Mayo in 2008 and 2018).
#' @param refresh If `TRUE`, re-download from the AEC even if a cached copy
#'   exists.
#' @return A tidy data frame of first preference votes by polling place.
#' @export
#' @examples
#' \donttest{
#' op <- options(readaec.cache_dir = tempdir())
#' get_by_election_fp("Farrer")
#' options(op)
#' }
get_by_election_fp <- function(division, year = NULL, refresh = FALSE) {
  be <- by_election_lookup(division, year)
  filename <- paste0(
    "HouseStateFirstPrefsByPollingPlaceDownload-", be$event_id, "-", be$state
  )
  url <- glue::glue(
    "https://results.aec.gov.au/{be$event_id}/Website/Downloads/{filename}.csv"
  )
  df <- aec_download(url, paste0(filename, ".csv"), refresh)
  df <- dplyr::rename_with(df, tolower)
  df$date <- be$date
  df
}

#' Get by-election two-candidate preferred votes by polling place
#'
#' @inheritParams get_by_election_fp
#' @return A tidy data frame of TCP votes by candidate by polling place.
#' @export
#' @examples
#' \donttest{
#' op <- options(readaec.cache_dir = tempdir())
#' get_by_election_tcp("Farrer")
#' options(op)
#' }
get_by_election_tcp <- function(division, year = NULL, refresh = FALSE) {
  be <- by_election_lookup(division, year)
  df <- aec_fetch(be$event_id, "HouseTcpByCandidateByPollingPlaceDownload", refresh)
  df <- dplyr::rename_with(df, tolower)
  df$date <- be$date
  df
}

#' Get by-election two-party preferred votes by polling place
#'
#' Note that TPP figures are only meaningful where the final two candidates
#' were ALP and Coalition. In by-elections decided between other candidates
#' (such as Farrer in 2026), use [get_by_election_tcp()] instead.
#'
#' @inheritParams get_by_election_fp
#' @return A tidy data frame of TPP votes by polling place.
#' @export
#' @examples
#' \donttest{
#' op <- options(readaec.cache_dir = tempdir())
#' get_by_election_tpp("Dunkley")
#' options(op)
#' }
get_by_election_tpp <- function(division, year = NULL, refresh = FALSE) {
  be <- by_election_lookup(division, year)
  df <- aec_fetch(be$event_id, "HouseTppByPollingPlaceDownload", refresh)
  df <- dplyr::rename_with(df, tolower)
  df$date <- be$date
  df
}

#' Get by-election candidates
#'
#' @inheritParams get_by_election_fp
#' @return A tidy data frame of candidates.
#' @export
#' @examples
#' \donttest{
#' op <- options(readaec.cache_dir = tempdir())
#' get_by_election_candidates("Farrer")
#' options(op)
#' }
get_by_election_candidates <- function(division, year = NULL, refresh = FALSE) {
  be <- by_election_lookup(division, year)
  df <- aec_fetch(be$event_id, "HouseCandidatesDownload", refresh)
  df <- dplyr::rename_with(df, tolower)
  df$date <- be$date
  df
}
