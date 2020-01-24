# cder 0.2-2.

This release includes the following changes:

* CDEC actually accounts for daylight savings time as documented in 
https://info.water.ca.gov/misc/sql_dates.html. The correct timezone 
timezone "US/Pacific" is now used.

## Test environments

* Local Windows 10 install, R 3.6.1
* Ubuntu 14.04 (on travis-ci), R-oldrel, R-release, R-devel

Because the CDEC Web API requires an internet connection, examples 
are only run interactively. 

## R CMD check results

0 ERRORs | 0 WARNINGs | 0 NOTES
