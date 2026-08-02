# Get by-election first preference votes by polling place

By-election results are published at polling place level. Use
[`list_by_elections()`](https://charlescoverdale.github.io/readaec/reference/list_by_elections.md)
to see which by-elections are available.

## Usage

``` r
get_by_election_fp(division, year = NULL, refresh = FALSE)
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

A tidy data frame of first preference votes by polling place.

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
get_by_election_fp("Farrer")
#> Downloading from AEC: HouseStateFirstPrefsByPollingPlaceDownload-31633-NSW.csv
#> # A tibble: 1,222 × 16
#>    stateab divisionid divisionnm pollingplaceid pollingplace candidateid surname
#>    <chr>        <dbl> <chr>               <dbl> <chr>              <dbl> <chr>  
#>  1 NSW            118 Farrer                746 Albury             42234 BUTKOW…
#>  2 NSW            118 Farrer                746 Albury             40627 MILTHO…
#>  3 NSW            118 Farrer                746 Albury             42230 BONNEF…
#>  4 NSW            118 Farrer                746 Albury             42235 ROBERT…
#>  5 NSW            118 Farrer                746 Albury             42233 PEARSON
#>  6 NSW            118 Farrer                746 Albury             42232 HENDRIE
#>  7 NSW            118 Farrer                746 Albury             42229 WOODWA…
#>  8 NSW            118 Farrer                746 Albury             42236 FARLEY 
#>  9 NSW            118 Farrer                746 Albury             42231 SCRIVEN
#> 10 NSW            118 Farrer                746 Albury             42238 ELLIS  
#> # ℹ 1,212 more rows
#> # ℹ 9 more variables: givennm <chr>, ballotposition <dbl>, elected <chr>,
#> #   historicelected <chr>, partyab <chr>, partynm <chr>, ordinaryvotes <dbl>,
#> #   swing <dbl>, date <date>
options(op)
# }
```
