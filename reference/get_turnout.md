# Get turnout by division

Get turnout by division

## Usage

``` r
get_turnout(year, refresh = FALSE)
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

A tidy data frame of turnout figures by division.

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
get_turnout(2022)
#> Downloading from AEC: HouseTurnoutByDivisionDownload-27966.csv
#> # A tibble: 151 × 8
#>    divisionid divisionnm stateab enrolment turnout turnoutpercentage
#>         <dbl> <chr>      <chr>       <dbl>   <dbl>             <dbl>
#>  1        179 Adelaide   SA         129960  117202              90.2
#>  2        197 Aston      VIC        109705  101480              92.5
#>  3        198 Ballarat   VIC        110570  101609              91.9
#>  4        103 Banks      NSW        107700   98595              91.6
#>  5        180 Barker     SA         123326  113708              92.2
#>  6        104 Barton     NSW        110371   99028              89.7
#>  7        192 Bass       TAS         79322   72933              92.0
#>  8        318 Bean       ACT        109432  101309              92.6
#>  9        200 Bendigo    VIC        112354  103543              92.2
#> 10        105 Bennelong  NSW        114942  105778              92.0
#> # ℹ 141 more rows
#> # ℹ 2 more variables: turnoutswing <dbl>, year <dbl>
options(op)
# }
```
