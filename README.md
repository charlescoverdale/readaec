# readaec

[![CRAN status](https://www.r-pkg.org/badges/version/readaec)](https://CRAN.R-project.org/package=readaec) [![CRAN downloads](https://cranlogs.r-pkg.org/badges/grand-total/readaec)](https://CRAN.R-project.org/package=readaec) [![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable) [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## Context

The Australian Electoral Commission publishes detailed results for every federal election on their tally room at [results.aec.gov.au](https://results.aec.gov.au). For elections from 2007 onwards, this includes first preference votes, two-party preferred, two-candidate preferred, booth-level results, polling place coordinates, Senate counts, enrolment, and turnout - all available as CSV downloads updated live on election night.

The catch is that each election has its own URL structure built around an internal event ID, column names shift between years without warning, and there is no API. Getting data out requires knowing the right URL pattern, handling inconsistencies across elections, and writing fresh code every time.

`readaec` wraps the AEC's CSV downloads in a consistent, tidy interface. One function call returns a clean data frame. Results are cached locally so you're not hitting the AEC's servers on every call. It covers all federal elections from 2007 to 2025, including the Senate.

## Related projects

`readaec` covers federal elections from 2007 onwards. For everything outside that scope, here's where to look.

**Federal elections, 2001–2022: [`eechidna`](https://github.com/jforbes14/eechidna)** bundles House of Representatives results from 2001 to 2022 as ready-to-use R data frames. Its standout feature is the census join - ABS demographic variables apportioned to electoral boundaries - making it the best option for socio-economic analysis of the Howard-to-Morrison era. It doesn't cover the Senate and stops at 2022. `readaec` and `eechidna` are complementary rather than competing.

**Federal elections, pre-2001:** The AEC provides ZIP archives for the 1993, 1996, and 1998 elections via their [statistics download page](https://www.aec.gov.au/elections/federal_elections/Stats_CDRom.htm), packaged as legacy fixed-width files - usable but not pleasant. For anything earlier, [Adam Carr's Psephos archive](http://psephos.adam-carr.net/) is the canonical source, covering federal results back to 1901 in plain-text format. [David Barry](https://pappubahry.com/pseph/aus_stats/data/) has done the hard work of combining Psephos with AEC digital records into a cleaner, more analysis-friendly series from 1901 to the present.

**Federal and state elections: [The Tally Room](https://www.tallyroom.com.au/data)** - run by psephologist Ben Raue - covers both federal and state elections across all Australian jurisdictions, plus New Zealand. Ben publishes clean booth-level CSVs with lat/lon coordinates in a consistent format, going back to roughly 2001. Recent elections are free; the historical back-catalogue is available via Patreon. The key difference from `readaec` is that Ben's federal data is manually curated and published as static files, whereas `readaec` pulls live from the AEC - making `readaec` better suited for programmatic access and the most current results. For state and territory elections, Ben's data is essentially the only structured source that exists.

## Installation

```r
install.packages("readaec")

# Or install the development version from GitHub
# install.packages("devtools")
devtools::install_github("charlescoverdale/readaec")
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

## Caching

Downloaded files are cached locally so repeated calls are instant. To clear the cache:

```r
clear_cache()
```

## Data source

All data comes directly from the [Australian Electoral Commission](https://www.aec.gov.au/). Please respect their terms of use.

## Issues

Please report bugs or requests at <https://github.com/charlescoverdale/readaec/issues>.
