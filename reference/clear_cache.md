# Clear the local AEC data cache

Deletes all files downloaded and cached by readaec. The next function
call will re-download fresh data from the AEC.

## Usage

``` r
clear_cache()
```

## Value

Invisibly returns `NULL`. Called for its side effect of deleting cached
files.

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
clear_cache()
#> Warning: cannot remove file '/tmp/Rtmp5wphst/bslib-246362e7e3ff6191071d5f9b40ba8d62', reason 'Directory not empty'
#> Warning: cannot remove file '/tmp/Rtmp5wphst/downlit', reason 'Directory not empty'
#> Cleared 3 cached files.
options(op)
# }
```
