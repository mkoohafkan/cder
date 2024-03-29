test_that("query works", {
  skip_if_offline("cdec.water.ca.gov")

  expect_warning(cdec_query("NSL", 100, "E", Sys.Date() - 5, Sys.Date()), NA)
  expect_warning(cdec_query_group("SR1", Sys.Date() - 5, Sys.Date()), NA)
})


test_that("vignette queries work", {
  skip_if_offline("cdec.water.ca.gov")

  station = "NSL"
  duration = "event" # or "E"
  sensor = 100 # electrical conductivity
  start.date = "2023-01-01"
  end.date = "2023-01-15"
  expect_snapshot(knitr::kable(
    cdec_query(station, sensor, duration, start.date, end.date)
  ))

  stations = c("NSL", "HUN")
  sensors = c(100, 1)
  duration = "hourly"
  start.date = "2023-01-01"
  end.date = "2023-01-05"
  expect_snapshot(knitr::kable(
    cdec_query(stations, sensors, duration, start.date, end.date),
  ))
})
