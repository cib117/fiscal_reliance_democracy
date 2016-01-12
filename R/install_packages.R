#######################################################################
##  Filename: install_packages.R
##  Purpose: Code to install packages used in other scripts
##  Uses data from:
## 
##  Assumes packages: 
##  Output to: 
##  Last Edited: 12 January 2016
##  Christopher Boylan, Penn State University
#######################################################################
## packages used
pkgs <- c("ggplot2", "stringr", "xtable", "dplyr", "DataCombine")
## install them
install.packages(pkgs)