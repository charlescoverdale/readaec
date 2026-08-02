# Get referendum turnout

Get referendum turnout

## Usage

``` r
get_referendum_turnout(year = 2023, by = "division", refresh = FALSE)
```

## Arguments

- year:

  Referendum year. Use
  [`list_referendums()`](https://charlescoverdale.github.io/readaec/reference/list_referendums.md)
  to see available years. Defaults to 2023 (the Voice referendum).

- by:

  Aggregation level: "division" (default) or "state".

- refresh:

  If `TRUE`, re-download from the AEC even if a cached copy exists.

## Value

A tidy data frame of enrolment and turnout.

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
get_referendum_turnout(2023)
#> Downloading from AEC: ReferendumTurnoutByDivisionDownload-29581.csv
#> # A tibble: 151 × 7
#>    division_id division  state enrolment turnout turnoutpercentage  year
#>          <dbl> <chr>     <chr>     <dbl>   <dbl>             <dbl> <dbl>
#>  1         179 Adelaide  SA       130242  117211              90.0  2023
#>  2         197 Aston     VIC      111346  103754              93.2  2023
#>  3         198 Ballarat  VIC      113517  105400              92.8  2023
#>  4         103 Banks     NSW      108813   99510              91.4  2023
#>  5         180 Barker    SA       124478  115921              93.1  2023
#>  6         104 Barton    NSW      112630  100205              89.0  2023
#>  7         192 Bass      TAS       80005   73178              91.5  2023
#>  8         318 Bean      ACT      111159  101954              91.7  2023
#>  9         200 Bendigo   VIC      113858  106414              93.5  2023
#> 10         105 Bennelong NSW      117257  107501              91.7  2023
#> # ℹ 141 more rows
get_referendum_turnout(2023, by = "state")
#> Downloading from AEC: ReferendumTurnoutByStateDownload-29581.csv
#> # A tibble: 8 × 6
#>   state statenm                      enrolment turnout turnoutpercentage  year
#>   <chr> <chr>                            <dbl>   <dbl>             <dbl> <dbl>
#> 1 NSW   New South Wales                5586087 5073929              90.8  2023
#> 2 VIC   Victoria                       4467175 4066512              91.0  2023
#> 3 QLD   Queensland                     3631607 3205639              88.3  2023
#> 4 WA    Western Australia              1826031 1598271              87.5  2023
#> 5 SA    South Australia                1284140 1177541              91.7  2023
#> 6 TAS   Tasmania                        406939  374563              92.0  2023
#> 7 ACT   Australian Capital Territory    316814  289451              91.4  2023
#> 8 NT    Northern Territory              152991  109325              71.5  2023
options(op)
# }
```
