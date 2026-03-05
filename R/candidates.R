# Candidates & polling places ---------------------------------------------

#' Get all candidates for an election
#'
#' @param year Election year. Use [list_elections()] to see available years.
#' @param chamber "house" or "senate".
#' @return A tidy data frame of candidates.
#' @export
#' @examples
#' \donttest{
#' get_candidates(2022)
#' get_candidates(2022, chamber = "senate")
#' }
get_candidates <- function(year, chamber = "house") {
  event_id <- year_to_event_id(year)
  filename <- switch(chamber,
    "house"  = "HouseCandidatesDownload",
    "senate" = "SenateCandidatesDownload",
    cli::cli_abort("chamber must be 'house' or 'senate'")
  )
  df <- aec_fetch(event_id, filename)
  df <- dplyr::rename_with(df, tolower)
  df$year <- year
  df
}

#' Get polling place locations
#'
#' Returns all polling place addresses and coordinates for a given election.
#'
#' @param year Election year. Use [list_elections()] to see available years.
#' @param division Filter to a specific division name. NULL returns all.
#' @return A tidy data frame of polling places with lat/lon coordinates.
#' @export
#' @examples
#' \donttest{
#' get_polling_places(2022)
#' get_polling_places(2022, division = "Kooyong")
#' }
get_polling_places <- function(year, division = NULL) {
  event_id <- year_to_event_id(year)
  df <- aec_fetch(event_id, "GeneralPollingPlacesDownload")
  df <- dplyr::rename_with(df, tolower)
  df$year <- year

  if (!is.null(division)) {
    df <- dplyr::filter(df, tolower(divisionnm) == tolower(division))
    if (nrow(df) == 0) {
      cli::cli_warn("No polling places found for division {division} in {year}.")
    }
  }

  df
}

#' Get enrolment by division
#'
#' @param year Election year. Use [list_elections()] to see available years.
#' @return A tidy data frame of enrolment figures by division.
#' @export
#' @examples
#' \donttest{
#' get_enrolment(2022)
#' }
get_enrolment <- function(year) {
  event_id <- year_to_event_id(year)
  df <- aec_fetch(event_id, "GeneralEnrolmentByDivisionDownload")
  df <- dplyr::rename_with(df, tolower)
  df$year <- year
  df
}

#' Get turnout by division
#'
#' @param year Election year. Use [list_elections()] to see available years.
#' @return A tidy data frame of turnout figures by division.
#' @export
#' @examples
#' \donttest{
#' get_turnout(2022)
#' }
get_turnout <- function(year) {
  event_id <- year_to_event_id(year)
  df <- aec_fetch(event_id, "HouseTurnoutByDivisionDownload")
  df <- dplyr::rename_with(df, tolower)
  df$year <- year
  df
}
