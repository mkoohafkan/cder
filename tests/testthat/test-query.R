test_that("query works", {
  expect_warning(cdec_query("NSL", 100, "E", Sys.Date() - 5, Sys.Date()), NA)
  expect_warning(cdec_query_group("SR1", Sys.Date() - 5, Sys.Date()), NA)
})
