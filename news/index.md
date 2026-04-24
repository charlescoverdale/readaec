# Changelog

## readaec 0.1.3

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
