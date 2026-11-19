# Offline: a cached file is served while fresh and refetched once older than
# the readaec.cache_ttl option.

local_aec_cache <- function(env = parent.frame()) {
  cdir <- tempfile("readaec-cache-")
  dir.create(cdir)
  op <- options(readaec.cache_dir = cdir, readaec.cache_ttl = NULL)
  defer <- function(expr) do.call(on.exit, list(expr, add = TRUE), envir = env)
  defer(bquote(options(.(op))))
  defer(bquote(unlink(.(cdir), recursive = TRUE)))
  cdir
}

write_cached <- function(cdir, value) {
  f <- file.path(cdir, "x.csv")
  writeLines(c("meta", "a", value), f)
  f
}

test_that("a fresh cache file is served without a request", {
  cdir <- local_aec_cache()
  write_cached(cdir, "old")
  calls <- 0L
  httr2::local_mocked_responses(function(req) {
    calls <<- calls + 1L
    httr2::response(status_code = 200L, body = charToRaw("meta\na\nnew\n"))
  })
  df <- suppressMessages(aec_download("https://example.invalid/x.csv", "x.csv"))
  expect_identical(calls, 0L)
  expect_identical(df$a, "old")
})

test_that("a cache file older than the TTL is refetched", {
  cdir <- local_aec_cache()
  f <- write_cached(cdir, "old")
  Sys.setFileTime(f, Sys.time() - 31 * 24 * 3600)
  calls <- 0L
  httr2::local_mocked_responses(function(req) {
    calls <<- calls + 1L
    httr2::response(status_code = 200L, body = charToRaw("meta\na\nnew\n"))
  })
  df <- suppressMessages(aec_download("https://example.invalid/x.csv", "x.csv"))
  expect_identical(calls, 1L)
  expect_identical(df$a, "new")
  expect_lt(as.numeric(difftime(Sys.time(), file.info(f)$mtime, units = "hours")), 1)
})

test_that("readaec.cache_ttl controls the lifetime", {
  cdir <- local_aec_cache()
  f <- write_cached(cdir, "old")
  Sys.setFileTime(f, Sys.time() - 2 * 3600)
  expect_true(aec_cache_fresh(f))
  options(readaec.cache_ttl = 1)
  expect_false(aec_cache_fresh(f))
  options(readaec.cache_ttl = -1)
  expect_error(aec_cache_fresh(f), "non-negative")
})
