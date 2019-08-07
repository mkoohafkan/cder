test_that("listings work", {
  expect_null(cdec_meta("NSL"))
  expect_null(cdec_search_stations())
  expect_null(cdec_search_groups())
  expect_null(cdec_map())
})