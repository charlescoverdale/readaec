# Get polling place locations

Returns all polling place addresses and coordinates for a given
election.

## Usage

``` r
get_polling_places(year, division = NULL, refresh = FALSE)
```

## Arguments

- year:

  Election year. Use
  [`list_elections()`](https://charlescoverdale.github.io/readaec/reference/list_elections.md)
  to see available years.

- division:

  Filter to a specific division name. NULL returns all.

- refresh:

  If `TRUE`, re-download from the AEC even if a cached copy exists.

## Value

A tidy data frame of polling places with lat/lon coordinates.

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
get_polling_places(2022)
#> Downloading from AEC: GeneralPollingPlacesDownload-27966.csv
#> # A tibble: 8,479 × 16
#>    state divisionid divisionnm pollingplaceid pollingplacetypeid pollingplacenm 
#>    <chr>      <dbl> <chr>               <dbl>              <dbl> <chr>          
#>  1 ACT          318 Bean                93925                  5 Belconnen BEAN…
#>  2 ACT          318 Bean                11877                  1 Bonython       
#>  3 ACT          318 Bean                11452                  1 Calwell        
#>  4 ACT          318 Bean                 8761                  1 Chapman        
#>  5 ACT          318 Bean                 8763                  1 Chisholm       
#>  6 ACT          318 Bean                93916                  1 City (Bean)    
#>  7 ACT          318 Bean                93922                  5 City BEAN PPVC 
#>  8 ACT          318 Bean                31298                  1 Conder         
#>  9 ACT          318 Bean                83835                  1 Conder North   
#> 10 ACT          318 Bean                82523                  1 Coombs         
#> # ℹ 8,469 more rows
#> # ℹ 10 more variables: premisesnm <chr>, premisesaddress1 <chr>,
#> #   premisesaddress2 <chr>, premisesaddress3 <chr>, premisessuburb <chr>,
#> #   premisesstateab <chr>, premisespostcode <chr>, latitude <dbl>,
#> #   longitude <dbl>, year <dbl>
get_polling_places(2022, division = "Kooyong")
#> Loading from cache: GeneralPollingPlacesDownload-27966.csv
#> # A tibble: 45 × 16
#>    state divisionid divisionnm pollingplaceid pollingplacetypeid pollingplacenm 
#>    <chr>      <dbl> <chr>               <dbl>              <dbl> <chr>          
#>  1 VIC          221 Kooyong            104871                  1 Ashburton (Koo…
#>  2 VIC          221 Kooyong              4200                  1 Balwyn         
#>  3 VIC          221 Kooyong              4201                  1 Balwyn Central 
#>  4 VIC          221 Kooyong              4203                  1 Balwyn North   
#>  5 VIC          221 Kooyong              4208                  1 Balwyn North C…
#>  6 VIC          221 Kooyong              4204                  1 Bellevue       
#>  7 VIC          221 Kooyong             58743                  5 Box Hill KOOYO…
#>  8 VIC          221 Kooyong              3920                  1 Camberwell     
#>  9 VIC          221 Kooyong              3921                  1 Camberwell Mid…
#> 10 VIC          221 Kooyong             64001                  1 Camberwell Sou…
#> # ℹ 35 more rows
#> # ℹ 10 more variables: premisesnm <chr>, premisesaddress1 <chr>,
#> #   premisesaddress2 <chr>, premisesaddress3 <chr>, premisessuburb <chr>,
#> #   premisesstateab <chr>, premisespostcode <chr>, latitude <dbl>,
#> #   longitude <dbl>, year <dbl>
options(op)
# }
```
