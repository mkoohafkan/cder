# cder 0.3-0

This release includes the following changes:

* `cder` now reexports readr::problems() so that users can review
  parsing issues without loading readr
* `cder` now writes the downloaded data to a tempfile when problems are
  encountered so that the user can review reprocess using an alternate
  approach if needed. 

## Test environments

* Local Windows 10 install, R 3.6.1
* Ubuntu 14.04 (via Github actions)

Because the CDEC Web API requires an internet connection, examples 
are only run interactively. 

## R CMD check results

0 ERRORs | 0 WARNINGs | 0 NOTES
