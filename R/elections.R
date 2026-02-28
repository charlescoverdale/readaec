# Election metadata -------------------------------------------------------

#' @keywords internal
aec_elections <- data.frame(
  year = c(2001, 2004, 2007, 2010, 2013, 2016, 2019, 2022, 2025),
  event_id = c(10822, 12246, 13745, 15508, 17496, 20499, 24310, 27966, 31496),
  date = as.Date(c(
    "2001-11-10", "2004-10-09", "2007-11-24", "2010-08-21",
    "2013-09-07", "2016-07-02", "2019-05-18", "2022-05-21", "2025-05-03"
  )),
  type = c(
    "general", "general", "general", "general", "general",
    "double_dissolution", "general", "general", "general"
  ),
  # AEC CSV downloads are only available from 2007 onwards
  has_downloads = c(FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE),
  stringsAsFactors = FALSE
)

#' List all available federal elections
#'
#' @return A data frame with one row per election, including columns
#'   `year`, `date`, `event_id`, `type`, and `has_downloads`. The
#'   `has_downloads` column is `TRUE` for years where AEC CSV downloads
#'   are available (2007 onwards). The 2001 and 2004 elections are listed
#'   for reference but their data cannot be fetched.
#' @export
#' @examples
#' list_elections()
#'
#' # Only years with downloadable data
#' list_elections()[list_elections()$has_downloads, ]
list_elections <- function() {
  aec_elections
}

#' @keywords internal
year_to_event_id <- function(year) {
  valid <- aec_elections$year
  if (!year %in% valid) {
    cli::cli_abort(
      "Year {year} is not a valid election year. Use {.fn list_elections} to see available years."
    )
  }
  row <- aec_elections[aec_elections$year == year, ]
  if (!row$has_downloads) {
    cli::cli_abort(
      "AEC CSV downloads are not available for {year}. Data is only available from 2007 onwards."
    )
  }
  row$event_id
}

#' @keywords internal
aec_url <- function(event_id, filename) {
  glue::glue("https://results.aec.gov.au/{event_id}/Website/Downloads/{filename}-{event_id}.csv")
}
