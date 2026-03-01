# readaec

## Context

The Australian Electoral Commission publishes detailed results for every federal election on their tally room at [results.aec.gov.au](https://results.aec.gov.au). For elections from 2007 onwards, this includes first preference votes, two-party preferred, two-candidate preferred, booth-level results, polling place coordinates, Senate counts, enrolment, and turnout — all available as CSV downloads updated live on election night.

The catch is that each election has its own URL structure built around an internal event ID, column names shift between years without warning, and there is no API. Getting data out requires knowing the right URL pattern, handling inconsistencies across elections, and writing fresh code every time. Most analysts either rely on `eechidna` (which stops at 2019) or write one-off download scripts from scratch — meaning the 2022 and 2025 elections sit largely outside the reach of standard tools.

`readaec` wraps the AEC's CSV downloads in a consistent, tidy interface. One function call returns a clean data frame. Results are cached locally so you're not hitting the AEC's servers on every call. It covers all federal elections from 2007 to 2025, including the Senate.

## Pre-2007 data

For elections before 2007, the AEC provides ZIP archives for the 1993, 1996, and 1998 elections via their [statistics download page](https://www.aec.gov.au/elections/federal_elections/Stats_CDRom.htm). These contain polling place-level results for both chambers but are packaged as legacy fixed-width files designed for an early-2000s database application — usable, but not without effort. The 2001 and 2004 elections have no equivalent structured download.

For a cleaner experience, the [`eechidna`](https://github.com/jforbes14/eechidna) package bundles House of Representatives data from 2001 to 2022 as ready-to-use R data frames, alongside ABS census variables apportioned to electoral boundaries. It remains the best option for that period and for any analysis combining election results with socio-demographic data.

For anything before 2001, [Adam Carr's Psephos archive](http://psephos.adam-carr.net/) is the canonical source — covering federal and state elections back to 1901 in plain-text format. David Barry has also compiled a cleaned series from 1901 to the present at [pappubahry.com](https://pappubahry.com/pseph/aus_stats/data/), combining Psephos with AEC digital records into a more analysis-friendly format.

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

## Caching

Downloaded files are cached locally so repeated calls are instant. To clear the cache:

```r
clear_cache()
```

## Related projects

The Australian election data ecosystem is small but well-tended. Here's how the main sources fit together:

**[eechidna](https://github.com/jforbes14/eechidna)** covers federal House of Representatives elections from 2001 to 2022, bundled directly into R as ready-to-use data frames. Its killer feature is the census join — ABS demographic variables apportioned to electoral boundaries, enabling socio-economic analysis that goes beyond the vote count. It doesn't cover the Senate, stops at 2022, and requires a package update for each new election. `readaec` and `eechidna` are complementary: use `eechidna` for census-linked analysis of the Howard-to-Morrison era, use `readaec` for anything current or Senate-related.

**[The Tally Room](https://www.tallyroom.com.au/data)** — run by psephologist Ben Raue — fills the gap that neither `readaec` nor `eechidna` touches: state and territory elections. Ben publishes clean booth-level CSVs for NSW, VIC, QLD, WA, SA, TAS, ACT, NT, and New Zealand, in a consistent format with lat/lon coordinates. Recent elections are free; a back-catalogue going to roughly 2001 across all jurisdictions is available via Patreon. If you want to study state politics at the same resolution as federal politics, Ben's data is essentially the only structured source that exists.

**[Adam Carr's Psephos](http://psephos.adam-carr.net/)** is the historical record of last resort — federal and state results back to 1901, maintained by one person over decades. The data is in plain text and HTML rather than machine-readable CSVs, but the depth is unmatched. [David Barry](https://pappubahry.com/pseph/aus_stats/data/) has done the hard work of combining Psephos with AEC digital records into a cleaner series from 1901 to the present, which is the better starting point for anyone wanting pre-2007 federal data in a usable format.

## Data source

All data comes directly from the [Australian Electoral Commission](https://www.aec.gov.au/). Please respect their terms of use.

## Issues

Please report bugs or requests at <https://github.com/charlescoverdale/readaec/issues>.
