test_that("get_swing returns correct structure", {
  skip_on_cran()
  df <- get_swing(2019, 2022)
  expect_s3_class(df, "data.frame")
  expect_true(all(c(
    "division", "division_id", "state",
    "alp_pct_from", "alp_pct_to", "alp_swing",
    "lnp_pct_from", "lnp_pct_to", "lnp_swing",
    "winner_from", "winner_to", "seat_changed",
    "redistribution_flag", "year_from", "year_to"
  ) %in% names(df)))
})

test_that("get_swing errors if from >= to", {
  expect_error(get_swing(2022, 2019))
  expect_error(get_swing(2022, 2022))
})

test_that("get_swing seat_changed is logical", {
  skip_on_cran()
  df <- get_swing(2019, 2022)
  expect_type(df$seat_changed, "logical")
})

test_that("get_swing division filter works", {
  skip_on_cran()
  df <- get_swing(2019, 2022, division = "Kooyong")
  expect_equal(nrow(df), 1)
  expect_equal(tolower(df$division), "kooyong")
})

test_that("get_swing state filter works", {
  skip_on_cran()
  df <- get_swing(2019, 2022, state = "VIC")
  expect_true(all(df$state == "VIC"))
})

test_that("get_swing alp_swing is correct", {
  skip_on_cran()
  df <- get_swing(2019, 2022, division = "Kooyong")
  expect_equal(df$alp_swing, round(df$alp_pct_to - df$alp_pct_from, 2))
})

test_that("get_swing works across non-adjacent elections", {
  skip_on_cran()
  df <- get_swing(2013, 2025)
  expect_true(nrow(df) > 100)
  expect_equal(unique(df$year_from), 2013)
  expect_equal(unique(df$year_to), 2025)
})
