# cder 0.2-0.

This release includes the following changes:

* The CDEC Web Services underwent changes over the period of 
  August 2-7 which modified the data output format. Functions in 
  this package were updated to accomodate this new format.
* Some functions were renamed and arguments were added to support
  drop-in replacement of cder for the now-removed package 
  CDECRetrieve. Old function names have been soft-deprecated.
* New functions were added to support the exploration of metadata
  on CDEC. These are largely just wrappers around browseURL(), 
  since the CDEC web services do not currently support metadata searches.


## Test environments

* Local Windows 10 install, R 3.6.1
* Ubuntu 14.04 (on travis-ci), R-oldrel, R-release, R-devel

Because the CDEC Web API requires an internet connection, examples 
are only run interactively. 

## R CMD check results

0 ERRORs | 0 WARNINGs | 0 NOTES
