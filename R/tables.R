#######################################################################
##  Filename: tables.R
##  Purpose: Code to reproduce tables in paper
##  Uses data from:
##  1. Haber Menaldo (2011) APSR data (oil income, fiscal reliance)
##  Assumes packages: stringr, dplyr, DataCombine, xtable
##  Output to: 
##  Last Edited: 11 January 2016
##  Christopher Boylan, Penn State University
#######################################################################
## Load Packages and Prepare Directory
#######################################################################
rm(list=ls()) ## remove objects from working environment
set.seed(1804) ## set seed
library(stringr); library(dplyr); library(DataCombine); library(xtable) ## load packages
path <- unlist(str_split(getwd(), "/")) ## get path
dir <- ifelse(path[length(path)] == "R", "../", "./") ## set directory
#######################################################################
## Load and Prepare Data
#######################################################################
habmen <- read.csv(paste0(dir,'data/haber_menaldo.csv'),stringsAsFactors =F) ## read csv
names(habmen)## check variable names
## subset dataframe, only keep: country name, year, oil income pc, fiscal reliance
habmen <- select(habmen, cnamehabmen, year, 
                 Total_Oil_Income_PC, Fiscal_Reliance)
## only extract obs between 1965-1985
#habmen <- filter(habmen, year == 1974)
## Create lags for fiscal reliance and oil income
habmen <- slide(data = habmen, Var = 'Fiscal_Reliance', GroupVar = 'cnamehabmen',
                NewVar = 'fiscalrel.lag', slideBy = -1)
habmen <- slide(data = habmen, Var = 'Total_Oil_Income_PC', GroupVar = 'cnamehabmen',
                NewVar = 'oilincome.lag', slideBy = -1)
## Create vars for annual percentage differences
habmen$fiscalrel.diff <- (habmen$Fiscal_Reliance - habmen$fiscalrel.lag)/habmen$fiscalrel.lag*100
habmen$oilincome.diff <- (habmen$Total_Oil_Income_PC - habmen$oilincome.lag)/habmen$oilincome.lag*100
## only extract obs between 1965-1985
habmen <- filter(habmen, year ==1974)
## Extract trt (Algeria, Ecuador, Gabon, Mexico, Indonesia, Nigeria, and Trindad) obs
trtdf <- filter(habmen,cnamehabmen == "Algeria" | 
                      cnamehabmen == "Ecuador" |
                      cnamehabmen == "Gabon"  |
                      cnamehabmen == "Indonesia" |
                      cnamehabmen == "Mexico" |
                      cnamehabmen == "Nigeria" |
                      cnamehabmen == "Trinidad and Tobago")
## Extract nontrt (Angola, Bahrain, Chile, E Guinea, Iran,
##                Kuwait, Norway, Oman, Venezuela, Yemen, Zambia) obs
nontrtdf <- filter(habmen,cnamehabmen == "Angola" | 
                         cnamehabmen == "Bahrain" |
                         cnamehabmen == "Chile"  |
                         cnamehabmen == "Equatorial Guinea" |
                         cnamehabmen == "Iran" |
                         cnamehabmen == "Kuwait" |
                         cnamehabmen == "Norway" |
                         cnamehabmen == "Oman" |
                         cnamehabmen == "Venezuela" |
                         cnamehabmen == "Yemen" |
                         cnamehabmen == "Zambia")
#######################################################################
## Print tables
#######################################################################
xtable(trtdf[,c('cnamehabmen', 'fiscalrel.diff')])
xtable(trtdf[,c('cnamehabmen', 'oilincome.diff')])
xtable(nontrtdf[,c('cnamehabmen', 'fiscalrel.diff')])
xtable(nontrtdf[,c('cnamehabmen', 'oilincome.diff')])
