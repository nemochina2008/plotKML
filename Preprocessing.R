#Daniel Scheerooren
#Date: 22-10-2015
#Preprocessing script HvA dataset

getwd()
setwd("M:/GeoDataMscThesis")
dir.create("HvA_RawData") # Mannualy put the raw charge data in this folder. Data is not downloadable. 
dir.create("HvA_Copy_RawData")
origindir <- c("M:/GeoDataMscThesis/HvA_RawData")
targetdir <- c("M:/GeoDataMscThesis/HvA_Copy_RawData")
filestocopy <- list.files(origindir, all.files = T)
file.copy(filestocopy, targetdir)
setwd("M:/GeoDataMscThesis/HvA_Copy_RawData")

#Download required packages
install.packages("RCurl")
install.packages("openxlsx")
library(RCurl)
library(openxlsx)

# Read xlsx file and create R-objects
NuonRaw <- read.xlsx("M:/GeoDataMscThesis/HvA_Copy_RawData/rapportage_verbruiksdata 201301 + 201306.xlsx", sheet = 1, colNames = TRUE)
EssentRaw01 <- read.xlsx("M:/GeoDataMscThesis/HvA_Copy_RawData/exp_201301-62014.xlsx", sheet = 1, colNames = TRUE)
EssentRaw06 <- read.xlsx("M:/GeoDataMscThesis/HvA_Copy_RawData/exp_201306-62014.xlsx", sheet = 1, colNames = TRUE)
  #Merge ROWS of Essent datasets Jan+Jun
EssentRaw <- rbind(EssentRaw01, EssentRaw06)

# Download Charge point dataset 
download.file("https://api.essent.nl/generic/downloadChargingStations?latitude_low=52.30567123031878&longtitude_low=4.756801078125022&latitude_high=52.43772606594848&longtitude_high=5.086390921875022&format=CSV",destfile="ChargeStations.csv",method="libcurl")
ChargeStations = read.csv("ChargeStations.csv", header = T, sep=";")

View(NuonRaw)
View(EssentRaw)
View(ChargeStations)

### Make Nuon/Essent data equal (date/time/PostalCode/kWH)
#Place space between numbers and letter PostalCode
NuonRaw$PostalCode <- gsub("([0-9])([A-Z])", "\\1 \\2", space) 
#Convert text to date 
NuonRaw$Start <- as.POSIXct(NuonRaw$Start, tz = "GMT") #Zet ingelezen datum om naar datum/tijd notering, maar niet de juiste!
NuonRaw$Eind <- as.POSIXct(NuonRaw$Eind, tz = "GMT")
#Create 4 empty columns in R
NuonRaw$BEGIN_LOAD_DATE <- NA
NuonRaw$BEGIN_LOAD_TIME <- NA
NuonRaw$END_LOAD_DATE <- NA
NuonRaw$END_LOAD_TIME <- NA
#Split date and time and assign to column
NuonRaw$BEGIN_LOAD_DATE <- sapply(strsplit(as.character(NuonRaw$Start), " "), "[", 1) #Creates an object, but not a column in the data sheet.
NuonRaw$BEGIN_LOAD_TIME <- sapply(strsplit(as.character(NuonRaw$Start), " "), "[", 2)
NuonRaw$END_LOAD_DATE <- sapply(strsplit(as.character(NuonRaw$Eind), " "), "[", 1)
NuonRaw$END_LOAD_TIME <- sapply(strsplit(as.character(NuonRaw$Eind), " "), "[", 2)

# Rename column by name: (for merge purposes)
names(NuonRaw)[names(NuonRaw)=="Straat"] <- "Street"
names(NuonRaw)[names(NuonRaw)=="Huisnummer"] <- "HouseNumber"
names(NuonRaw)[names(NuonRaw)=="Laadtijd"] <- "CONNECT_TIME"
names(EssentRaw)[names(EssentRaw)=="STREET"] <- "Street"
names(EssentRaw)[names(EssentRaw)=="HOUSE_NUM1"] <- "HouseNumber"
names(EssentRaw)[names(EssentRaw)=="ENERGIE"] <- "kWh"
names(EssentRaw)[names(EssentRaw)=="CHARGE_DURATION"] <- "CONNECT_TIME"

# Add xy-coordinates of charge point dataset to charge datasets
nuonXYmerged <- merge(NuonRaw,ChargeStations,by=c("Street","HouseNumber"))
essentXYmerged <- merge(EssentRaw,ChargeStations, by=c("Street","HouseNumber"))

# Remove unnecessary columns
keep <- c("Street", "HouseNumber", "PostalCode", "BEGIN_LOAD_DATE", "END_LOAD_DATE", "BEGIN_LOAD_TIME", "END_LOAD_TIME", "CONNECT_TIME", "kWh", "Latitude", "Longitude", "Provider")
EssentClean <- essentXYmerged[keep]
NuonClean <- nuonXYmerged[keep]

#Write object to csv file for viewing outside R environment
write.csv(EssentClean, file = "M:/GeoDataMscThesis/HvA_Copy_RawData/EssentClean.csv")
write.csv(NuonClean, file= "M:/GeoDataMscThesis/HvA_Copy_RawData/NuonClean.csv")

