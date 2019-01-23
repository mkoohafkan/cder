#' Query CDEC
#'
#' Query data from the CDEC web services.
#'
#' @param stations A vector of station codes.
#' @param sensors A vector of sensor numbers.
#' @param durations A vector of durations.
#' @param start.date The start date of the query.
#' @param end.date The end date of the query.
#' @return A dataframe. 
#'
#' @details Note that CDEC timestamps are always in Pacific 
#'   Standard Time, i.e. daylight savings adjustments are not
#'   reflected. In R, this is equivalent to the timezone 
#'   "Etc/GMT-8".
#'
#' @examples
#' query_cdec("NSL", 100, "E", Sys.Date() - 5, Sys.Date())
#'
#' @importFrom tibble tibble as_tibble
#' @importFrom dplyr transmute if_else near
#' @importFrom stringr str_c str_trim str_to_upper str_sub
#' @importFrom lubridate ymd_hms as_date
#' @importFrom glue glue
#' @importFrom rlang .data
#' @export
query_cdec = function(stations, sensors, durations, start.date, end.date) {
  if (missing(stations)) {
    stop("No stations provided.", call. = FALSE)
  } else {
    station.comp = glue("Stations={str_c(str_to_upper(stations), collapse = '%2C')}")
  }
  if (missing(sensors)) {
    sensor.comp = ""
  } else {
    sensor.comp = glue("&SensorNums={str_c(sensors, collapse = '%2C')}")
  }
  if (missing(durations)) {
    duration.comp = ""
  } else {
    durations = match.arg(str_to_upper(str_sub(durations, 1, 1)),
      c("E", "H", "D", "M"), TRUE)
    duration.comp = glue("&dur_code={str_c(durations, collapse = '%2C')}")
  }
  if (missing(start.date)) {
    start.comp = ""
  } else {
    start.date = as_date(start.date)
    start.comp = glue("&Start={start.date}")
  }
  if (missing(end.date)) {
    end.comp = ""
  } else {
    end.date = as_date(end.date)
    end.comp = glue("&End={end.date}")
  }
  # query
  result = basic_query(
    glue("http://cdec.water.ca.gov/dynamicapp/req/JSONDataServlet?",
      "{station.comp}", "{sensor.comp}", "{duration.comp}",
      "{start.comp}", "{end.comp}")
  )
  if (identical(result, list())) {
    warning("Query returned empty dataset.", call. = FALSE)
    tibble(
      StationID = character(0),
      DateTime = ymd_hms(numeric(0), tz = cdec.tz),
      SensorType = character(0),
      Value = numeric(0),
      DataFlag = character(0),
      SensorUnits = character(0),
      SensorNum = integer(0),
      SensorID = integer(0),
      Duration = character(0)
    )
  } else {
    transmute(as_tibble(result),
      StationID = .data$stationId,
      DateTime = ymd_hms(.data$date, truncated = 1L, tz = cdec.tz),
      SensorType = .data$sensorType,
      Value = if_else(near(.data$value, -9999), NA_real_,
        as.numeric(.data$value)),
      DataFlag = str_trim(.data$dataFlag),
      SensorUnits = .data$units,
      SensorNum = .data$SENSOR_NUM,
      SensorID = .data$SENSOR_ID,
      Duration = .data$durCode
    )
  }
}

#' Basic Query
#'
#' Helper function for CDEC query handling.
#'
#' @param url The query URL.
#' @return The parsed JSON string, as a list.
#'
#' @importFrom RCurl getURL basicHeaderGatherer basicTextGatherer curlOptions
#' @importFrom jsonlite fromJSON
#' @importFrom stringr str_replace_all
#' @keywords internal
basic_query = function(url) {
  header = basicHeaderGatherer()
  content = basicTextGatherer()
  opts = curlOptions(connecttimeout = options()[["cder.timeout"]])
  getURL(url, httpheader = c(Accept = "application/json"),
    header = FALSE, headerfunction = header$update,
    write = content$update, curl = cdec.handle,
    .opts = opts)

  if (header$value()[['status']] != "200")
    stop("CDEC query failed. HTTP status ",
      header$value()[["status"]], ": ",
      header$value()[["statusMessage"]], "\n",
      parse(text = content$value()), call. = FALSE)

  fromJSON(str_replace_all(content$value(), ":null", ':[null]'),
    simplifyDataFrame = TRUE)
}

