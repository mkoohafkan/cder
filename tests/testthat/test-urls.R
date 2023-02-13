test_that("URLs are valid", {
  skip_if_offline("cdec.water.ca.gov")

  # these should fail with code 500
  expect_identical(attr(curlGetHeaders(single_query_url), "status"), 500L)
  expect_identical(attr(curlGetHeaders(group_query_url), "status"), 500L)
  # these should succeed
  expect_identical(attr(curlGetHeaders(sensor_url), "status"), 200L)
  expect_identical(attr(curlGetHeaders(groups_url), "status"), 200L)
  expect_identical(attr(curlGetHeaders(flags_url), "status"), 200L)
  expect_identical(attr(curlGetHeaders(stations_url), "status"), 200L)
  expect_identical(attr(curlGetHeaders(map_url), "status"), 200L)
  expect_identical(attr(curlGetHeaders(meta_url), "status"), 200L)
  # URLs in description
  expect_identical(attr(curlGetHeaders("http://cdec.water.ca.gov/"), "status"), 200L)
  expect_identical(attr(curlGetHeaders("http://cdec.water.ca.gov/dynamicapp/wsSensorData"), "status"), 200L)
})
