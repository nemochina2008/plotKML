#Daniel Scheerooren
#Date: 22-10-2015
#Preprocessing script HvA dataset

getwd()
setwd("M:/GeoDataMscThesis")
dir.create("HvA_Raw_datset")
dir.create("HvA_Copy_RawData")
setwd("M:/GeoDataMscThesis/HvA_Copy_RawData")

#Download required packages
install.packages("RCurl")
# install.packages("xlsx")
# install.packages("gdata")

#Load required libraries
library(RCurl)
# library(gdata)
# library(xlsx)

list.files()

# #Read xlsx file and save as csv file
# NuonXLSX <- read.xls("exp_201306-62014.xlsx", sheetNames("Sheet1", perl = "perl"))
# write.csv(NuonXLSX, file = paste(i, "csv", sep = "."), row.names=F)

#Read raw CSV data
NuonRaw<- read.csv("Nuon201301_201306.csv", header = T, sep=",")
EssentRaw01<- read.csv("Essent201301.csv", header = T, sep=",")
EssentRaw06<- read.csv("Essent201306.csv", header = T, sep=",")

#Merge Essent datasets
m <- merge(EssentRaw01, EssentRaw06)
write.csv(m, file = "Essent2013JanJun.csv")

# Download Charge point dataset 
download.file("https://api.essent.nl/generic/downloadChargingStations?latitude_low=52.30567123031878&longtitude_low=4.756801078125022&latitude_high=52.43772606594848&longtitude_high=5.086390921875022&format=CSV",destfile="ChargeStations.csv",method="libcurl")
ChargeStations = read.csv("ChargeStations.csv", header = T, sep=";")
View(ChargeStations)

# Merge charge points x-y coordinates with raw data



# Or try 'Panda' package
# df1 = pd.read_csv("file1.csv")
# df2 = pd.read_csv("file2.csv")
# merged = df1.merge(df2, on="id", how="outer").fillna("")
# merged.to_csv("merged.csv", index=False)