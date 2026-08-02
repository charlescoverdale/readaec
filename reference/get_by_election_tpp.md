# Get by-election two-party preferred votes by polling place

Note that TPP figures are only meaningful where the final two candidates
were ALP and Coalition. In by-elections decided between other candidates
(such as Farrer in 2026), use
[`get_by_election_tcp()`](https://charlescoverdale.github.io/readaec/reference/get_by_election_tcp.md)
instead.

## Usage

``` r
get_by_election_tpp(division, year = NULL, refresh = FALSE)
```

## Arguments

- division:

  Division name (e.g. "Farrer").

- year:

  By-election year. Only needed where a division has had more than one
  by-election (e.g. Mayo in 2008 and 2018).

- refresh:

  If `TRUE`, re-download from the AEC even if a cached copy exists.

## Value

A tidy data frame of TPP votes by polling place.

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
get_by_election_tpp("Dunkley")
#> Downloading from AEC: HouseTppByPollingPlaceDownload-29778.csv
#> # A tibble: 40 × 12
#>    stateab divisionid divisionnm pollingplaceid pollingplace             
#>    <chr>        <dbl> <chr>               <dbl> <chr>                    
#>  1 VIC            210 Dunkley              3956 Carrum Downs             
#>  2 VIC            210 Dunkley             31974 Carrum Downs Central     
#>  3 VIC            210 Dunkley             97535 Carrum Downs DUNKLEY PPVC
#>  4 VIC            210 Dunkley             64692 Carrum Downs North       
#>  5 VIC            210 Dunkley             31051 Carrum Downs South       
#>  6 VIC            210 Dunkley             97548 Carrum Downs West        
#>  7 VIC            210 Dunkley             65547 EAV Dunkley PPVC         
#>  8 VIC            210 Dunkley              3600 Frankston                
#>  9 VIC            210 Dunkley              3594 Frankston Central        
#> 10 VIC            210 Dunkley             36414 Frankston DUNKLEY PPVC   
#> # ℹ 30 more rows
#> # ℹ 7 more variables: `australian labor party votes` <dbl>,
#> #   `australian labor party percentage` <dbl>,
#> #   `liberal/national coalition votes` <dbl>,
#> #   `liberal/national coalition percentage` <dbl>, totalvotes <dbl>,
#> #   swing <dbl>, date <date>
options(op)
# }
```
