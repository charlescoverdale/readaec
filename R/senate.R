# Senate ------------------------------------------------------------------

#' Get Senate first preference votes by state
#'
#' @inheritParams get_fp
#' @return A tidy data frame of Senate first preference votes by state.
#' @export
#' @examples
#' \donttest{
#' op <- options(readaec.cache_dir = tempdir())
#' get_senate(2022)
#' options(op)
#' }
get_senate <- function(year, refresh = FALSE) {
  event_id <- year_to_event_id(year)
  df <- aec_fetch(event_id, "SenateFirstPrefsByStateByVoteTypeDownload", refresh)
  df <- dplyr::rename_with(df, tolower)
  df$year <- year
  df
}

#' Get senators elected
#'
#' Returns the senators elected at each election, in the order they were
#' elected within each state or territory.
#'
#' @inheritParams get_fp
#' @return A tidy data frame with one row per senator elected, including
#'   `state`, `given_name`, `surname`, `party`, `party_name`, and
#'   `elected_order`.
#' @export
#' @examples
#' \donttest{
#' op <- options(readaec.cache_dir = tempdir())
#' get_senators_elected(2025)
#' options(op)
#' }
get_senators_elected <- function(year, refresh = FALSE) {
  event_id <- year_to_event_id(year)
  df <- aec_fetch(event_id, "SenateSenatorsElectedDownload", refresh)
  df <- dplyr::rename_with(df, tolower)
  df <- dplyr::rename(df,
    state = stateab,
    given_name = givennm,
    party = partyab,
    party_name = partynm,
    elected_order = electedorder
  )
  df$year <- year
  df
}
