# CRAN submission comments — readaec 0.1.1

## Changes since 0.1.0 (addressing CRAN review feedback)

* Added AEC web service URL `<https://results.aec.gov.au>` to DESCRIPTION
* Added `\value` documentation to `clear_cache()`
* Replaced `\dontrun{}` with `\donttest{}` in all network-dependent examples

## Test environments

* macOS 15 Sequoia (aarch64), R 4.5.2 — local
* win-builder (R-devel) — remote
* win-builder (R-release) — remote

## R CMD check results

0 errors | 0 warnings | 2 notes

### NOTE 1: New submission

Expected for a first CRAN submission.

### NOTE 2: Old HTML Tidy

Local HTML Tidy binary is outdated. CRAN's check servers run a current version.

## Notes on internet access

All data-fetching functions download CSV files from the Australian Electoral
Commission's public results website <https://results.aec.gov.au>. Files are
cached locally in the user's app data directory (via `rappdirs`) after the
first download. All examples that make network requests are wrapped in
`\donttest{}`.

## Downstream dependencies

None.
