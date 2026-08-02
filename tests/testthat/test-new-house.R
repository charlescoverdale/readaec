test_that("get_dop returns distribution of preferences", {
  skip_on_cran()
  op <- options(readaec.cache_dir = tempdir())
  on.exit(options(op))
  df <- get_dop(2025)
  expect_s3_class(df, "data.frame")
  expect_true(all(c("division", "countnumber", "surname", "party",
                    "calculationtype", "calculationvalue") %in% names(df)))
  # Every division starts at count 0
  expect_true(all(tapply(df$countnumber, df$division, min) == 0))
})

test_that("get_tcp_by_booth returns booth-level TCP", {
  skip_on_cran()
  op <- options(readaec.cache_dir = tempdir())
  on.exit(options(op))
  df <- get_tcp_by_booth(2022)
  expect_s3_class(df, "data.frame")
  expect_true(all(c("divisionnm", "pollingplace", "ordinaryvotes") %in% names(df)))
})

test_that("get_senators_elected returns senators in order", {
  skip_on_cran()
  op <- options(readaec.cache_dir = tempdir())
  on.exit(options(op))
  df <- get_senators_elected(2022)
  expect_s3_class(df, "data.frame")
  expect_true(all(c("state", "surname", "party", "elected_order") %in% names(df)))
  # Full Senate election: 6 per state, 2 per territory
  expect_true(nrow(df) >= 40)
})

test_that("get_swing reports actual winners for crossbench seats", {
  skip_on_cran()
  op <- options(readaec.cache_dir = tempdir())
  on.exit(options(op))
  kooyong <- get_swing(2019, 2022, division = "Kooyong")
  expect_equal(kooyong$winner_to, "IND")
  expect_true(kooyong$seat_changed)
  expect_true(all(c("tpp_leader_from", "tpp_leader_to") %in% names(kooyong)))
})

test_that("old vintages still parse with hardcoded renames", {
  skip_on_cran()
  op <- options(readaec.cache_dir = tempdir())
  on.exit(options(op))
  expect_s3_class(get_tpp(2007), "data.frame")
  expect_s3_class(get_fp(2007), "data.frame")
})
