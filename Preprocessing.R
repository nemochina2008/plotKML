#Daniel Scheerooren
#Date: 22-10-2015
#Preprocessing script HvA dataset

getwd()
setwd("M:/GeoDataMscThesis")
dir.create("HvA_RawData")
dir.create("HvA_Copy_RawData")
# Copy the RAW data (which you put there) to the Copy folder before setting it as working directory:
origindir <- c("M:/GeoDataMscThesis/HvA_RawData")
targetdir <- c("M:/GeoDataMscThesis/HvA_Copy_RawData")
filestocopy <- c("exp_201301-62014.xlsx", "exp_201306-62014.xlsx", "rapportage_verbruiksdata 201301 + 201306.xlsx")
file.copy(from=filestocopy, to=targetdir)

setwd("M:/GeoDataMscThesis/HvA_Copy_RawData")
list.files()

#Download required packages
install.packages("RCurl")
install.packages("xlsx")
# install.packages("gdata")

#Load required libraries
library(RCurl)
# library(gdata)
library(xlsx)

# DOESNT WORK YET! Package doens't function >>>> Read xlsx file and save as csv file
# Nuon201301_201306 <- read.xls("exp_201306-62014.xlsx", sheetNames("Sheet1", perl = "perl"))
# write.csv(Nuon201301_201306, file = paste(i, "csv", sep = "."), row.names=F)

#Read raw CSV data and create two objects (Nuon/Essent)
NuonRaw<- read.csv("Nuon201301_201306.csv", header = T, sep=",")
EssentRaw01<- read.csv("Essent201301.csv", header = T, sep=",")
EssentRaw06<- read.csv("Essent201306.csv", header = T, sep=",")
  #Merge ROWS of Essent datasets
EssentRaw <- rbind(EssentRaw01, EssentRaw06)

# Download Charge point dataset 
download.file("https://api.essent.nl/generic/downloadChargingStations?latitude_low=52.30567123031878&longtitude_low=4.756801078125022&latitude_high=52.43772606594848&longtitude_high=5.086390921875022&format=CSV",destfile="ChargeStations.csv",method="libcurl")
ChargeStations = read.csv("ChargeStations.csv", header = T, sep=";")
View(ChargeStations)

# Change colomns names (for merge purposes)
names(NuonRaw)[7] <- "Street"
names(NuonRaw)[8] <- "HouseNumber"
names(NuonRaw)[9] <- "PostalCode"
names(EssentRaw)[10] <- "Street"
names(EssentRaw)[11] <- "HouseNumber"
names(EssentRaw)[12] <- "PostalCode"

# Merge charge points x-y coordinates with raw data
nuonXYmerged <- merge(NuonRaw,ChargeStations,by=c("Street","HouseNumber", "PostalCode"))
essentXYmerged <- merge(EssentRaw,ChargeStations, by=c("Street","HouseNumber", "PostalCode"))
View(nuonXYmerged)
View(essentXYmerged)
# Remove unnecessary columns
Essentkeep <- c("Street", "HouseNumber", "PostalCode", "BEGIN_LOAD_DATE", "END_LOAD_DATE", "END_LOAD_TIME", "CHARGETIME", "CHARGE_DURATION", "METER_READ_BEGIN", "METER_READ_END", "ENERGIE", "Latitude", "Longitude", "Provider")
EssentClean <- essentXYmerged[Essentkeep]
Nuonkeep <- c("Street", "HouseNumber", "PostalCode", "Start", "Eind", "Laadtijd", "kWh", "Latitude", "Longitude", "Provider")
NuonClean <- nuonXYmerged[Nuonkeep]

# Change colomns names (for similarity purposes)
names(NuonClean$Start)<- "BEGIN_LOAD_TIME"
# names(NuonRaw)[8] <- "HouseNumber"
# names(NuonRaw)[9] <- "PostalCode"
# names(EssentRaw)[10] <- "Street"
# names(EssentRaw)[11] <- "HouseNumber"
# names(EssentRaw)[12] <- "PostalCode"

#Write object to csv file for viewing outside R environment
write.csv(EssentClean, file = "EssentClean.csv")
write.csv(NuonClean, file= "NuonClean.csv")

