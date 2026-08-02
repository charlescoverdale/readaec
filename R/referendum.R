# Referendums -------------------------------------------------------------

#' @keywords internal
aec_referendums <- data.frame(
  year = 2023,
  event_id = 29581,
  date = as.Date("2023-10-14"),
  description = "Aboriginal and Torres Strait Islander Voice",
  stringsAsFactors = FALSE
)

#' List available referendums
#'
#' @return A data frame with one row per referendum with results published
#'   on the AEC tally room, including columns `year`, `date`, `event_id`,
#'   and `description`.
#' @export
#' @examples
#' list_referendums()
list_referendums <- function() {
  aec_referendums
}

#' @keywords internal
referendum_event_id <- function(year) {
  if (!year %in% aec_referendums$year) {
    cli::cli_abort(
      "No referendum data for {year}. Use {.fn list_referendums} to see available years."
    )
  }
  aec_referendums$event_id[aec_referendums$year == year]
}

#' Get referendum results by polling place
#'
#' Returns Yes and No votes for every polling place, including formal and
#' informal counts.
#'
#' @param year Referendum year. Use [list_referendums()] to see available
#'   years. Defaults to 2023 (the Voice referendum).
#' @param state Filter to a specific state (e.g. "VIC"). NULL returns all
#'   states.
#' @param refresh If `TRUE`, re-download from the AEC even if a cached copy
#'   exists.
#' @return A tidy data frame of Yes/No votes by polling place.
#' @export
#' @examples
#' \donttest{
#' op <- options(readaec.cache_dir = tempdir())
#' get_referendum_by_booth(2023, state = "TAS")
#' options(op)
#' }
get_referendum_by_booth <- function(year = 2023, state = NULL, refresh = FALSE) {
  event_id <- referendum_event_id(year)

  if (is.null(state)) {
    states <- c("NSW", "VIC", "QLD", "WA", "SA", "TAS", "ACT", "NT")
    cli::cli_inform("Downloading referendum booth data for all states...")
    df <- dplyr::bind_rows(lapply(states, function(s) {
      get_referendum_by_booth(year, state = s, refresh = refresh)
    }))
    return(df)
  }

  state <- toupper(state)
  valid_states <- c("NSW", "VIC", "QLD", "WA", "SA", "TAS", "ACT", "NT")
  if (!state %in% valid_states) {
    cli::cli_abort("Invalid state {state}. Must be one of: {valid_states}")
  }
  filename <- paste0(
    "ReferendumPollingPlaceResultsByStateDownload-", event_id, "-", state
  )
  url <- glue::glue(
    "https://results.aec.gov.au/{event_id}/Website/Downloads/{filename}.csv"
  )
  df <- aec_download(url, paste0(filename, ".csv"), refresh)

  df <- dplyr::rename_with(df, tolower)
  df <- dplyr::rename(df,
    state = stateab,
    division = divisionname,
    division_id = divisionid
  )
  df$year <- year
  df
}

#' Get referendum turnout
#'
#' @inheritParams get_referendum_by_booth
#' @param by Aggregation level: "division" (default) or "state".
#' @return A tidy data frame of enrolment and turnout.
#' @export
#' @examples
#' \donttest{
#' op <- options(readaec.cache_dir = tempdir())
#' get_referendum_turnout(2023)
#' get_referendum_turnout(2023, by = "state")
#' options(op)
#' }
get_referendum_turnout <- function(year = 2023, by = "division", refresh = FALSE) {
  event_id <- referendum_event_id(year)
  filename <- switch(by,
    "division" = "ReferendumTurnoutByDivisionDownload",
    "state"    = "ReferendumTurnoutByStateDownload",
    cli::cli_abort("by must be 'division' or 'state'")
  )
  df <- aec_fetch(event_id, filename, refresh)
  df <- dplyr::rename_with(df, tolower)
  df <- dplyr::rename(df, dplyr::any_of(c(
    state = "stateab", division = "divisionnm", division_id = "divisionid"
  )))
  df$year <- year
  df
}
