#Daniel Scheerooren
#12-10-15
#Use plotKML function to transform spacetime object to KML

#Load library
library(plotKML)
library(sp)
library(rgdal)

### Read CSV files
CP_TestTimeSlider2_copy <- read.csv("M:/GeoDataMscThesis/TestScript/CP_TestTimeSlider2_copy.csv")
View(CP_TestTimeSlider2_copy)

# #Read KML files
# newmap<-readOGR("M:/GeoDataMscThesis/MscGeoKML/ChargeStationsAmsterdam.kml", layer="ChargeStationsAmsterdam")
# plot(newmap)
# 
# #Write KML file
# oldmap <- writeOGR(objectname, dsn = "name.kml", layer = "name", driver = "KML")

#Set projection system
proj4string(CP_TestTimeSlider2_copy) <- CRS("+init=epsg:4326")

#Make date variable understandable for R
CP_TestTimeSlider2_copy$Date <- as.Date(CP_TestTimeSlider2_copy$Date, "%d-%m-%y")

#plot KML
plotKML(Geo)


OBJECTtoKML <- function(filename){
  
}