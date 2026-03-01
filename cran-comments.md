# CRAN submission comments — readaec 0.1.0

## Test environments

* macOS 15 Sequoia (aarch64), R 4.5.2 — local
* win-builder (R-devel) — remote
* GitHub Actions: ubuntu-latest, R release

## R CMD check results

0 errors | 0 warnings | 3 notes

### NOTE 1: New submission

    Maintainer: 'Charles Coverdale <charlesfcoverdale@gmail.com>'
    New submission

Expected for a first CRAN submission.

### NOTE 2: pandoc not installed locally

    checking top-level files ... NOTE
    Files 'README.md' or 'NEWS.md' cannot be checked without 'pandoc' being installed.

Local environment does not have pandoc in PATH. CRAN's check servers have pandoc
installed and will check these files without issue.

### NOTE 3: Old HTML Tidy

    checking HTML version of manual ... NOTE
    Skipping checking HTML validation: 'tidy' doesn't look like recent enough HTML Tidy.

Local HTML Tidy binary is outdated. CRAN's check servers run a current version.

## Notes on internet access

All data-fetching functions download CSV files from the Australian Electoral
Commission's public results website (results.aec.gov.au). Files are cached
locally in the user's app data directory (via `rappdirs`) after the first
download. All examples that make network requests are wrapped in `\dontrun{}`.

## Downstream dependencies

None — this is a new package.
