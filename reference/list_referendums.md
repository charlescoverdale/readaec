# List available referendums

List available referendums

## Usage

``` r
list_referendums()
```

## Value

A data frame with one row per referendum with results published on the
AEC tally room, including columns `year`, `date`, `event_id`, and
`description`.

## Examples

``` r
list_referendums()
#>   year event_id       date                                 description
#> 1 2023    29581 2023-10-14 Aboriginal and Torres Strait Islander Voice
```
