# Get enrolment by division

Get enrolment by division

## Usage

``` r
get_enrolment(year, refresh = FALSE)
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

A tidy data frame of enrolment figures by division.

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
get_enrolment(2022)
#> Downloading from AEC: GeneralEnrolmentByDivisionDownload-27966.csv
#> # A tibble: 151 × 12
#>    divisionid divisionnm stateab closeofrollsenrolment notebookrolladditions
#>         <dbl> <chr>      <chr>                   <dbl>                 <dbl>
#>  1        179 Adelaide   SA                     130151                    10
#>  2        197 Aston      VIC                    109826                     3
#>  3        198 Ballarat   VIC                    110704                     3
#>  4        103 Banks      NSW                    107786                     1
#>  5        180 Barker     SA                     123518                     0
#>  6        104 Barton     NSW                    110484                     1
#>  7        192 Bass       TAS                     79433                     1
#>  8        318 Bean       ACT                    109557                     0
#>  9        200 Bendigo    VIC                    112498                     2
#> 10        105 Bennelong  NSW                    115030                     3
#> # ℹ 141 more rows
#> # ℹ 7 more variables: notebookrolldeletions <dbl>, reinstatementspostal <dbl>,
#> #   reinstatementsprepoll <dbl>, reinstatementsabsent <dbl>,
#> #   reinstatementsprovisional <dbl>, enrolment <dbl>, year <dbl>
options(op)
# }
```
