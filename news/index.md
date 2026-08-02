# Changelog

## readaec 0.2.0

### New data

- By-election support:
  [`list_by_elections()`](https://charlescoverdale.github.io/readaec/reference/list_by_elections.md)
  plus
  [`get_by_election_fp()`](https://charlescoverdale.github.io/readaec/reference/get_by_election_fp.md),
  [`get_by_election_tcp()`](https://charlescoverdale.github.io/readaec/reference/get_by_election_tcp.md),
  [`get_by_election_tpp()`](https://charlescoverdale.github.io/readaec/reference/get_by_election_tpp.md),
  and
  [`get_by_election_candidates()`](https://charlescoverdale.github.io/readaec/reference/get_by_election_candidates.md).
  Covers all 24 House by-elections with AEC CSV downloads, from
  Gippsland 2008 to Farrer 2026.
- Referendum support:
  [`list_referendums()`](https://charlescoverdale.github.io/readaec/reference/list_referendums.md),
  [`get_referendum_by_booth()`](https://charlescoverdale.github.io/readaec/reference/get_referendum_by_booth.md),
  and
  [`get_referendum_turnout()`](https://charlescoverdale.github.io/readaec/reference/get_referendum_turnout.md)
  for the 2023 Voice referendum, including booth-level Yes/No counts.
- [`get_dop()`](https://charlescoverdale.github.io/readaec/reference/get_dop.md)
  returns the full count-by-count distribution of preferences by
  division, the dataset needed to analyse seats won from behind on
  preference flows.
- [`get_tcp_by_booth()`](https://charlescoverdale.github.io/readaec/reference/get_tcp_by_booth.md)
  returns two-candidate preferred votes by polling place.
- [`get_senators_elected()`](https://charlescoverdale.github.io/readaec/reference/get_senators_elected.md)
  returns senators elected in order of election.

### Improvements and fixes

- [`get_swing()`](https://charlescoverdale.github.io/readaec/reference/get_swing.md)
  now reports the party that actually won each seat (`winner_from`,
  `winner_to`), joined from the AEC members elected file. Previously
  winners were inferred from TPP shares, which misidentified seats won
  by independents and minor parties. The TPP-based columns are retained
  as `tpp_leader_from` and `tpp_leader_to`.
- All data functions gain a `refresh` argument to force a re-download,
  useful on election night when cached counts go stale.
- HTTP failures now produce a readable error with the status code.
  Previously the status check was unreachable because ‘httr2’ errors on
  non-200 responses before the check ran.
- Downloads are written to a temporary file and only moved into the
  cache once complete, so an interrupted download can no longer leave a
  corrupt file that is served from cache indefinitely.
- Requests now identify the package via a user agent and retry up to
  three times on transient failures.
- Column types are now guessed from the whole file rather than the first
  1000 rows, fixing parsing warnings on
  [`get_polling_places()`](https://charlescoverdale.github.io/readaec/reference/get_polling_places.md).

## readaec 0.1.3 (not released)

- Added HTTP status validation to
  [`get_fp_by_booth()`](https://charlescoverdale.github.io/readaec/reference/get_fp_by_booth.md)
  for consistency with other data functions.

## readaec 0.1.2

CRAN release: 2026-03-16

- Examples now cache to
  [`tempdir()`](https://rdrr.io/r/base/tempfile.html) instead of the
  user’s home directory, fixing CRAN policy compliance for `\donttest`
  examples.
- Cache directory is now configurable via
  `options(readaec.cache_dir = ...)`.
- Replaced `rappdirs` dependency with
  [`tools::R_user_dir()`](https://rdrr.io/r/tools/userdir.html) (base
  R).

## readaec 0.1.1

CRAN release: 2026-03-10

- Added AEC web service URL to DESCRIPTION per CRAN policy
- Added `\value` documentation to
  [`clear_cache()`](https://charlescoverdale.github.io/readaec/reference/clear_cache.md)
- Changed `\dontrun{}` to `\donttest{}` in all examples that require a
  network connection

## readaec 0.1.0

- Initial CRAN release.
- Functions for accessing House of Representatives data:
  [`get_fp()`](https://charlescoverdale.github.io/readaec/reference/get_fp.md),
  [`get_tpp()`](https://charlescoverdale.github.io/readaec/reference/get_tpp.md),
  [`get_tcp()`](https://charlescoverdale.github.io/readaec/reference/get_tcp.md),
  [`get_members_elected()`](https://charlescoverdale.github.io/readaec/reference/get_members_elected.md).
- Booth-level functions:
  [`get_fp_by_booth()`](https://charlescoverdale.github.io/readaec/reference/get_fp_by_booth.md),
  [`get_tpp_by_booth()`](https://charlescoverdale.github.io/readaec/reference/get_tpp_by_booth.md).
- Senate data:
  [`get_senate()`](https://charlescoverdale.github.io/readaec/reference/get_senate.md).
- Candidate and enrolment data:
  [`get_candidates()`](https://charlescoverdale.github.io/readaec/reference/get_candidates.md),
  [`get_enrolment()`](https://charlescoverdale.github.io/readaec/reference/get_enrolment.md),
  [`get_turnout()`](https://charlescoverdale.github.io/readaec/reference/get_turnout.md),
  [`get_polling_places()`](https://charlescoverdale.github.io/readaec/reference/get_polling_places.md).
- Cross-election swing analysis:
  [`get_swing()`](https://charlescoverdale.github.io/readaec/reference/get_swing.md).
- Local caching via `rappdirs` with
  [`clear_cache()`](https://charlescoverdale.github.io/readaec/reference/clear_cache.md).
- Data available for federal elections 2007–2025.
