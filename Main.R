#Name: Daniel Scheerooren
#Date: 11-10-2015

#Set working directory
getwd()
setwd("M:/GeoDataMscThesis/plotKML")

#Istall plotKML package
install.packages("plotKML")
library("plotKML")

#Load Charge point data
install.packages("RCurl")
library(RCurl)
URL <- "https://api.essent.nl/generic/downloadChargingStations?latitude_low=52.30567123031878&longtitude_low=4.756801078125022&latitude_high=52.43772606594848&longtitude_high=5.086390921875022&format=CSV"
x <- getURL(URL)
x = read.csv(file=url)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",destfile="ChargeStations.csv",method="libcurl")

# 