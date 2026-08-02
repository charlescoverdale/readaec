# Get members elected to the House of Representatives

Get members elected to the House of Representatives

## Usage

``` r
get_members_elected(year, refresh = FALSE)
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

A tidy data frame of elected members.

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
get_members_elected(2022)
#> Downloading from AEC: HouseMembersElectedDownload-27966.csv
#> # A tibble: 151 × 9
#>    divisionid divisionnm stateab candidateid givennm     surname partynm partyab
#>         <dbl> <chr>      <chr>         <dbl> <chr>       <chr>   <chr>   <chr>  
#>  1        179 Adelaide   SA            36973 Steve       GEORGA… Austra… ALP    
#>  2        197 Aston      VIC           36704 Alan        TUDGE   Liberal LP     
#>  3        198 Ballarat   VIC           36409 Catherine   KING    Austra… ALP    
#>  4        103 Banks      NSW           37018 David       COLEMAN Liberal LP     
#>  5        180 Barker     SA            37083 Tony        PASIN   Liberal LP     
#>  6        104 Barton     NSW           36820 Linda       BURNEY  Austra… ALP    
#>  7        192 Bass       TAS           37134 Bridget Ka… ARCHER  Liberal LP     
#>  8        318 Bean       ACT           36231 David       SMITH   Austra… ALP    
#>  9        200 Bendigo    VIC           36424 Lisa        CHESTE… Austra… ALP    
#> 10        105 Bennelong  NSW           36827 Jerome      LAXALE  Austra… ALP    
#> # ℹ 141 more rows
#> # ℹ 1 more variable: year <dbl>
options(op)
# }
```
