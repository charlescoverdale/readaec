# Get by-election candidates

Get by-election candidates

## Usage

``` r
get_by_election_candidates(division, year = NULL, refresh = FALSE)
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

A tidy data frame of candidates.

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
get_by_election_candidates("Farrer")
#> Downloading from AEC: HouseCandidatesDownload-31633.csv
#> # A tibble: 12 × 11
#>    stateab divisionid divisionnm partyab partynm     candidateid surname givennm
#>    <chr>        <dbl> <chr>      <chr>   <chr>             <dbl> <chr>   <chr>  
#>  1 NSW            118 Farrer     GRPF    Gerard Ren…       42230 BONNEF… Jamie  
#>  2 NSW            118 Farrer     LP      Liberal           42234 BUTKOW… Raissa 
#>  3 NSW            118 Farrer     SPP     Affordable…       42238 ELLIS   Lucas …
#>  4 NSW            118 Farrer     ON      One Nation        42236 FARLEY  David  
#>  5 NSW            118 Farrer     GRN     The Greens        42232 HENDRIE Richar…
#>  6 NSW            118 Farrer     IND     Independent       40627 MILTHO… Michel…
#>  7 NSW            118 Farrer     IND     Independent       42237 PAPPIN  Gary J…
#>  8 NSW            118 Farrer     HMP     Legalise C…       42233 PEARSON Aimee …
#>  9 NSW            118 Farrer     NP      The Nation…       42235 ROBERT… Brad   
#> 10 NSW            118 Farrer     FFPA    Family Fir…       42231 SCRIVEN Rebecca
#> 11 NSW            118 Farrer     ASP     Shooters, …       42239 SINCLA… Peter  
#> 12 NSW            118 Farrer     IND     Independent       42229 WOODWA… Roger  
#> # ℹ 3 more variables: elected <chr>, historicelected <chr>, date <date>
options(op)
# }
```
