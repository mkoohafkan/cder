#' @title Deprecated functions in package \pkg{cder}.
#' @description The functions listed below are deprecated. Alternative 
#'   functions with similar
#'   functionality are mentioned. Help pages for deprecated functions are
#'   available at \code{help("cder-deprecated")}.
#' @name Deprecated
#' @aliases cder-deprecated
#' @keywords internal
NULL

#' @rdname Deprecated
#' @section \code{cder_query}:
#' For \code{cder_query}, use \code{\link{cdec_query}}.
#'
#' @export
cder_query = function(stations, sensors, durations, start.date, end.date) {
  .Deprecated("cdec_query")
  cdec_query(stations, sensors, durations, start.date, end.date)
}
