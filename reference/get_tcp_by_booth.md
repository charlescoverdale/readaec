# Get two-candidate preferred votes by polling place

Get two-candidate preferred votes by polling place

## Usage

``` r
get_tcp_by_booth(year, refresh = FALSE)
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

A tidy data frame of TCP votes by candidate by polling place.

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
get_tcp_by_booth(2022)
#> Downloading from AEC: HouseTcpByCandidateByPollingPlaceDownload-27966.csv
#> # A tibble: 16,958 × 16
#>    stateab divisionid divisionnm pollingplaceid pollingplace candidateid surname
#>    <chr>        <dbl> <chr>               <dbl> <chr>              <dbl> <chr>  
#>  1 ACT            318 Bean                93925 Belconnen B…       36231 SMITH  
#>  2 ACT            318 Bean                93925 Belconnen B…       37198 HIATT  
#>  3 ACT            318 Bean                11877 Bonython           36231 SMITH  
#>  4 ACT            318 Bean                11877 Bonython           37198 HIATT  
#>  5 ACT            318 Bean                11452 Calwell            36231 SMITH  
#>  6 ACT            318 Bean                11452 Calwell            37198 HIATT  
#>  7 ACT            318 Bean                 8761 Chapman            36231 SMITH  
#>  8 ACT            318 Bean                 8761 Chapman            37198 HIATT  
#>  9 ACT            318 Bean                 8763 Chisholm           36231 SMITH  
#> 10 ACT            318 Bean                 8763 Chisholm           37198 HIATT  
#> # ℹ 16,948 more rows
#> # ℹ 9 more variables: givennm <chr>, ballotposition <dbl>, elected <chr>,
#> #   historicelected <chr>, partyab <chr>, partynm <chr>, ordinaryvotes <dbl>,
#> #   swing <dbl>, year <dbl>
options(op)
# }
```
