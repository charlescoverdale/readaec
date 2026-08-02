# Get first preference votes by polling place

Get first preference votes by polling place

## Usage

``` r
get_fp_by_booth(year, state = NULL, refresh = FALSE)
```

## Arguments

- year:

  Election year. Use
  [`list_elections()`](https://charlescoverdale.github.io/readaec/reference/list_elections.md)
  to see available years.

- state:

  Filter to a specific state (e.g. "VIC"). NULL returns all states.

- refresh:

  If `TRUE`, re-download from the AEC even if a cached copy exists.
  Useful on election night when counts are still updating.

## Value

A tidy data frame of first preference votes by polling place.

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
get_fp_by_booth(2022, state = "VIC")
#> Downloading from AEC: HouseStateFirstPrefsByPollingPlaceDownload-27966-VIC.csv
#> # A tibble: 18,322 × 16
#>    stateab divisionid divisionnm pollingplaceid pollingplace candidateid surname
#>    <chr>        <dbl> <chr>               <dbl> <chr>              <dbl> <chr>  
#>  1 VIC            197 Aston                2942 Bayswater          35983 SPELMAN
#>  2 VIC            197 Aston                2942 Bayswater          36704 TUDGE  
#>  3 VIC            197 Aston                2942 Bayswater          36489 COOKSON
#>  4 VIC            197 Aston                2942 Bayswater          36181 BRUCE  
#>  5 VIC            197 Aston                2942 Bayswater          37636 IBBOTS…
#>  6 VIC            197 Aston                2942 Bayswater          36938 ROCHE  
#>  7 VIC            197 Aston                2942 Bayswater          36377 DOYLE  
#>  8 VIC            197 Aston                2942 Bayswater            999 Inform…
#>  9 VIC            197 Aston               83798 Bayswater S…       35983 SPELMAN
#> 10 VIC            197 Aston               83798 Bayswater S…       36704 TUDGE  
#> # ℹ 18,312 more rows
#> # ℹ 9 more variables: givennm <chr>, ballotposition <dbl>, elected <chr>,
#> #   historicelected <chr>, partyab <chr>, partynm <chr>, ordinaryvotes <dbl>,
#> #   swing <dbl>, year <dbl>
options(op)
# }
```
