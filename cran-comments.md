# cder 0.2-1.

This release includes the following changes:

* The CDEC timezone was incorrectly specified. The `cder` locale has been modified 
  to use "ETC/GMT+8".

## Test environments

* Local Windows 10 install, R 3.6.1
* Ubuntu 14.04 (on travis-ci), R-oldrel, R-release, R-devel

Because the CDEC Web API requires an internet connection, examples 
are only run interactively. 

## R CMD check results

0 ERRORs | 0 WARNINGs | 0 NOTES
