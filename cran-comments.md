# cder 0.3-1

This is a resubmission addressing the following issues:

* URL tests now fail gracefully if CDEC web resources are unavailable.
* Version bump to allow resubmission to CRAN, since test failures were
  detected only after package had been published to CRAN.

## Test environments

* Local Windows 10 install, R 4.2.2
* windows-latest (release) (via Github actions)
* macos-latest (release) (via Github actions)
* ubuntu-latest (release) (via Github actions)
* ubuntu-latest (devel) (via Github actions)
* ubuntu-latest (oldrel-1) (via Github actions)


Because the CDEC Web API requires an internet connection, examples 
are only run interactively. 

## R CMD check results

0 ERRORs | 0 WARNINGs | 0 NOTES
