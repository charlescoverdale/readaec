test_that("AEC requests carry connect and stall timeouts", {
  req <- aec_request("https://results.aec.gov.au/27966/Website/Downloads/x.csv")
  expect_identical(req$options$connecttimeout, 20L)
  expect_identical(req$options$low_speed_limit, 1L)
  expect_identical(req$options$low_speed_time, 60L)
})

test_that("a stalled transfer surfaces as an informative error", {
  cdir <- tempfile("readaec-cache-")
  dir.create(cdir)
  on.exit(unlink(cdir, recursive = TRUE), add = TRUE)
  op <- options(readaec.cache_dir = cdir)
  on.exit(options(op), add = TRUE)
  httr2::local_mocked_responses(function(req) {
    stop(structure(
      class = c("httr2_failure", "error", "condition"),
      list(message = "Timeout was reached", call = NULL)
    ))
  })
  expect_error(
    suppressMessages(aec_download("https://example.invalid/x.csv", "x.csv")),
    "Failed to download x.csv from the AEC"
  )
  expect_length(list.files(cdir), 0L)
})
