test_that("get_tpp returns correct structure", {
  skip_on_cran()
  df <- get_tpp(2022)
  expect_s3_class(df, "data.frame")
  expect_true(all(c("division", "division_id", "state", "alp_pct", "lnp_pct",
                    "total_votes", "swing", "year") %in% names(df)))
  expect_equal(unique(df$year), 2022)
  expect_true(nrow(df) > 0)
})

test_that("get_tpp works for 2025", {
  skip_on_cran()
  df <- get_tpp(2025)
  expect_s3_class(df, "data.frame")
  expect_equal(unique(df$year), 2025)
  expect_true(nrow(df) > 100)  # 151 seats
})

test_that("get_fp returns correct structure", {
  skip_on_cran()
  df <- get_fp(2022)
  expect_s3_class(df, "data.frame")
  expect_true(all(c("division", "state", "surname", "given_name", "party", "year") %in% names(df)))
})

test_that("get_tcp returns correct structure", {
  skip_on_cran()
  df <- get_tcp(2022)
  expect_s3_class(df, "data.frame")
  expect_true(all(c("division", "surname", "party", "year") %in% names(df)))
  expect_equal(unique(df$year), 2022)
})

test_that("get_members_elected returns 151 members", {
  skip_on_cran()
  df <- get_members_elected(2022)
  expect_equal(nrow(df), 151)
})

test_that("get_tpp_by_booth returns correct structure", {
  skip_on_cran()
  df <- get_tpp_by_booth(2022)
  expect_s3_class(df, "data.frame")
  expect_true(nrow(df) > 0)
})
