cdec.tz = "US/Pacific"

#' Query CDEC
#'
#' Query data from the CDEC web services.
#'
#' @param stations A vector of station codes.
#' @param sensors A vector of sensor numbers.
#' @param durations A vector of durations.
#' @param start.date The start date of the query.
#' @param end.date The end date of the query.
#' @param ... Not used.
#' @return A dataframe.
#'
#' @details Note that CDEC timestamps are always in Pacific
#'   Standard Time, i.e. daylight savings adjustments are not
#'   reflected. In R, this is equivalent to the timezone
#'   "Etc/GMT+8".
#'
#' @examples
#' if(interactive()){
#'   cdec_query("NSL", 100, "E", Sys.Date() - 5, Sys.Date())
#' }
#'
#' @importFrom tibble tibble as_tibble
#' @importFrom dplyr rename transmute if_else near
#' @importFrom stringr str_c str_trim str_to_upper str_sub
#' @importFrom lubridate ymd_hms as_date
#' @importFrom glue glue
#' @importFrom rlang .data
#' @export
cdec_query = function(stations, sensors, durations, start.date, end.date, ...) {
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
    glue("https://cdec.water.ca.gov/dynamicapp/req/CSVDataServlet?",
      "{station.comp}", "{sensor.comp}", "{duration.comp}",
      "{start.comp}", "{end.comp}"),
    station.spec
  )
  rename(result,
    StationID = .data$STATION_ID,
    DateTime = .data$`DATE TIME`,
    SensorType = .data$SENSOR_TYPE,
    Value = .data$VALUE,
    DataFlag = .data$DATA_FLAG,
    SensorUnits = .data$UNITS,
    SensorNumber = .data$SENSOR_NUMBER,
    Duration = .data$DURATION,
    ObsDate = .data$`OBS DATE`
  )
}

#' Query CDEC Group
#'
#' Query group data from the CDEC web services.
#'
#' @param groups A vector of group codes.
#' @inheritParams cdec_query
#' @return A dataframe.
#'
#' @details Note that CDEC timestamps are always in Pacific
#'   Standard Time, i.e. daylight savings adjustments are not
#'   reflected. In R, this is equivalent to the timezone
#'   "Etc/GMT+8".
#'
#' @examples
#' if(interactive()){
#'   cdec_query_group("SR1", Sys.Date() - 5, Sys.Date())
#' }
#'
#' @importFrom tibble tibble as_tibble
#' @importFrom dplyr rename transmute if_else near
#' @importFrom stringr str_c str_trim str_to_upper str_sub
#' @importFrom lubridate ymd_hms as_date
#' @importFrom glue glue
#' @importFrom rlang .data
#' @export
cdec_query_group = function(groups, start.date, end.date, ...) {
  if (missing(groups)) {
    stop("No groups provided.", call. = FALSE)
  } else {
    group.comp = glue("GroupIds={str_c(str_to_upper(groups), collapse = '%2C')}")
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
    glue("http://cdec.water.ca.gov/dynamicapp/req/CSVGroupServlet?",
      "{group.comp}", "{start.comp}", "{end.comp}"),
    group.spec
  )
  rename(result,
    StationID = .data$STATION_ID,
    DateTime = .data$ACTUAL_DATE,
    SensorType = .data$SENSOR_TYPE,
    Value = .data$VALUE,
    DataFlag = .data$DATA_FLAG,
    SensorUnits = .data$UNITS,
    SensorNumber = .data$SENSOR_NUM,
    Duration = .data$DUR_CODE,
    ObsDate = .data$OBS_DATE
    )
}

#' Basic Query
#'
#' Helper function for CDEC query handling.
#'
#' @param url The query URL.
#' @return A dataframe.
#'
#' @importFrom curl curl_fetch_memory parse_headers
#' @importFrom readr locale read_csv
#' @importFrom stringr str_replace_all
#' @keywords internal
basic_query = function(url, col.spec) {
  result = curl_fetch_memory(url, handle = cder_handle())
  if (result$status_code != 200L)
    stop("CDEC query failed with status ",
      parse_headers(result$headers)[1], "\n",
      parse(text = rawToChar(result$content)), "\n",
      "URL request: ", result$url,
      call. = FALSE)
  value = rawToChar(result$content)
  Encoding(value) = "UTF-8"
  read_csv(value, locale = locale(tz = cdec.tz),
    na = "---", col_types = col.spec)
}

#' cder curl handle
#'
#' Get the handle for curl URL handling in cder.
#'
#' @importFrom curl new_handle handle_setopt handle_setheaders
#' @keywords internal
cder_handle = function() {
  h = new_handle()
  handle_setopt(h, connecttimeout = getOption("cder.timeout"))
  handle_setheaders(h, Accept = "application/json")
  h
}

#' Column specification for station data queries.
#'
#' @importFrom readr cols col_character col_integer col_datetime col_double
#' @keywords internal
station.spec = cols(
  STATION_ID = col_character(), DURATION = col_character(),
  SENSOR_NUMBER = col_integer(), SENSOR_TYPE = col_character(),
  `DATE TIME` = col_datetime(), `OBS DATE` = col_datetime(),
  VALUE = col_double(), DATA_FLAG = col_character(),
  UNITS = col_character())

#' Column specification for group data queries.
#'
#' @importFrom readr cols col_character col_integer col_datetime col_double
#' @keywords internal
group.spec = cols(
  STATION_ID = col_character(), DUR_CODE = col_character(),
  SENSOR_NUM = col_integer(), SENSOR_TYPE = col_character(),
  ACTUAL_DATE = col_datetime(), OBS_DATE = col_datetime(),
  VALUE = col_double(), DATA_FLAG = col_character(),
  UNITS = col_character()
)
