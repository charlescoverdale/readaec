# Swing analysis ----------------------------------------------------------

#' Compare TPP results between two elections
#'
#' Calculates the change in two-party preferred vote share between any two
#' federal elections. Joins on division ID (not name) to handle renamed
#' divisions correctly. Divisions that don't appear in both elections are
#' flagged rather than silently dropped.
#'
#' The winner columns report the party that actually won the seat (from the
#' AEC's members elected file), so crossbench seats are identified correctly.
#' The TPP leader columns report which of ALP or the Coalition led the
#' two-party preferred count, which is not the same thing in seats won by
#' independents and minor parties.
#'
#' @param from Election year to compare from. Use [list_elections()] to see
#'   available years.
#' @param to Election year to compare to.
#' @param division Optionally filter to one or more division names.
#' @param state Optionally filter to a state abbreviation (e.g. "VIC").
#' @param refresh If `TRUE`, re-download from the AEC even if a cached copy
#'   exists.
#'
#' @return A data frame with one row per division containing:
#'   \item{division}{Division name (from the later election)}
#'   \item{division_id}{AEC division ID}
#'   \item{state}{State abbreviation}
#'   \item{alp_pct_from, alp_pct_to}{ALP TPP percentage in each election}
#'   \item{lnp_pct_from, lnp_pct_to}{LNP TPP percentage in each election}
#'   \item{alp_swing}{Change in ALP TPP (positive = swing to ALP)}
#'   \item{lnp_swing}{Change in LNP TPP (positive = swing to LNP)}
#'   \item{winner_from, winner_to}{Party that won the seat in each election}
#'   \item{tpp_leader_from, tpp_leader_to}{Which of ALP/LNP led the TPP count}
#'   \item{seat_changed}{TRUE if the seat changed hands}
#'   \item{redistribution_flag}{TRUE if the division only appears in one election}
#'
#' @export
#' @examples
#' \donttest{
#' op <- options(readaec.cache_dir = tempdir())
#' # National swing 2019 to 2022
#' get_swing(2019, 2022)
#'
#' # Teal seats in Victoria
#' get_swing(2019, 2022, state = "VIC")
#'
#' # A single seat
#' get_swing(2019, 2022, division = "Kooyong")
#'
#' # Long-run comparison
#' get_swing(2013, 2025)
#' options(op)
#' }
get_swing <- function(from, to, division = NULL, state = NULL, refresh = FALSE) {
  if (from >= to) {
    cli::cli_abort("'from' year must be earlier than 'to' year.")
  }

  from_data <- get_tpp(from, refresh = refresh)
  to_data   <- get_tpp(to, refresh = refresh)

  winners_from <- dplyr::select(
    get_members_elected(from, refresh = refresh),
    division_id = divisionid, winner_from = partyab
  )
  winners_to <- dplyr::select(
    get_members_elected(to, refresh = refresh),
    division_id = divisionid, winner_to = partyab
  )

  # Join on division_id — stable across redistributions unlike division name
  df <- dplyr::full_join(
    dplyr::select(from_data, division_id, state,
                  alp_pct_from = alp_pct, lnp_pct_from = lnp_pct),
    dplyr::select(to_data, division_id, division, state,
                  alp_pct_to = alp_pct, lnp_pct_to = lnp_pct),
    by = "division_id"
  )
  df <- dplyr::left_join(df, winners_from, by = "division_id")
  df <- dplyr::left_join(df, winners_to, by = "division_id")

  df <- dplyr::mutate(df,
    state         = dplyr::coalesce(state.y, state.x),
    alp_swing     = round(alp_pct_to - alp_pct_from, 2),
    lnp_swing     = round(lnp_pct_to - lnp_pct_from, 2),
    tpp_leader_from = dplyr::case_when(
      alp_pct_from > 50 ~ "ALP",
      lnp_pct_from > 50 ~ "LNP",
      TRUE ~ NA_character_
    ),
    tpp_leader_to = dplyr::case_when(
      alp_pct_to > 50 ~ "ALP",
      lnp_pct_to > 50 ~ "LNP",
      TRUE ~ NA_character_
    ),
    seat_changed          = !is.na(winner_from) & !is.na(winner_to) & winner_from != winner_to,
    redistribution_flag   = is.na(alp_pct_from) | is.na(alp_pct_to),
    year_from = from,
    year_to   = to
  )

  df <- dplyr::select(df, division, division_id, state,
                      alp_pct_from, alp_pct_to, alp_swing,
                      lnp_pct_from, lnp_pct_to, lnp_swing,
                      winner_from, winner_to,
                      tpp_leader_from, tpp_leader_to, seat_changed,
                      redistribution_flag, year_from, year_to)

  # Filters
  if (!is.null(state)) {
    df <- dplyr::filter(df, state == toupper(!!state))
  }

  if (!is.null(division)) {
    div_filter <- tolower(division)
    df <- dplyr::filter(df, tolower(.data$division) %in% div_filter)
  }

  df <- dplyr::arrange(df, dplyr::desc(abs(alp_swing)))
  df
}
