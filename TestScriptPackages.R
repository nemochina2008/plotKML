#Daniel Scheerooren
#13-10-15
###Help pages:
##https://cran.r-project.org/web/packages/googleVis/vignettes/googleVis_examples.html 
##http://www.inside-r.org/packages/cran/googleVis/docs/gvisAnnotatedTimeLine

#Create subdirectory
mainDir <- "M:/GeoDataMscThesis/"
subDir <- "TestScript"
dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
setwd(file.path(mainDir, subDir))

list.files()

# #Download Charge point dataset
# URL <- "https://api.essent.nl/generic/downloadChargingStations?latitude_low=52.30567123031878&longtitude_low=4.756801078125022&latitude_high=52.43772606594848&longtitude_high=5.086390921875022&format=CSV"
# x <- getURL(URL)
# x = read.csv(file=url)
# download.file("https://api.essent.nl/generic/downloadChargingStations?latitude_low=52.30567123031878&longtitude_low=4.756801078125022&latitude_high=52.43772606594848&longtitude_high=5.086390921875022&format=CSV",destfile="ChargeStations.csv",method="libcurl")
# ChargeStations<- "ChargeStations.csv"

#Load library
library(plotKML)
library(sp)
library(rgdal)

### Read CSV files
CP_TestTimeSlider2_copy <- read.csv("M:/GeoDataMscThesis/TestScript/CP_TestTimeSlider2_copy.csv")
View(CP_TestTimeSlider2_copy)

#Plot latitude vs.longitude 
plot(CP_TestTimeSlider2_copy$Latitude ~ CP_TestTimeSlider2_copy$Longitude, ylab="Latitude", xlab="Longitude", main="Charge Stations", col='red')

#Make date variable understandable for R
CP_TestTimeSlider2_copy$Date <- as.Date(CP_TestTimeSlider2_copy$Date, "%d-%m-%y")
# Or create date variable, using: rDate <- as.Date(CP_TestTimeSlider2_copy$Date, "%d-%m-%y")

#Plot kwH vs. Date
plot(CP_TestTimeSlider2_copy$kWh~rDate, type='h', col='red', ylab="kWh", xlab="Date", main="Charge sessions")
# also possible with type=
# "p" for points,
# "l" for lines,
# "b" for both,
# "c" for the lines part alone of "b",
# "o" for both ‘overplotted’,
# "h" for ‘histogram’ like (or ‘high-density’) vertical lines,
# "s" for stair steps,
# "S" for other steps, see ‘Details’ below,
# "n" for no plotting.

### Google VIS
install.packages("googleVis")
library(googleVis)
library(RJSONIO)

#Create MotionChart (!)
Visualization1 <- gvisMotionChart(CP_TestTimeSlider2_copy, idvar="kWh", timevar='Date')
plot(Visualization1)

#Create Map (Works --> re-scale to Amsterdam region doens't work yet)
#gvisIntensityMap, gvisGeoMap, gvisGeoChart, gvisAnnotatedTimeLine
# Geo <- gvisGeoMap(CP_TestTimeSlider2_copy, locationvar="LatLong", numvar='kWh', options=list(dataMode = "markers"))
# plot(Geo)

#Create callender of kWh use (WORKS!)
Cal <- gvisCalendar(CP_TestTimeSlider2_copy, 
                    datevar="Date", 
                    numvar="kWh",
                    options=list(
                      title="Charged kWh in Amsterdam",
                      height=320,
                      calendar="{yearLabel: { fontName: 'Times-Roman',
                      fontSize: 32, color: '#1A8763', bold: true},
                      cellSize: 10,
                      cellColor: { stroke: 'red', strokeOpacity: 0.2 },
                      focusedCellColor: {stroke:'red'}}")
                    )
plot(Cal)

#Merging different charts! 
GeoCal <- gvisMerge(Geo, Cal, horizontal = TRUE)
plot(GeoCal)
  
#Create Annotated Timeline
Timeline <- gvisAnnotatedTimeLine(CP_TestTimeSlider2_copy, datevar="Date", numvar="kWh", idvar="ID", titlevar="kWh", annotationvar = "", date.format="%d-%m-%y", options=list(gvis.language="nl"))
plot(Timeline)


#Create intensity map
Intense <- gvisIntensityMap(CP_TestTimeSlider2_copy, locationvar="LatLong", numvar='kWh', options=list(dataMode = "markers"))
plot(Intense)

#Create histogram
Hist <- gvisHistogram(CP_TestTimeSlider2_copy, options=list(
  legend="{ position: 'top', maxLines: 2 }",
  colors="['#5C3292', '#1A8763', '#871B47']",
  width=400, height=360))
plot(Hist)