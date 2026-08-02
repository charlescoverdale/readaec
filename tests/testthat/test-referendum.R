test_that("list_referendums returns the 2023 referendum", {
  df <- list_referendums()
  expect_s3_class(df, "data.frame")
  expect_true(2023 %in% df$year)
})

test_that("invalid referendum year errors", {
  expect_error(get_referendum_by_booth(1999), "No referendum data")
})

test_that("get_referendum_by_booth returns Yes/No counts", {
  skip_on_cran()
  op <- options(readaec.cache_dir = tempdir())
  on.exit(options(op))
  df <- get_referendum_by_booth(2023, state = "TAS")
  expect_s3_class(df, "data.frame")
  expect_true(all(c("division", "yesvotes", "novotes") %in% names(df)))
  expect_equal(unique(df$state), "TAS")
})

test_that("get_referendum_turnout works by division and state", {
  skip_on_cran()
  op <- options(readaec.cache_dir = tempdir())
  on.exit(options(op))
  div <- get_referendum_turnout(2023)
  expect_true(all(c("division", "enrolment", "turnout") %in% names(div)))
  expect_true(nrow(div) > 100)
  st <- get_referendum_turnout(2023, by = "state")
  expect_equal(nrow(st), 8)
})
