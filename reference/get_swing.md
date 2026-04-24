# Compare TPP results between two elections

Calculates the change in two-party preferred vote share between any two
federal elections. Joins on division ID (not name) to handle renamed
divisions correctly. Divisions that don't appear in both elections are
flagged rather than silently dropped.

## Usage

``` r
get_swing(from, to, division = NULL, state = NULL)
```

## Arguments

- from:

  Election year to compare from. Use
  [`list_elections()`](https://charlescoverdale.github.io/readaec/reference/list_elections.md)
  to see available years.

- to:

  Election year to compare to.

- division:

  Optionally filter to one or more division names.

- state:

  Optionally filter to a state abbreviation (e.g. "VIC").

## Value

A data frame with one row per division containing:

- division:

  Division name (from the later election)

- division_id:

  AEC division ID

- state:

  State abbreviation

- alp_pct_from, alp_pct_to:

  ALP TPP percentage in each election

- lnp_pct_from, lnp_pct_to:

  LNP TPP percentage in each election

- alp_swing:

  Change in ALP TPP (positive = swing to ALP)

- lnp_swing:

  Change in LNP TPP (positive = swing to LNP)

- winner_from, winner_to:

  Winning party in each election

- seat_changed:

  TRUE if the seat changed hands

- redistribution_flag:

  TRUE if the division only appears in one election

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
# National swing 2019 to 2022
get_swing(2019, 2022)
#> Downloading from AEC: HouseTppByDivisionDownload
#> Downloading from AEC: HouseTppByDivisionDownload
#> # A tibble: 153 × 15
#>    division  division_id state alp_pct_from alp_pct_to alp_swing lnp_pct_from
#>    <chr>           <dbl> <chr>        <dbl>      <dbl>     <dbl>        <dbl>
#>  1 Pearce            244 WA            42.5       59.0      16.6         57.5
#>  2 Tangney           248 WA            38.5       52.4      13.8         61.5
#>  3 Swan              247 WA            47.3       58.8      11.5         52.7
#>  4 Hasluck           305 WA            44.6       56        11.4         55.4
#>  5 Moore             242 WA            38.4       49.3      11.0         61.6
#>  6 Melbourne         228 VIC           67.1       77.9      10.8         32.9
#>  7 Durack            312 WA            35.2       45.7      10.5         64.8
#>  8 Forrest           239 WA            35.4       45.7      10.3         64.6
#>  9 Burt              317 WA            55.0       65.2      10.2         45.0
#> 10 Brand             235 WA            56.7       66.7      10.0         43.3
#> # ℹ 143 more rows
#> # ℹ 8 more variables: lnp_pct_to <dbl>, lnp_swing <dbl>, winner_from <chr>,
#> #   winner_to <chr>, seat_changed <lgl>, redistribution_flag <lgl>,
#> #   year_from <dbl>, year_to <dbl>

# Teal seats in Victoria
get_swing(2019, 2022, state = "VIC")
#> Loading from cache: HouseTppByDivisionDownload
#> Loading from cache: HouseTppByDivisionDownload
#> # A tibble: 40 × 15
#>    division  division_id state alp_pct_from alp_pct_to alp_swing lnp_pct_from
#>    <chr>           <dbl> <chr>        <dbl>      <dbl>     <dbl>        <dbl>
#>  1 Melbourne         228 VIC           67.1       77.9     10.8          32.9
#>  2 Hotham            217 VIC           55.9       64.2      8.34         44.1
#>  3 Bruce             201 VIC           64.2       56.6     -7.56         35.8
#>  4 Indi              218 VIC           37.3       44.7      7.47         62.7
#>  5 Aston             197 VIC           39.9       47.2      7.32         60.1
#>  6 Chisholm          205 VIC           49.4       56.4      6.98         50.6
#>  7 Menzies           229 VIC           42.5       49.3      6.85         57.5
#>  8 Calwell           203 VIC           68.8       62.4     -6.41         31.2
#>  9 Scullin           232 VIC           71.7       65.6     -6.08         28.3
#> 10 Macnamara         322 VIC           56.2       62.2      6            43.8
#> # ℹ 30 more rows
#> # ℹ 8 more variables: lnp_pct_to <dbl>, lnp_swing <dbl>, winner_from <chr>,
#> #   winner_to <chr>, seat_changed <lgl>, redistribution_flag <lgl>,
#> #   year_from <dbl>, year_to <dbl>

# A single seat
get_swing(2019, 2022, division = "Kooyong")
#> Loading from cache: HouseTppByDivisionDownload
#> Loading from cache: HouseTppByDivisionDownload
#> # A tibble: 1 × 15
#>   division division_id state alp_pct_from alp_pct_to alp_swing lnp_pct_from
#>   <chr>          <dbl> <chr>        <dbl>      <dbl>     <dbl>        <dbl>
#> 1 Kooyong          221 VIC           43.3       45.8       2.5         56.7
#> # ℹ 8 more variables: lnp_pct_to <dbl>, lnp_swing <dbl>, winner_from <chr>,
#> #   winner_to <chr>, seat_changed <lgl>, redistribution_flag <lgl>,
#> #   year_from <dbl>, year_to <dbl>

# Long-run comparison
get_swing(2013, 2025)
#> Downloading from AEC: HouseTppByDivisionDownload
#> Downloading from AEC: HouseTppByDivisionDownload
#> # A tibble: 162 × 15
#>    division  division_id state alp_pct_from alp_pct_to alp_swing lnp_pct_from
#>    <chr>           <dbl> <chr>        <dbl>      <dbl>     <dbl>        <dbl>
#>  1 Macarthur         131 NSW           38.6       65.6      27.0         61.4
#>  2 Tangney           248 WA            35.3       57.0      21.7         64.7
#>  3 Cowan             237 WA            42.5       63.6      21.1         57.5
#>  4 Hasluck           305 WA            45.1       66.0      20.8         54.9
#>  5 Swan              247 WA            43.5       64.0      20.5         56.5
#>  6 Warringah         151 NSW           34.6       54.5      19.9         65.4
#>  7 Canberra          101 ACT           57.0       76.4      19.4         43.0
#>  8 Wentworth         152 NSW           32.3       50.6      18.3         67.7
#>  9 Mitchell          134 NSW           27.9       46.2      18.3         72.1
#> 10 Hindmarsh         185 SA            48.1       66.4      18.2         51.9
#> # ℹ 152 more rows
#> # ℹ 8 more variables: lnp_pct_to <dbl>, lnp_swing <dbl>, winner_from <chr>,
#> #   winner_to <chr>, seat_changed <lgl>, redistribution_flag <lgl>,
#> #   year_from <dbl>, year_to <dbl>
options(op)
# }
```
