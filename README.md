# readaec

An R package for accessing Australian Electoral Commission (AEC) federal election data. Results for the House of Representatives and Senate from 2007 onwards, at both division and polling place level.

Data is downloaded directly from the AEC and cached locally so you're not hitting their servers on every call.

## Installation

```r
remotes::install_github("charlescoverdale/readaec")
```

## What's available

```r
library(readaec)

list_elections()
#>   year event_id       date               type has_downloads
#> 1 2007    13745 2007-11-24            general          TRUE
#> 2 2010    15508 2010-08-21            general          TRUE
#> ...
#> 7 2025    31496 2025-05-03            general          TRUE
```

## House of Representatives

```r
# Two-party preferred by division
get_tpp(2025)

# First preferences by candidate
get_fp(2025)

# Two-candidate preferred (who actually won each seat)
get_tcp(2025)

# Members elected
get_members_elected(2025)

# Turnout by division
get_turnout(2025)
```

## Polling place data

```r
# All polling places nationally (with lat/lon coordinates)
get_polling_places(2025)

# Filter to a single division
get_polling_places(2025, division = "Kooyong")

# First preference votes at booth level
get_fp_by_booth(2025, state = "VIC")

# TPP at booth level
get_tpp_by_booth(2025)
```

## Senate

```r
get_senate(2025)
```

## Candidates & enrolment

```r
# Full candidate list
get_candidates(2025)
get_candidates(2025, chamber = "senate")

# Enrolment by division
get_enrolment(2025)
```

## Cross-election comparisons

Because every function returns a consistent tidy data frame, combining elections is straightforward:

```r
library(dplyr)

# How did Kooyong swing between 2019 and 2025?
bind_rows(
  get_tpp(2019),
  get_tpp(2022),
  get_tpp(2025)
) |>
  filter(division == "Kooyong") |>
  select(year, alp_pct, lnp_pct, swing)
```

Or use `get_swing()` for a direct comparison:

```r
# National swing 2022 to 2025
get_swing(2022, 2025)

# Single seat
get_swing(2019, 2025, division = "Richmond")

# All Victorian seats
get_swing(2019, 2022, state = "VIC")
```

## Vignette: Richmond electorate case study

The package includes a worked example tracing the full electoral history of the Richmond electorate (NSW) from 2007 to 2025:

- TPP trend over time
- First preference breakdown by major party
- Who won each election
- How Richmond swung relative to the NSW average
- Enrolment and turnout over time

```r
vignette("richmond-example", package = "readaec")
```

## Caching

Downloaded files are cached locally so repeated calls are instant. To clear the cache:

```r
clear_cache()
```

## Compared to eechidna

[eechidna](https://github.com/jforbes14/eechidna) is a great package for Australian election data. `readaec` differs in a few ways:

- **Always current** — pulls live from the AEC, so 2025 data is available immediately
- **Booth-level data** — eechidna works at division level only
- **Senate** — eechidna is almost entirely House focused
- **Function-based API** — `get_tpp(2025)` rather than `data(tpp22)`

## Data source

All data comes directly from the [Australian Electoral Commission](https://www.aec.gov.au/). Please respect their terms of use.

## Issues

Please report bugs or requests at <https://github.com/charlescoverdale/readaec/issues>.
