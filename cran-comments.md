# CRAN submission comments — readaec 0.1.2

## Resubmission

This is a resubmission of readaec 0.1.1. Changes since 0.1.1:

* Examples now cache to `tempdir()` instead of the user's home directory,
  fixing CRAN policy compliance for `\donttest` examples.
* Cache directory is now configurable via `options(readaec.cache_dir = ...)`.
* Replaced `rappdirs` dependency with `tools::R_user_dir()` (base R).

## Changes since 0.1.0 (addressing initial CRAN review feedback)

* Added AEC web service URL `<https://results.aec.gov.au>` to DESCRIPTION
* Added `\value` documentation to `clear_cache()`
* Replaced `\dontrun{}` with `\donttest{}` in all network-dependent examples

## Test environments

* macOS 15 Sequoia (aarch64), R 4.5.2 — local

## R CMD check results

0 errors | 0 warnings | 0 notes

## Notes on internet access

All data-fetching functions download CSV files from the Australian Electoral
Commission's public results website <https://results.aec.gov.au>. Files are
cached locally using `tools::R_user_dir()` after the first download. All
examples that make network requests are wrapped in `\donttest{}`, with
caching redirected to `tempdir()` so that no files are written to the user's
home filespace.

## Downstream dependencies

None.
