# readaec 0.2.0

## New data

* By-election support: `list_by_elections()` plus `get_by_election_fp()`,
  `get_by_election_tcp()`, `get_by_election_tpp()`, and
  `get_by_election_candidates()`. Covers all 24 House by-elections with AEC
  CSV downloads, from Gippsland 2008 to Farrer 2026.
* Referendum support: `list_referendums()`, `get_referendum_by_booth()`, and
  `get_referendum_turnout()` for the 2023 Voice referendum, including
  booth-level Yes/No counts.
* `get_dop()` returns the full count-by-count distribution of preferences by
  division, the dataset needed to analyse seats won from behind on
  preference flows.
* `get_tcp_by_booth()` returns two-candidate preferred votes by polling
  place.
* `get_senators_elected()` returns senators elected in order of election.

## Improvements and fixes

* `get_swing()` now reports the party that actually won each seat
  (`winner_from`, `winner_to`), joined from the AEC members elected file.
  Previously winners were inferred from TPP shares, which misidentified
  seats won by independents and minor parties. The TPP-based columns are
  retained as `tpp_leader_from` and `tpp_leader_to`.
* All data functions gain a `refresh` argument to force a re-download,
  useful on election night when cached counts go stale.
* HTTP failures now produce a readable error with the status code.
  Previously the status check was unreachable because 'httr2' errors on
  non-200 responses before the check ran.
* Downloads are written to a temporary file and only moved into the cache
  once complete, so an interrupted download can no longer leave a corrupt
  file that is served from cache indefinitely.
* Requests now identify the package via a user agent and retry up to three
  times on transient failures.
* Column types are now guessed from the whole file rather than the first
  1000 rows, fixing parsing warnings on `get_polling_places()`.

# readaec 0.1.3 (not released)

* Added HTTP status validation to `get_fp_by_booth()` for consistency with
  other data functions.

# readaec 0.1.2

* Examples now cache to `tempdir()` instead of the user's home directory,
  fixing CRAN policy compliance for `\donttest` examples.
* Cache directory is now configurable via `options(readaec.cache_dir = ...)`.
* Replaced `rappdirs` dependency with `tools::R_user_dir()` (base R).

# readaec 0.1.1

* Added AEC web service URL to DESCRIPTION per CRAN policy
* Added `\value` documentation to `clear_cache()`
* Changed `\dontrun{}` to `\donttest{}` in all examples that require a network connection

# readaec 0.1.0

* Initial CRAN release.
* Functions for accessing House of Representatives data: `get_fp()`, `get_tpp()`, `get_tcp()`, `get_members_elected()`.
* Booth-level functions: `get_fp_by_booth()`, `get_tpp_by_booth()`.
* Senate data: `get_senate()`.
* Candidate and enrolment data: `get_candidates()`, `get_enrolment()`, `get_turnout()`, `get_polling_places()`.
* Cross-election swing analysis: `get_swing()`.
* Local caching via `rappdirs` with `clear_cache()`.
* Data available for federal elections 2007–2025.
