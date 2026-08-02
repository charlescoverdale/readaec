# Get referendum results by polling place

Returns Yes and No votes for every polling place, including formal and
informal counts.

## Usage

``` r
get_referendum_by_booth(year = 2023, state = NULL, refresh = FALSE)
```

## Arguments

- year:

  Referendum year. Use
  [`list_referendums()`](https://charlescoverdale.github.io/readaec/reference/list_referendums.md)
  to see available years. Defaults to 2023 (the Voice referendum).

- state:

  Filter to a specific state (e.g. "VIC"). NULL returns all states.

- refresh:

  If `TRUE`, re-download from the AEC even if a cached copy exists.

## Value

A tidy data frame of Yes/No votes by polling place.

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
get_referendum_by_booth(2023, state = "TAS")
#> Downloading from AEC:
#> ReferendumPollingPlaceResultsByStateDownload-29581-TAS.csv
#> # A tibble: 326 × 16
#>    questionno state division_id division pollingplaceid pollingplacenm yesvotes
#>         <dbl> <chr>       <dbl> <chr>             <dbl> <chr>             <dbl>
#>  1          1 TAS           193 Braddon            8359 Acton               315
#>  2          1 TAS           195 Franklin           8493 Adventure Bay        82
#>  3          1 TAS           195 Franklin           8494 Alonnah             123
#>  4          1 TAS           319 Clark              8495 Austins Ferry       566
#>  5          1 TAS           196 Lyons              8550 Avoca                30
#>  6          1 TAS           196 Lyons              8551 Bagdad              205
#>  7          1 TAS           319 Clark              8442 Battery Point       604
#>  8          1 TAS           192 Bass               8553 Beaconsfield        259
#>  9          1 TAS           192 Bass               8608 Beauty Point        209
#> 10          1 TAS           195 Franklin           8497 Bellerive           728
#> # ℹ 316 more rows
#> # ℹ 9 more variables: yespercentage <dbl>, novotes <dbl>, nopercentage <dbl>,
#> #   formalvotes <dbl>, formalpercentage <dbl>, informalvotes <dbl>,
#> #   informalpercentage <dbl>, totalvotes <dbl>, year <dbl>
options(op)
# }
```
