test_that("listings work", {
  skip_on_cran()

  expect_null(cdec_meta("NSL", browser = "false"))
  expect_null(cdec_search_stations(browser = "false"))
  expect_null(cdec_search_groups(browser = "false"))
  expect_null(cdec_map(browser = "false"))
})
