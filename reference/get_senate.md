# Get Senate first preference votes by state

Get Senate first preference votes by state

## Usage

``` r
get_senate(year)
```

## Arguments

- year:

  Election year. Use
  [`list_elections()`](https://charlescoverdale.github.io/readaec/reference/list_elections.md)
  to see available years.

## Value

A tidy data frame of Senate first preference votes by state.

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
get_senate(2022)
#> Downloading from AEC: SenateFirstPrefsByStateByVoteTypeDownload
#> # A tibble: 572 × 13
#>    stateab group candidateid ballotposition candidatedetails       partyname    
#>    <chr>   <chr>       <dbl>          <dbl> <chr>                  <chr>        
#>  1 ACT     A           37878              0 A Above-the-line Votes Australian L…
#>  2 ACT     A           36044              1 GALLAGHER, Katy        Australian L…
#>  3 ACT     A           36045              2 NORTHAM, Maddy         Australian L…
#>  4 ACT     B           37876              0 B Above-the-line Votes Sustainable …
#>  5 ACT     B           37241              1 ANGEL, Joy             Sustainable …
#>  6 ACT     B           37248              2 HAYDON, John           Sustainable …
#>  7 ACT     C           37873              0 C Above-the-line Votes United Austr…
#>  8 ACT     C           36097              1 SAVOULIDIS, James      United Austr…
#>  9 ACT     C           36098              2 PAGE, Tracey           United Austr…
#> 10 ACT     D           37881              0 D Above-the-line Votes Liberal      
#> # ℹ 562 more rows
#> # ℹ 7 more variables: ordinaryvotes <dbl>, absentvotes <dbl>,
#> #   provisionalvotes <dbl>, prepollvotes <dbl>, postalvotes <dbl>,
#> #   totalvotes <dbl>, year <dbl>
options(op)
# }
```
