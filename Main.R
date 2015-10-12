#Name: Daniel Scheerooren
#Date: 11-10-2015
#Main Script (Set working environment, download, install and initialize packages, download data, transform to kml, plotKML function)

#Set working directory
getwd()
setwd("M:/GeoDataMscThesis/plotKML")

#Create subdirectory
dir.create("M:/GeoDataMscThesis/plotKML/Data", showWarnings = TRUE, recursive = FALSE)

#Istall plotKML package and load library
install.packages("plotKML")
library("plotKML")

#Install RCurl package and load library
install.packages("RCurl")
library(RCurl)

#Install Memisc package and load library 
install.packages("memisc")
library(memisc)

#Download Charge point dataset
URL <- "https://api.essent.nl/generic/downloadChargingStations?latitude_low=52.30567123031878&longtitude_low=4.756801078125022&latitude_high=52.43772606594848&longtitude_high=5.086390921875022&format=CSV"
x <- getURL(URL)
x = read.csv(file=url)
download.file("https://api.essent.nl/generic/downloadChargingStations?latitude_low=52.30567123031878&longtitude_low=4.756801078125022&latitude_high=52.43772606594848&longtitude_high=5.086390921875022&format=CSV",destfile="Data/ChargeStations.csv",method="libcurl")

# 