# Get by-election two-candidate preferred votes by polling place

Get by-election two-candidate preferred votes by polling place

## Usage

``` r
get_by_election_tcp(division, year = NULL, refresh = FALSE)
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

A tidy data frame of TCP votes by candidate by polling place.

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
get_by_election_tcp("Farrer")
#> Downloading from AEC: HouseTcpByCandidateByPollingPlaceDownload-31633.csv
#> # A tibble: 188 × 16
#>    stateab divisionid divisionnm pollingplaceid pollingplace candidateid surname
#>    <chr>        <dbl> <chr>               <dbl> <chr>              <dbl> <chr>  
#>  1 NSW            118 Farrer                746 Albury             40627 MILTHO…
#>  2 NSW            118 Farrer                746 Albury             42236 FARLEY 
#>  3 NSW            118 Farrer                748 Albury Cent…       40627 MILTHO…
#>  4 NSW            118 Farrer                748 Albury Cent…       42236 FARLEY 
#>  5 NSW            118 Farrer                747 Albury East        40627 MILTHO…
#>  6 NSW            118 Farrer                747 Albury East        42236 FARLEY 
#>  7 NSW            118 Farrer                751 Albury North       40627 MILTHO…
#>  8 NSW            118 Farrer                751 Albury North       42236 FARLEY 
#>  9 NSW            118 Farrer              34273 Albury PPVC        40627 MILTHO…
#> 10 NSW            118 Farrer              34273 Albury PPVC        42236 FARLEY 
#> # ℹ 178 more rows
#> # ℹ 9 more variables: givennm <chr>, ballotposition <dbl>, elected <chr>,
#> #   historicelected <chr>, partyab <chr>, partynm <chr>, ordinaryvotes <dbl>,
#> #   swing <dbl>, date <date>
options(op)
# }
```
