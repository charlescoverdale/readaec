# Get first preference votes by division

Get first preference votes by division

## Usage

``` r
get_fp(year, refresh = FALSE)
```

## Arguments

- year:

  Election year. Use
  [`list_elections()`](https://charlescoverdale.github.io/readaec/reference/list_elections.md)
  to see available years.

- refresh:

  If `TRUE`, re-download from the AEC even if a cached copy exists.
  Useful on election night when counts are still updating.

## Value

A tidy data frame of first preference votes by division.

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
get_fp(2022)
#> Downloading from AEC: HouseFirstPrefsByCandidateByVoteTypeDownload-27966.csv
#> # A tibble: 1,354 × 19
#>    state division_id division candidateid surname  given_name   ballotposition
#>    <chr>       <dbl> <chr>          <dbl> <chr>    <chr>                 <dbl>
#>  1 ACT           318 Bean           36239 CONWAY   Sean                      1
#>  2 ACT           318 Bean           37455 AMBARD   Benjamin                  2
#>  3 ACT           318 Bean           36231 SMITH    David                     3
#>  4 ACT           318 Bean           32130 CHRISTIE Jamie                     4
#>  5 ACT           318 Bean           36243 SAVERY   Kathryn Jane              5
#>  6 ACT           318 Bean           37198 HIATT    Jane                      6
#>  7 ACT           318 Bean             999 Informal Informal                999
#>  8 ACT           101 Canberra       36238 SMITH    Catherine                 1
#>  9 ACT           101 Canberra       37456 MILES    James                     2
#> 10 ACT           101 Canberra       32830 BOHM     Tim                       3
#> # ℹ 1,344 more rows
#> # ℹ 12 more variables: elected <chr>, historicelected <chr>, party <chr>,
#> #   party_name <chr>, ordinaryvotes <dbl>, absentvotes <dbl>,
#> #   provisionalvotes <dbl>, prepollvotes <dbl>, postalvotes <dbl>,
#> #   total_votes <dbl>, swing <dbl>, year <dbl>
options(op)
# }
```
