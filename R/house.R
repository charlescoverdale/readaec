# House of Representatives ------------------------------------------------

#' Get first preference votes by division
#'
#' @param year Election year. Use [list_elections()] to see available years.
#' @return A tidy data frame of first preference votes by division.
#' @export
#' @examples
#' \donttest{
#' get_fp(2022)
#' }
get_fp <- function(year) {
  event_id <- year_to_event_id(year)
  df <- aec_fetch(event_id, "HouseFirstPrefsByCandidateByVoteTypeDownload")
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
#' @param year Election year. Use [list_elections()] to see available years.
#' @return A tidy data frame of TPP votes by division.
#' @export
#' @examples
#' \donttest{
#' get_tpp(2022)
#' }
get_tpp <- function(year) {
  event_id <- year_to_event_id(year)
  df <- aec_fetch(event_id, "HouseTppByDivisionDownload")
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
#' @param year Election year. Use [list_elections()] to see available years.
#' @return A tidy data frame of TCP votes by division.
#' @export
#' @examples
#' \donttest{
#' get_tcp(2022)
#' }
get_tcp <- function(year) {
  event_id <- year_to_event_id(year)
  df <- aec_fetch(event_id, "HouseTcpByCandidateByVoteTypeDownload")
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

#' Get first preference votes by polling place
#'
#' @param year Election year. Use [list_elections()] to see available years.
#' @param state Filter to a specific state (e.g. "VIC"). NULL returns all states.
#' @return A tidy data frame of first preference votes by polling place.
#' @export
#' @examples
#' \donttest{
#' get_fp_by_booth(2022, state = "VIC")
#' }
get_fp_by_booth <- function(year, state = NULL) {
  event_id <- year_to_event_id(year)

  if (!is.null(state)) {
    state <- toupper(state)
    valid_states <- c("NSW", "VIC", "QLD", "WA", "SA", "TAS", "ACT", "NT")
    if (!state %in% valid_states) {
      cli::cli_abort("Invalid state {state}. Must be one of: {valid_states}")
    }
    filename <- paste0("HouseStateFirstPrefsByPollingPlaceDownload-", event_id, "-", state)
    url <- glue::glue("https://results.aec.gov.au/{event_id}/Website/Downloads/{filename}.csv")
    cache_file <- file.path(aec_cache_dir(), paste0(filename, ".csv"))

    if (file.exists(cache_file)) {
      cli::cli_inform("Loading from cache: {filename}")
    } else {
      cli::cli_inform("Downloading from AEC: {filename}")
      req <- httr2::request(url)
      resp <- httr2::req_perform(req)
      writeBin(httr2::resp_body_raw(resp), cache_file)
    }
    df <- readr::read_csv(cache_file, skip = 1, show_col_types = FALSE)
  } else {
    # Download all states and bind
    states <- c("NSW", "VIC", "QLD", "WA", "SA", "TAS", "ACT", "NT")
    cli::cli_inform("Downloading booth data for all states...")
    df <- dplyr::bind_rows(lapply(states, function(s) {
      get_fp_by_booth(year, state = s)
    }))
    return(df)
  }

  df <- dplyr::rename_with(df, tolower)
  df$year <- year
  df
}

#' Get two-party preferred votes by polling place
#'
#' @param year Election year. Use [list_elections()] to see available years.
#' @return A tidy data frame of TPP votes by polling place.
#' @export
#' @examples
#' \donttest{
#' get_tpp_by_booth(2022)
#' }
get_tpp_by_booth <- function(year) {
  event_id <- year_to_event_id(year)
  df <- aec_fetch(event_id, "HouseTppByPollingPlaceDownload")
  df <- dplyr::rename_with(df, tolower)
  df$year <- year
  df
}

#' Get members elected to the House of Representatives
#'
#' @param year Election year. Use [list_elections()] to see available years.
#' @return A tidy data frame of elected members.
#' @export
#' @examples
#' \donttest{
#' get_members_elected(2022)
#' }
get_members_elected <- function(year) {
  event_id <- year_to_event_id(year)
  df <- aec_fetch(event_id, "HouseMembersElectedDownload")
  df <- dplyr::rename_with(df, tolower)
  df$year <- year
  df
}
