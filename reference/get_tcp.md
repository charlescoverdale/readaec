# Get two-candidate preferred votes by division

Get two-candidate preferred votes by division

## Usage

``` r
get_tcp(year)
```

## Arguments

- year:

  Election year. Use
  [`list_elections()`](https://charlescoverdale.github.io/readaec/reference/list_elections.md)
  to see available years.

## Value

A tidy data frame of TCP votes by division.

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
get_tcp(2022)
#> Downloading from AEC: HouseTcpByCandidateByVoteTypeDownload
#> # A tibble: 302 × 19
#>    state division_id division candidateid surname given_name ballotposition
#>    <chr>       <dbl> <chr>          <dbl> <chr>   <chr>               <dbl>
#>  1 ACT           318 Bean           36231 SMITH   David                   3
#>  2 ACT           318 Bean           37198 HIATT   Jane                    6
#>  3 ACT           101 Canberra       36241 HOLLO   Tim                     5
#>  4 ACT           101 Canberra       36228 PAYNE   Alicia                  6
#>  5 ACT           102 Fenner         36234 LEIGH   Andrew                  1
#>  6 ACT           102 Fenner         37203 KUSTER  Nathan                  2
#>  7 NSW           103 Banks          37018 COLEMAN David                   1
#>  8 NSW           103 Banks          36774 SOON    Zhi                     7
#>  9 NSW           104 Barton         36820 BURNEY  Linda                   1
#> 10 NSW           104 Barton         37017 GOODY   John                    4
#> # ℹ 292 more rows
#> # ℹ 12 more variables: elected <chr>, historicelected <chr>, party <chr>,
#> #   party_name <chr>, ordinaryvotes <dbl>, absentvotes <dbl>,
#> #   provisionalvotes <dbl>, prepollvotes <dbl>, postalvotes <dbl>,
#> #   total_votes <dbl>, swing <dbl>, year <dbl>
options(op)
# }
```
