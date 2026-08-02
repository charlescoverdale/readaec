test_that("list_by_elections returns the full table", {
  df <- list_by_elections()
  expect_s3_class(df, "data.frame")
  expect_true(all(c("division", "state", "date", "year", "event_id",
                    "has_downloads") %in% names(df)))
  expect_true("Farrer" %in% df$division)
  expect_equal(sum(df$has_downloads), 24)
})

test_that("by_election_lookup resolves and errors correctly", {
  expect_error(get_by_election_fp("Notaseat"), "No by-election")
  expect_error(get_by_election_fp("Mayo"), "Specify")
  expect_error(get_by_election_fp("Werriwa"), "not available")
})

test_that("get_by_election_fp returns Farrer booth results", {
  skip_on_cran()
  op <- options(readaec.cache_dir = tempdir())
  on.exit(options(op))
  df <- get_by_election_fp("Farrer")
  expect_s3_class(df, "data.frame")
  expect_true(all(c("divisionnm", "pollingplace", "surname", "partyab",
                    "ordinaryvotes") %in% names(df)))
  expect_equal(unique(df$divisionnm), "Farrer")
})

test_that("get_by_election_tcp works for a division with two by-elections", {
  skip_on_cran()
  op <- options(readaec.cache_dir = tempdir())
  on.exit(options(op))
  df <- get_by_election_tcp("Mayo", year = 2018)
  expect_s3_class(df, "data.frame")
  expect_equal(unique(df$divisionnm), "Mayo")
})

test_that("get_by_election_candidates returns candidates", {
  skip_on_cran()
  op <- options(readaec.cache_dir = tempdir())
  on.exit(options(op))
  df <- get_by_election_candidates("Farrer")
  expect_s3_class(df, "data.frame")
  expect_true(nrow(df) > 0)
})
