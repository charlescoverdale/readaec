test_that("list_elections returns correct structure", {
  df <- list_elections()
  expect_s3_class(df, "data.frame")
  expect_named(df, c("year", "event_id", "date", "type"))
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
