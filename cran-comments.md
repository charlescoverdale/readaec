# CRAN submission comments — readaec 0.2.0

## Release summary

Feature release. Adds by-election results (24 House by-elections, 2008 to
2026), 2023 referendum results, the full distribution of preferences,
booth-level two-candidate preferred, and senators elected. Also fixes error
handling on failed downloads, prevents interrupted downloads from leaving
corrupt cache files, and corrects seat-winner identification in
`get_swing()` for seats won by independents and minor parties.

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
home filespace. Network-dependent tests are skipped on CRAN via
`skip_on_cran()`.

## Downstream dependencies

None.
