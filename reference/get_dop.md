# Get the full distribution of preferences by division

Returns the count-by-count distribution of preferences for every
division: each exclusion round, the candidate excluded, and where their
preferences flowed. This is the dataset for analysing seats won from
second or third place on preference flows, which division-level TPP and
TCP figures cannot show.

## Usage

``` r
get_dop(year, refresh = FALSE)
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

A tidy data frame with one row per candidate per count per division,
including `countnumber`, `calculationtype` (preference count, transfer
count, and percentages), and `calculationvalue`.

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
dop <- get_dop(2025)
#> Downloading from AEC: HouseDopByDivisionDownload-31496.csv

# Final count in a single seat
mel <- subset(dop, division == "Melbourne")
subset(mel, countnumber == max(countnumber))
#> # A tibble: 28 × 15
#>    state division_id division  countnumber ballotposition candidateid surname
#>    <chr>       <dbl> <chr>           <dbl>          <dbl>       <dbl> <chr>  
#>  1 VIC           228 Melbourne           5              1       41607 CASEY  
#>  2 VIC           228 Melbourne           5              1       41607 CASEY  
#>  3 VIC           228 Melbourne           5              1       41607 CASEY  
#>  4 VIC           228 Melbourne           5              1       41607 CASEY  
#>  5 VIC           228 Melbourne           5              2       40817 WITTY  
#>  6 VIC           228 Melbourne           5              2       40817 WITTY  
#>  7 VIC           228 Melbourne           5              2       40817 WITTY  
#>  8 VIC           228 Melbourne           5              2       40817 WITTY  
#>  9 VIC           228 Melbourne           5              3       42101 SMITH  
#> 10 VIC           228 Melbourne           5              3       42101 SMITH  
#> # ℹ 18 more rows
#> # ℹ 8 more variables: given_name <chr>, party <chr>, party_name <chr>,
#> #   elected <chr>, historicelected <chr>, calculationtype <chr>,
#> #   calculationvalue <dbl>, year <dbl>
options(op)
# }
```
