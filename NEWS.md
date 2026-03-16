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
