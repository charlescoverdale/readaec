test_that("get_candidates returns correct structure", {
  skip_on_cran()
  df <- get_candidates(2022)
  expect_s3_class(df, "data.frame")
  expect_true("year" %in% names(df))
  expect_equal(unique(df$year), 2022)
})

test_that("get_candidates works for senate", {
  skip_on_cran()
  df <- get_candidates(2022, chamber = "senate")
  expect_s3_class(df, "data.frame")
  expect_true(nrow(df) > 0)
})

test_that("get_candidates errors on invalid chamber", {
  expect_error(get_candidates(2022, chamber = "crossbench"))
})

test_that("get_polling_places returns lat/lon", {
  skip_on_cran()
  df <- get_polling_places(2022)
  expect_true(all(c("latitude", "longitude") %in% names(df)))
  expect_true(mean(!is.na(df$latitude)) > 0.99)  # allow for a handful of remote/mobile booths
})

test_that("get_polling_places filters by division", {
  skip_on_cran()
  df <- get_polling_places(2022, division = "Kooyong")
  expect_true(all(tolower(df$divisionnm) == "kooyong"))
  expect_true(nrow(df) > 0)
})

test_that("get_enrolment returns correct structure", {
  skip_on_cran()
  df <- get_enrolment(2022)
  expect_s3_class(df, "data.frame")
  expect_true(nrow(df) > 0)
})

test_that("get_turnout returns correct structure", {
  skip_on_cran()
  df <- get_turnout(2022)
  expect_s3_class(df, "data.frame")
  expect_true("turnoutpercentage" %in% names(df))
})
