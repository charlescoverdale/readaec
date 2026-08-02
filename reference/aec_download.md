# Download a file from the AEC, with caching

Downloads are written to a temporary file first and only moved into the
cache once complete, so a failed download never leaves a corrupt file
behind. Requests identify the package, retry on transient failures, and
report HTTP errors with the status code.

## Usage

``` r
aec_download(url, basename, refresh = FALSE)
```
