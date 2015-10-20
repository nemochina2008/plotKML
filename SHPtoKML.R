#Daniel Scheerooren
#12-10-15
#Function to transform .shp to .kml

#Read KML files
newmap<-readOGR("M:/GeoDataMscThesis/MscGeoKML/ChargeStationsAmsterdam.kml", layer="ChargeStationsAmsterdam")
plot(newmap)

#Write KML file
oldmap <- writeOGR(objectname, dsn = "name.kml", layer = "name", driver = "KML")
