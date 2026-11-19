# Build a request to the AEC

The one place requests are built. httr2 sets no transfer timeout, so a
server that accepts the connection and then stalls would hang the
session indefinitely. The curl options abort a connection that takes
more than 20 seconds to open, or a transfer that moves less than 1 byte
per second for 60 seconds, while letting slow but progressing downloads
finish.

## Usage

``` r
aec_request(url)
```
