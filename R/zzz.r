.onAttach = function(libname, pkgname) {
  if (is.null(options()[["cder.timeout"]])) {
    options(cder.timeout = 30)
  }
}
