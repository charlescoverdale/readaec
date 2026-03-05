# Senate ------------------------------------------------------------------

#' Get Senate first preference votes by state
#'
#' @param year Election year. Use [list_elections()] to see available years.
#' @return A tidy data frame of Senate first preference votes by state.
#' @export
#' @examples
#' \donttest{
#' get_senate(2022)
#' }
get_senate <- function(year) {
  event_id <- year_to_event_id(year)
  df <- aec_fetch(event_id, "SenateFirstPrefsByStateByVoteTypeDownload")
  df <- dplyr::rename_with(df, tolower)
  df$year <- year
  df
}
