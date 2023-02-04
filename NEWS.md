# cder 0.3-0

## Minor changes

- `cder` now reexports readr::problems() so that users can review
  parsing issues without loading readr
- `cder` now writes the downloaded data to a tempfile when problems are
  encountered so that the user can review reprocess using an alternate
  approach if needed. 


# cder 0.2-2

## Bug Fixes

CDEC actually accounts for daylight savings time as documented in 
https://info.water.ca.gov/misc/sql_dates.html. The correct timezone 
timezone "US/Pacific" is now used.


# cder 0.2-1

## Bug Fixes

The CDEC timezone was incorrectly specified as "Etc/GMT-8". The correct 
timezone "Etc/GMT+8" is now used.


# cder 0.2-0

## Backend Changes

The CDEC Web Services underwent changes over the period of 
August 2-7 which modified the data output format. Functions in 
this package were updated to accomodate this new format.

## Minor Changes

Some functions were renamed and arguments were added to support
drop-in replacement of cder for the now-removed package 
'CDECRetrieve'. Old function names have been soft-deprecated.

## New functions

New functions `cdec_search_*()` were added to support the exploration of metadata
on CDEC. These are largely just wrappers around `browseURL()`, 
since the CDEC web services do not currently support metadata searches.
