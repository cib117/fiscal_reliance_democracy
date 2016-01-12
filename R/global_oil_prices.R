#######################################################################
##  Filename: global_oil_prices.R
##  Purpose: Plot global oil prices across time
##  Uses data from:
##  1. BP Global Oil Price (price of a barrel)
##  Assumes packages:ggplot2, stringr
##  Output to: figures/oilprice.pdf
##  Last Edited: 11 January 2016
##  Christopher Boylan, Penn State University
#######################################################################
## Load Packages and Prepare Directory
#######################################################################
rm(list=ls()) ## remove objects from working environment
set.seed(1804) ## set seed
library(ggplot2); library(stringr) ## load packages
path <- unlist(str_split(getwd(), "/")) ## get path
dir <- ifelse(path[length(path)] == "R", "../", "./") ## set directory 
#######################################################################
## Load and Prepare Data
#######################################################################
prices <- read.csv(paste0(dir,'data/BP-CRUDE_OIL_PRICES.csv'),head=T) ## bp csv
colnames(prices) <-c('date','price_current','price_2013') ## rename vars
prices$date <- as.Date(prices$date,"%Y-%m-%d") ## format date
prices$year <- as.numeric(format(prices$date, "%Y")) ## create year var
prices <- prices[prices$year > 1899 & prices$year < 2011,c('year', 'price_2013')] ## subset time period
prices$pretrt <- ifelse(prices$year <= 1973,1,0) ## indicator for 1973
#######################################################################
## Create Plot
#######################################################################
globalprice <- ggplot(prices, aes(x = year, y = price_2013))+ ## y = oil price, x = 
  geom_line() +
  geom_vline(xintercept = 1973, linetype = "longdash") +
  ylab('Oil Price (2013 dollars)') +
  xlab('Year') +
  theme_bw()

ggsave('figures/oilprice.pdf',globalprice)