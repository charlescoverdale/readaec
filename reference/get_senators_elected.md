# Get senators elected

Returns the senators elected at each election, in the order they were
elected within each state or territory.

## Usage

``` r
get_senators_elected(year, refresh = FALSE)
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

A tidy data frame with one row per senator elected, including `state`,
`given_name`, `surname`, `party`, `party_name`, and `elected_order`.

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
get_senators_elected(2025)
#> Downloading from AEC: SenateSenatorsElectedDownload-31496.csv
#> # A tibble: 40 × 7
#>    state given_name         surname   party_name       party elected_order  year
#>    <chr> <chr>              <chr>     <chr>            <chr>         <dbl> <dbl>
#>  1 ACT   David              POCOCK    David Pocock     DAVI              1  2025
#>  2 ACT   Katy               GALLAGHER Australian Labo… ALP               2  2025
#>  3 NSW   Tony               SHELDON   Labor            ALP               1  2025
#>  4 NSW   Andrew             BRAGG     Liberal          LP                2  2025
#>  5 NSW   Tim                AYRES     Labor            ALP               3  2025
#>  6 NSW   Jessica            COLLINS   Liberal          LP                4  2025
#>  7 NSW   Mehreen            FARUQI    The Greens       GRN               5  2025
#>  8 NSW   Warwick            STACEY    Pauline Hanson'… ON                6  2025
#>  9 NT    Malarndirri        McCARTHY  Australian Labo… ALP               1  2025
#> 10 NT    Jacinta Nampijinpa PRICE     NT CLP           CLP               2  2025
#> # ℹ 30 more rows
options(op)
# }
```
