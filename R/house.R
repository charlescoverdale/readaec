# House of Representatives ------------------------------------------------

#' Get first preference votes by division
#'
#' @param year Election year. Use [list_elections()] to see available years.
#' @param refresh If `TRUE`, re-download from the AEC even if a cached copy
#'   exists. Useful on election night when counts are still updating.
#' @return A tidy data frame of first preference votes by division.
#' @export
#' @examples
#' \donttest{
#' op <- options(readaec.cache_dir = tempdir())
#' get_fp(2022)
#' options(op)
#' }
get_fp <- function(year, refresh = FALSE) {
  event_id <- year_to_event_id(year)
  df <- aec_fetch(event_id, "HouseFirstPrefsByCandidateByVoteTypeDownload", refresh)
  df <- dplyr::rename_with(df, tolower)
  df <- dplyr::rename(df,
    division = divisionnm,
    division_id = divisionid,
    state = stateab,
    surname = surname,
    given_name = givennm,
    party = partyab,
    party_name = partynm,
    total_votes = totalvotes
  )
  df$year <- year
  df
}

#' Get two-party preferred votes by division
#'
#' @inheritParams get_fp
#' @return A tidy data frame of TPP votes by division.
#' @export
#' @examples
#' \donttest{
#' op <- options(readaec.cache_dir = tempdir())
#' get_tpp(2022)
#' options(op)
#' }
get_tpp <- function(year, refresh = FALSE) {
  event_id <- year_to_event_id(year)
  df <- aec_fetch(event_id, "HouseTppByDivisionDownload", refresh)
  df <- dplyr::rename_with(df, tolower)
  df <- dplyr::rename(df,
    division = divisionnm,
    division_id = divisionid,
    state = stateab,
    party = partyab,
    lnp_votes = `liberal/national coalition votes`,
    lnp_pct = `liberal/national coalition percentage`,
    alp_votes = `australian labor party votes`,
    alp_pct = `australian labor party percentage`,
    total_votes = totalvotes,
    swing = swing
  )
  df$year <- year
  df
}

#' Get two-candidate preferred votes by division
#'
#' @inheritParams get_fp
#' @return A tidy data frame of TCP votes by division.
#' @export
#' @examples
#' \donttest{
#' op <- options(readaec.cache_dir = tempdir())
#' get_tcp(2022)
#' options(op)
#' }
get_tcp <- function(year, refresh = FALSE) {
  event_id <- year_to_event_id(year)
  df <- aec_fetch(event_id, "HouseTcpByCandidateByVoteTypeDownload", refresh)
  df <- dplyr::rename_with(df, tolower)
  df <- dplyr::rename(df,
    division = divisionnm,
    division_id = divisionid,
    state = stateab,
    surname = surname,
    given_name = givennm,
    party = partyab,
    party_name = partynm,
    total_votes = totalvotes
  )
  df$year <- year
  df
}

#' Get the full distribution of preferences by division
#'
#' Returns the count-by-count distribution of preferences for every division:
#' each exclusion round, the candidate excluded, and where their preferences
#' flowed. This is the dataset for analysing seats won from second or third
#' place on preference flows, which division-level TPP and TCP figures
#' cannot show.
#'
#' @inheritParams get_fp
#' @return A tidy data frame with one row per candidate per count per
#'   division, including `countnumber`, `calculationtype`
#'   (preference count, transfer count, and percentages), and
#'   `calculationvalue`.
#' @export
#' @examples
#' \donttest{
#' op <- options(readaec.cache_dir = tempdir())
#' dop <- get_dop(2025)
#'
#' # Final count in a single seat
#' mel <- subset(dop, division == "Melbourne")
#' subset(mel, countnumber == max(countnumber))
#' options(op)
#' }
get_dop <- function(year, refresh = FALSE) {
  event_id <- year_to_event_id(year)
  df <- aec_fetch(event_id, "HouseDopByDivisionDownload", refresh)
  df <- dplyr::rename_with(df, tolower)
  df <- dplyr::rename(df,
    division = divisionnm,
    division_id = divisionid,
    state = stateab,
    given_name = givennm,
    party = partyab,
    party_name = partynm
  )
  df$year <- year
  df
}

#' Get first preference votes by polling place
#'
#' @inheritParams get_fp
#' @param state Filter to a specific state (e.g. "VIC"). NULL returns all states.
#' @return A tidy data frame of first preference votes by polling place.
#' @export
#' @examples
#' \donttest{
#' op <- options(readaec.cache_dir = tempdir())
#' get_fp_by_booth(2022, state = "VIC")
#' options(op)
#' }
get_fp_by_booth <- function(year, state = NULL, refresh = FALSE) {
  event_id <- year_to_event_id(year)

  if (is.null(state)) {
    # Download all states and bind
    states <- c("NSW", "VIC", "QLD", "WA", "SA", "TAS", "ACT", "NT")
    cli::cli_inform("Downloading booth data for all states...")
    df <- dplyr::bind_rows(lapply(states, function(s) {
      get_fp_by_booth(year, state = s, refresh = refresh)
    }))
    return(df)
  }

  state <- toupper(state)
  valid_states <- c("NSW", "VIC", "QLD", "WA", "SA", "TAS", "ACT", "NT")
  if (!state %in% valid_states) {
    cli::cli_abort("Invalid state {state}. Must be one of: {valid_states}")
  }
  filename <- paste0(
    "HouseStateFirstPrefsByPollingPlaceDownload-", event_id, "-", state
  )
  url <- glue::glue(
    "https://results.aec.gov.au/{event_id}/Website/Downloads/{filename}.csv"
  )
  df <- aec_download(url, paste0(filename, ".csv"), refresh)

  df <- dplyr::rename_with(df, tolower)
  df$year <- year
  df
}

#' Get two-candidate preferred votes by polling place
#'
#' @inheritParams get_fp
#' @return A tidy data frame of TCP votes by candidate by polling place.
#' @export
#' @examples
#' \donttest{
#' op <- options(readaec.cache_dir = tempdir())
#' get_tcp_by_booth(2022)
#' options(op)
#' }
get_tcp_by_booth <- function(year, refresh = FALSE) {
  event_id <- year_to_event_id(year)
  df <- aec_fetch(event_id, "HouseTcpByCandidateByPollingPlaceDownload", refresh)
  df <- dplyr::rename_with(df, tolower)
  df$year <- year
  df
}

#' Get two-party preferred votes by polling place
#'
#' @inheritParams get_fp
#' @return A tidy data frame of TPP votes by polling place.
#' @export
#' @examples
#' \donttest{
#' op <- options(readaec.cache_dir = tempdir())
#' get_tpp_by_booth(2022)
#' options(op)
#' }
get_tpp_by_booth <- function(year, refresh = FALSE) {
  event_id <- year_to_event_id(year)
  df <- aec_fetch(event_id, "HouseTppByPollingPlaceDownload", refresh)
  df <- dplyr::rename_with(df, tolower)
  df$year <- year
  df
}

#' Get members elected to the House of Representatives
#'
#' @inheritParams get_fp
#' @return A tidy data frame of elected members.
#' @export
#' @examples
#' \donttest{
#' op <- options(readaec.cache_dir = tempdir())
#' get_members_elected(2022)
#' options(op)
#' }
get_members_elected <- function(year, refresh = FALSE) {
  event_id <- year_to_event_id(year)
  df <- aec_fetch(event_id, "HouseMembersElectedDownload", refresh)
  df <- dplyr::rename_with(df, tolower)
  df$year <- year
  df
}
