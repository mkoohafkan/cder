#' CDEC Search Pages
#' Open the CDEC station/group search page or map interface.
#' @name cdec-search
NULL

#' @describeIn cdec-search CDEC Group search page.
#' @export
cdec_search_groups = function() {
  shell.exec("http://cdec.water.ca.gov/dynamicapp/queryGroup?s=&get_list=y")
}

#' @describeIn cdec-search CDEC Station search page.
#' @export
cdec_search__stations = function() {
  shell.exec("http://cdec.water.ca.gov/dynamicapp/staSearch")
}

#' @describeIn cdec-search CDEC Map locator page.
#' @export
cdec_map = function() {
  shell.exec("http://cdec.water.ca.gov/cdecstation2/")
}

#' CDEC Station Metadata
#'
#' Open the Metadata page for a station.
#' @param station The three-letter station code.
#'
#' @importFrom glue glue
#' @export
cdec_meta = function(station) {
  shell.exec(glue("http://cdec.water.ca.gov/dynamicapp/staMeta?station_id={station}"))
}