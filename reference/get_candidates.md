# Get all candidates for an election

Get all candidates for an election

## Usage

``` r
get_candidates(year, chamber = "house", refresh = FALSE)
```

## Arguments

- year:

  Election year. Use
  [`list_elections()`](https://charlescoverdale.github.io/readaec/reference/list_elections.md)
  to see available years.

- chamber:

  "house" or "senate".

- refresh:

  If `TRUE`, re-download from the AEC even if a cached copy exists.

## Value

A tidy data frame of candidates.

## Examples

``` r
# \donttest{
op <- options(readaec.cache_dir = tempdir())
get_candidates(2022)
#> Downloading from AEC: HouseCandidatesDownload-27966.csv
#> # A tibble: 1,203 × 11
#>    stateab divisionid divisionnm  partyab partynm    candidateid surname givennm
#>    <chr>        <dbl> <chr>       <chr>   <chr>            <dbl> <chr>   <chr>  
#>  1 VIC            214 Goldstein   ALP     Australia…       36416 ABBOTT  Martyn 
#>  2 VIC            203 Calwell     GVIC    The Greens       36530 ABBOUD  Natalie
#>  3 WA             248 Tangney     GRN     The Green…       36635 ABDUL … Adam   
#>  4 VIC            223 La Trobe    LDP     Liberal D…       36965 ABELMAN Michael
#>  5 VIC            223 La Trobe    ALP     Australia…       36458 ABHIMA… NA     
#>  6 VIC            328 Corangamite UAPP    United Au…       35997 ABOU-Z… Daniel…
#>  7 VIC            211 Flinders    LDP     Liberal D…       36924 ABRAHAM Chryst…
#>  8 QLD            164 Groom       ON      Pauline H…       38219 ABRAHAM Grant  
#>  9 NSW            125 Hume        IND     Independe…       37807 ACKERY  Penny  
#> 10 VIC            208 Corio       AJP     Animal Ju…       36681 ADAMS   Naomi  
#> # ℹ 1,193 more rows
#> # ℹ 3 more variables: elected <chr>, historicelected <chr>, year <dbl>
get_candidates(2022, chamber = "senate")
#> Downloading from AEC: SenateCandidatesDownload-27966.csv
#> # A tibble: 421 × 9
#>    stateab partyab partynm   candidateid surname givennm elected historicelected
#>    <chr>   <chr>   <chr>           <dbl> <chr>   <chr>   <chr>   <chr>          
#>  1 TAS     LP      Liberal         37132 ABETZ   Eric    N       Y              
#>  2 SA      HMP     Legalise…       36475 ADAMS   Angela  N       N              
#>  3 TAS     UAPP    United A…       36282 ADAMS   Diana   N       N              
#>  4 QLD     UAPP    United A…       36124 ADIDI   Desmond N       N              
#>  5 QLD     GRN     Queensla…       36786 ALLMAN… Penny   Y       N              
#>  6 SA      NA      NA              37771 AMADIO  Pat     N       N              
#>  7 NSW     FIN     Federal …       37489 ANDERS… Gabrie… N       N              
#>  8 QLD     ALP     Australi…       37013 ANDREW  Edwina  N       N              
#>  9 ACT     SPP     Sustaina…       37241 ANGEL   Joy     N       N              
#> 10 NT      GRN     The Gree…       36509 ANLEZA… Jane    N       N              
#> # ℹ 411 more rows
#> # ℹ 1 more variable: year <dbl>
options(op)
# }
```
