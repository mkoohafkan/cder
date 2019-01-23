#' R Interface to CDEC
#'
#' Provides CDEC data download capabilities from R.
#'
#' @section Package options:
#'
#' cder uses the following [options()] to configure behavior:
#'
#' \itemize{
#'   \item `cder.timeout`: The maximum time to wait for a response 
#'     from the CDEC Web API.
#' }
#'
#' @docType package
#' @name cder
"_PACKAGE"

#' @importFrom RCurl getCurlHandle
.onLoad = function(libname, pkgname) {
  assign("cdec.handle", getCurlHandle(),
    envir = getNamespace(pkgname))
  assign("cdec.tz", "Etc/GMT-8", envir = getNamespace(pkgname))
}

.onAttach = function(libname, pkgname) {
  if (is.null(options()[["cder.timeout"]])) {
    options(cder.timeout = 30)
  }
}

