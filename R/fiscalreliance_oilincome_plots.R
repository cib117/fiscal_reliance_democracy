#######################################################################
##  Filename: fiscalreliance_oilincome_plots.r
##  Purpose: Plot fiscal reliance and oil income for different countries
##  Uses data from:
##  1. Haber Menaldo (2011) APSR data (oil income, fiscal reliance)
##  Assumes packages:dplyr,stringr, ggplot2
##  Output to: figures/treatfiscalreliance.pdf, figures/nontreatfiscalreliance.pdf,
##             figures/treatoilincome.pdf, figures/nontreatoilincome.pdf
##  Last Edited: 11 January 2016
##  Christopher Boylan, Penn State University
#######################################################################
## Load Packages and Prepare Directory
#######################################################################
rm(list=ls()) ## remove objects from working environment
set.seed(1804) ## set seed
library(ggplot2);library(dplyr);library(stringr) ## load packages
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
habmen <- filter(habmen, year >= 1965 & year <= 1985)
## Extract trt (Algeria, Ecuador, Gabon, Mexico, Indonesia, Nigeria, and Trindad) obs
trtplotdf <- filter(habmen,cnamehabmen == "Algeria" | 
                   cnamehabmen == "Ecuador" |
                   cnamehabmen == "Gabon"  |
                   cnamehabmen == "Indonesia" |
                   cnamehabmen == "Mexico" |
                   cnamehabmen == "Nigeria" |
                   cnamehabmen == "Trinidad and Tobago")
## Extract nontrt (Angola, Bahrain, Chile, E Guinea, Iran,
##                Kuwait, Norway, Oman, Venezuela, Yemen, Zambia) obs
nontrtplotdf <- filter(habmen,cnamehabmen == "Angola" | 
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
## Create Plots
#######################################################################
## Plot fiscal reliance for treated countries
trtfiscalrel <- ggplot(trtplotdf, aes(x = year, y = Fiscal_Reliance)) + ##y=fiscal reliance, x=year
  geom_line() + ## line plot
  theme_bw() + ## black and white gg theme
  geom_vline(xintercept = 1974,linetype = "longdash") + ## vertical line at 1974
  ylab('Fiscal Reliance') + ## y-axis label
  xlab('Year') +  ## x-axis label
  facet_wrap( ~ cnamehabmen,ncol=3,scales="free_x") ## facet with 3 cols, y axes vary for plots

## Plot oil income for treated countries
trtoilincome <- ggplot(trtplotdf, aes(x = year, y = Total_Oil_Income_PC)) + ##y=oil income, x=year
  geom_line() + ## line plot
  theme_bw() + ## black and white gg theme
  geom_vline(xintercept = 1974,linetype = "longdash") + ## vertical line at 1974
  ylab('Oil Income per capita') + ## y-axis label
  xlab('Year') +  ## x-axis label
  facet_wrap( ~ cnamehabmen,ncol=3,scales="free_x") ## facet with 3 cols, y axes vary for plots

## Plot fiscal reliance for nontreated countries
nontrtfiscalrel <- ggplot(nontrtplotdf, aes(x = year, y = Fiscal_Reliance)) + ##y=fiscal reliance, x=year
  geom_line() + ## line plot
  theme_bw() + ## black and white gg theme
  geom_vline(xintercept = 1974,linetype = "longdash") + ## vertical line at 1974
  ylab('Fiscal Reliance') + ## y-axis label
  xlab('Year') +  ## x-axis label
  facet_wrap( ~ cnamehabmen,ncol=3,scales="free") ## facet with 3 cols, y axes vary for plots

## Plot fiscal reliance for nontreated countries
nontrtoilincome <- ggplot(nontrtplotdf, aes(x = year, y = Total_Oil_Income_PC)) + ##y=oil incomr, x=year
  geom_line() + ## line plot
  theme_bw() + ## black and white gg theme
  geom_vline(xintercept = 1974,linetype = "longdash") + ## vertical line at 1974
  ylab('Oil Income per capita') + ## y-axis label
  xlab('Year') +  ## x-axis label
  facet_wrap( ~ cnamehabmen,ncol=3,scales="free") ## facet with 3 cols, y axes vary for plots

## Save plots
ggsave('figures/trtfiscalreliance.pdf', trtfiscalrel, width=9.5, height=7)
ggsave('figures/trtoilincome.pdf', trtoilincome, width=9.5, height=7)
ggsave('figures/nontrtfiscalreliance.pdf', nontrtfiscalrel, width=9.5, height=7)
ggsave('figures/nontrtoilincome.pdf', nontrtoilincome, width=9.5, height=7)
