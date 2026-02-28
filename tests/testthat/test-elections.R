test_that("list_elections returns correct structure", {
  df <- list_elections()
  expect_s3_class(df, "data.frame")
  expect_named(df, c("year", "event_id", "date", "type", "has_downloads"))
  expect_true(2025 %in% df$year)
  expect_true(2022 %in% df$year)
  expect_true(2001 %in% df$year)
})

test_that("year_to_event_id returns correct event IDs", {
  expect_equal(year_to_event_id(2022), 27966)
  expect_equal(year_to_event_id(2025), 31496)
  expect_equal(year_to_event_id(2019), 24310)
})

test_that("year_to_event_id errors on invalid year", {
  expect_error(year_to_event_id(2000))
  expect_error(year_to_event_id(2023))
})

test_that("has_downloads is FALSE for 2001 and 2004", {
  df <- list_elections()
  expect_false(df$has_downloads[df$year == 2001])
  expect_false(df$has_downloads[df$year == 2004])
  expect_true(df$has_downloads[df$year == 2007])
  expect_true(df$has_downloads[df$year == 2025])
})

test_that("year_to_event_id errors for years without downloads", {
  expect_error(year_to_event_id(2001), "not available")
  expect_error(year_to_event_id(2004), "not available")
})
