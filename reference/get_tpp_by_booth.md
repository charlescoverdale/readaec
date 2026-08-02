# Get two-party preferred votes by polling place

Get two-party preferred votes by polling place

## Usage

``` r
get_tpp_by_booth(year, refresh = FALSE)
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

A tidy data frame of TPP votes by polling place.

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
get_tpp_by_booth(2022)
#> Downloading from AEC: HouseTppByPollingPlaceDownload-27966.csv
#> # A tibble: 8,479 × 12
#>    stateab divisionid divisionnm pollingplaceid pollingplace       
#>    <chr>        <dbl> <chr>               <dbl> <chr>              
#>  1 ACT            318 Bean                93925 Belconnen BEAN PPVC
#>  2 ACT            318 Bean                11877 Bonython           
#>  3 ACT            318 Bean                11452 Calwell            
#>  4 ACT            318 Bean                 8761 Chapman            
#>  5 ACT            318 Bean                 8763 Chisholm           
#>  6 ACT            318 Bean                93916 City (Bean)        
#>  7 ACT            318 Bean                93922 City BEAN PPVC     
#>  8 ACT            318 Bean                31298 Conder             
#>  9 ACT            318 Bean                83835 Conder North       
#> 10 ACT            318 Bean                82523 Coombs             
#> # ℹ 8,469 more rows
#> # ℹ 7 more variables: `liberal/national coalition votes` <dbl>,
#> #   `liberal/national coalition percentage` <dbl>,
#> #   `australian labor party votes` <dbl>,
#> #   `australian labor party percentage` <dbl>, totalvotes <dbl>, swing <dbl>,
#> #   year <dbl>
options(op)
# }
```
