sensor_url = "https://cdec.water.ca.gov/reportapp/javareports?name=SensList"
groups_url = "http://cdec.water.ca.gov/dynamicapp/queryGroup?s=&get_list=y"
flags_url = "https://cdec.water.ca.gov/reportapp/javareports?name=FlagList"
stations_url = "http://cdec.water.ca.gov/dynamicapp/staSearch"
map_url = "https://cdec.water.ca.gov/webgis/?appid=cdecstation"
meta_url = "http://cdec.water.ca.gov/dynamicapp/staMeta"

#' CDEC Station Metadata
#'
#' Open the Metadata page for a station.
#' @param station The three-letter station code.
#' @param ... Additional arguments to pass to `browseURL`.
#'
#' @importFrom glue glue
#' @export
cdec_meta = function(station, ...) {
  browseURL(url = glue("{meta_url}?station_id={station}"), ...)
}

#' CDEC Sensor Information
#'
#' Open the Sensor listing page.
#' @param ... Additional arguments to pass to `browseURL`.
#'
#' @export
cdec_sensors = function(...) {
  browseURL(url = sensor_url, ...)
}

#' CDEC Data Flag Information
#'
#' Open the data flag listing page.
#' @param ... Additional arguments to pass to `browseURL`.
#'
#' @export
cdec_data_flags = function(...) {
  browseURL(url = flags_url, ...)
}

#' CDEC Search Pages
#' Open the CDEC station/group search page or map interface.
#' @name cdec-search
NULL

#' @describeIn cdec-search CDEC Group search page.
#' @inheritParams cdec_meta
#' @importFrom utils browseURL
#' @export
cdec_search_groups = function(...) {
  browseURL(url = groups_url, ...)
}

#' @describeIn cdec-search CDEC Station search page.
#' @export
cdec_search_stations = function(...) {
  browseURL(url = stations_url, ...)
}

#' @describeIn cdec-search CDEC Map locator page.
#' @export
cdec_map = function(...) {
  browseURL(url = map_url, ...)
}
