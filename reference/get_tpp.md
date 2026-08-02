# Get two-party preferred votes by division

Get two-party preferred votes by division

## Usage

``` r
get_tpp(year, refresh = FALSE)
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

A tidy data frame of TPP votes by division.

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
get_tpp(2022)
#> Loading from cache: HouseTppByDivisionDownload-27966.csv
#> # A tibble: 151 × 11
#>    division  division_id state party lnp_votes lnp_pct alp_votes alp_pct
#>    <chr>           <dbl> <chr> <chr>     <dbl>   <dbl>     <dbl>   <dbl>
#>  1 Adelaide          179 SA    ALP       42948    38.1     69816    61.9
#>  2 Aston             197 VIC   LP        51840    52.8     46320    47.2
#>  3 Ballarat          198 VIC   ALP       35730    37.0     60770    63.0
#>  4 Banks             103 NSW   LP        48969    53.2     43076    46.8
#>  5 Barker            180 SA    LP        70483    66.6     35316    33.4
#>  6 Barton            104 NSW   ALP       31569    34.5     60054    65.5
#>  7 Bass              192 TAS   LP        35288    51.4     33321    48.6
#>  8 Bean              318 ACT   ALP       36459    37.0     61935    63.0
#>  9 Bendigo           200 VIC   ALP       37811    37.9     61968    62.1
#> 10 Bennelong         105 NSW   ALP       48847    49.0     50801    51.0
#> # ℹ 141 more rows
#> # ℹ 3 more variables: total_votes <dbl>, swing <dbl>, year <dbl>
options(op)
# }
```
