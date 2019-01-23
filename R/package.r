#' R Interface to CDEC
#'
#' Provides CDEC data download capabilities from R.
#'
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

