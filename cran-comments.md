# CRAN submission comments — readaec 0.1.0

## Test environments

* macOS 14 (aarch64), R 4.5.0 — local
* win-builder (R-devel) — remote
* GitHub Actions: ubuntu-latest, R release

## R CMD check results

0 errors | 0 warnings | 1 note

The one NOTE is:

    checking for hidden files and directories ... NOTE
    Found the following hidden files and directories: .github

This is expected. `.github` contains only CI workflow files and is excluded
from the build tarball via `.Rbuildignore`.

## Notes on internet access

All data-fetching functions download CSV files from the Australian Electoral
Commission's public results website (results.aec.gov.au). Files are cached
locally in the user's app data directory (via `rappdirs`) after the first
download. All examples that make network requests are wrapped in `\dontrun{}`.

## Downstream dependencies

None — this is a new package.
