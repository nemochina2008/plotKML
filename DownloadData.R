#Daniel Scheerooren
#Date 12-10-15
#Dowload datasets from Municipality of Amsterdam

library(RCurl)
library(memisc)

## CSV-files
## - Charge stations
## - Air quality improvement locations
## - Air quality measurement stations
## - Payed parking zones
## - Existing solar panels
## - Building energy labels
## - Municipal election results 2014
## - City district borders

#Download Charge point dataset
URL <- "https://api.essent.nl/generic/downloadChargingStations?latitude_low=52.30567123031878&longtitude_low=4.756801078125022&latitude_high=52.43772606594848&longtitude_high=5.086390921875022&format=CSV"
x <- getURL(URL)
x = read.csv(file=url)
download.file("https://api.essent.nl/generic/downloadChargingStations?latitude_low=52.30567123031878&longtitude_low=4.756801078125022&latitude_high=52.43772606594848&longtitude_high=5.086390921875022&format=CSV",destfile="Data/CSV/ChargeStations.csv",method="libcurl")
ChargeStations<- "Data/CSV/ChargeStations.csv"

#Download Improvement locations air quality
URL <- "https://kaart.amsterdam.nl/datasets/datasets-item/t/verbeterlocaties-luchtkwaliteit-1/export/csv"
x <- getURL(URL)
x = read.csv(file=url)
download.file("https://kaart.amsterdam.nl/datasets/datasets-item/t/verbeterlocaties-luchtkwaliteit-1/export/csv",destfile="Data/CSV/ImprovementZonesAirQuality.csv",method="libcurl")
AirImprovementZones <- "Data/CSV/ImprovementZonesAirQuality.csv"

#Download Air quality measurement stations
URL <- "https://kaart.amsterdam.nl/datasets/datasets-item/t/lucht-meetstations-1/export/csv"
x <- getURL(URL)
x = read.csv(file=url)
download.file("https://kaart.amsterdam.nl/datasets/datasets-item/t/lucht-meetstations-1/export/csv",destfile="Data/CSV/AirQualityStations.csv",method="libcurl")
AirQualityStations <- "Data/CSV/AirQualityStations.csv"

#Download Payed Parking Zones
URL <- "https://kaart.amsterdam.nl/datasets/datasets-item/t/parkeertariefgebieden-2015/export/csv"
x <- getURL(URL)
x = read.csv(file=url)
download.file("https://kaart.amsterdam.nl/datasets/datasets-item/t/parkeertariefgebieden-2015/export/csv",destfile="Data/CSV/PayedParkingZones.csv",method="libcurl")
PayedParkingZones <- "Data/CSV/PayedParkingZones.csv"

#Download Existing Solar Panels
URL <- "http://maps.amsterdam.nl/open_geodata/excel.php?KAARTLAAG=ENERGIE_ZONNEPANELEN"
x <- getURL(URL)
x = read.csv(file=url)
download.file("http://maps.amsterdam.nl/open_geodata/excel.php?KAARTLAAG=ENERGIE_ZONNEPANELEN",destfile="Data/CSV/SolarPanels.csv",method="libcurl")
SolarPanels <- "Data/CSV/SolarPanels.csv"

#Download Building Energy Labels
URL <- "http://maps.amsterdam.nl/open_geodata/excel.php?KAARTLAAG=ENERGIE_LABELS"
x <- getURL(URL)
x = read.csv(file=url)
download.file("http://maps.amsterdam.nl/open_geodata/excel.php?KAARTLAAG=ENERGIE_LABELS",destfile="Data/CSV/EnergyLabels.csv",method="libcurl")
EnergyLabels <- "Data/CSV/EnergyLabels.csv"

#Download Municipal Election Results 2014
URL <- "http://maps.amsterdam.nl/open_geodata/excel.php?KAARTLAAG=STEMBUS2014_GR"
x <- getURL(URL)
x = read.csv(file=url)
download.file("http://maps.amsterdam.nl/open_geodata/excel.php?KAARTLAAG=STEMBUS2014_GR",destfile="Data/CSV/ElectionResults2014.csv",method="libcurl")
Election2014 <- "Data/CSV/ElectionResults2014.csv"

#Download City District Borders
URL <- "https://kaart.amsterdam.nl/datasets/datasets-item/t/stadsdeelgrenzen-1/export/csv"
x <- getURL(URL)
x = read.csv(file=url)
download.file("https://kaart.amsterdam.nl/datasets/datasets-item/t/stadsdeelgrenzen-1/export/csv",destfile="Data/CSV/CityDistricts.csv",method="libcurl")
CityDistricts <- "Data/CSV/CityDistricts.csv"

## ESRI .SHP-files (UNZIP FIRST!!)
## - Solar energy potential map
## - Neighborhood borders (Neighborhoods, Neighborhood combinations)

#Download Solar Potential Map
download.file("http://maps.amsterdam.nl/energie_zonwind/ENERGIE_ZONPOTENTIE.ZIP", destfile = "Data/Shapefiles/SolarPotential.zip", method="libcurl")

#Download Area borders (Neighborhoods, Neighborhoodcombinations, Areas, City Districts)
# URL <- "http://maps.amsterdam.nl/gebiedsindeling/GEBIEDSINDELINGEN.ZIP"
# x <- getURL(URL)
# x = read.csv(file=url)
### Unpack and rename different files ### download.file("http://maps.amsterdam.nl/gebiedsindeling/GEBIEDSINDELINGEN.ZIP",destfile="Data/SolarPotential.shp",method="libcurl")
# CityDistricts <- "Data/CityDistricts.shp"
