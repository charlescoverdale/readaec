# List all federal by-elections

Lists House of Representatives by-elections with results published on
the AEC tally room, from 2005 onwards. The 2014 WA Senate special
election is not included as it was not a House by-election.

## Usage

``` r
list_by_elections()
```

## Value

A data frame with one row per by-election, including columns `division`,
`state`, `date`, `year`, `event_id`, and `has_downloads`. The
`has_downloads` column is `TRUE` where AEC CSV downloads are available
(2008 onwards).

## Examples

``` r
list_by_elections()
#>        division state       date year event_id has_downloads
#> 1        Farrer   NSW 2026-05-09 2026    31633          TRUE
#> 2          Cook   NSW 2024-04-13 2024    29807          TRUE
#> 3       Dunkley   VIC 2024-03-02 2024    29778          TRUE
#> 4        Fadden   QLD 2023-07-15 2023    29422          TRUE
#> 5         Aston   VIC 2023-04-01 2023    28791          TRUE
#> 6         Groom   QLD 2020-11-28 2020    25881          TRUE
#> 7   Eden-Monaro   NSW 2020-07-04 2020    25820          TRUE
#> 8     Wentworth   NSW 2018-10-20 2018    22844          TRUE
#> 9         Perth    WA 2018-07-28 2018    22696          TRUE
#> 10         Mayo    SA 2018-07-28 2018    22695          TRUE
#> 11      Longman   QLD 2018-07-28 2018    22694          TRUE
#> 12    Fremantle    WA 2018-07-28 2018    22693          TRUE
#> 13      Braddon   TAS 2018-07-28 2018    22692          TRUE
#> 14       Batman   VIC 2018-03-17 2018    21751          TRUE
#> 15    Bennelong   NSW 2017-12-16 2017    21379          TRUE
#> 16  New England   NSW 2017-12-02 2017    21364          TRUE
#> 17 North Sydney   NSW 2015-12-05 2015    19402          TRUE
#> 18      Canning    WA 2015-09-19 2015    18126          TRUE
#> 19     Griffith   QLD 2014-02-08 2014    17552          TRUE
#> 20    Bradfield   NSW 2009-12-05 2009    14357          TRUE
#> 21      Higgins   VIC 2009-12-05 2009    14358          TRUE
#> 22         Lyne   NSW 2008-09-06 2008    13827          TRUE
#> 23         Mayo    SA 2008-09-06 2008    13826          TRUE
#> 24    Gippsland   VIC 2008-06-28 2008    13813          TRUE
#> 25      Werriwa   NSW 2005-03-19 2005    12426         FALSE
```
