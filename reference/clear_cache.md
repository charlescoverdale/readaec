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

## Details

Cached files are reused for 30 days and then downloaded again. Set
`options(readaec.cache_ttl = )` to a different number of hours to change
this, or pass `refresh = TRUE` to any download function to force a fresh
copy. The cache location can be changed with
`options(readaec.cache_dir = )`.

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
clear_cache()
#> Warning: cannot remove file '/tmp/Rtmp5ZJ1jw/bslib-7db53ff92ec092c0dbca0588320fd109', reason 'Directory not empty'
#> Warning: cannot remove file '/tmp/Rtmp5ZJ1jw/downlit', reason 'Directory not empty'
#> Cleared 3 cached files.
options(op)
# }
```
