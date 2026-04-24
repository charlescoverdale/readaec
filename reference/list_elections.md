# List all available federal elections

List all available federal elections

## Usage

``` r
list_elections()
```

## Value

A data frame with one row per election, including columns `year`,
`date`, `event_id`, `type`, and `has_downloads`. The `has_downloads`
column is `TRUE` for years where AEC CSV downloads are available (2007
onwards). The 2001 and 2004 elections are listed for reference but their
data cannot be fetched.

## Examples

``` r
list_elections()
#>   year event_id       date               type has_downloads
#> 1 2001    10822 2001-11-10            general         FALSE
#> 2 2004    12246 2004-10-09            general         FALSE
#> 3 2007    13745 2007-11-24            general          TRUE
#> 4 2010    15508 2010-08-21            general          TRUE
#> 5 2013    17496 2013-09-07            general          TRUE
#> 6 2016    20499 2016-07-02 double_dissolution          TRUE
#> 7 2019    24310 2019-05-18            general          TRUE
#> 8 2022    27966 2022-05-21            general          TRUE
#> 9 2025    31496 2025-05-03            general          TRUE

# Only years with downloadable data
list_elections()[list_elections()$has_downloads, ]
#>   year event_id       date               type has_downloads
#> 3 2007    13745 2007-11-24            general          TRUE
#> 4 2010    15508 2010-08-21            general          TRUE
#> 5 2013    17496 2013-09-07            general          TRUE
#> 6 2016    20499 2016-07-02 double_dissolution          TRUE
#> 7 2019    24310 2019-05-18            general          TRUE
#> 8 2022    27966 2022-05-21            general          TRUE
#> 9 2025    31496 2025-05-03            general          TRUE
```
