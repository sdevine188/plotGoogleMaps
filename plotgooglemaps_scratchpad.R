# http://stackoverflow.com/questions/27180242/changing-point-color-on-a-gvismap-in-the-googlevis-r-package

# http://www.researchgate.net/publication/236154592_A_plotGoogleMaps_tutorial

# plotting plotgooglemaps in shiny
# http://stackoverflow.com/questions/18109815/plotgooglemaps-in-shiny-app

# http://diggdata.in/post/51396519384/plotting-geo-spatial-data-on-google-maps-in-r

# http://www2.uaem.mx/r-mirror/web/packages/plotGoogleMaps/vignettes/plotGoogleMaps-intro.pdf
# this is goog tutorial with options for icon type and color

library(plotGoogleMaps) 
library(sp)
library(googleVis) # for the data
data(Andrew)
coordinates(Andrew) = ~ Long + Lat      
proj4string(Andrew) = CRS("+proj=longlat +datum=WGS84")
Andrew2 <- SpatialPointsDataFrame(Andrew, data = data.frame( ID = row.names(Andrew) ) )  
m <- plotGoogleMaps(Andrew2, filename='myMap1.html')

# example - this works
gc <- geocode("56 talmadge hill road, prospect, ct 06712")
gc2 <- geocode("22 skyline drive, prospect, ct 06712")
test3 <- bind_rows(gc, gc2)
test3 <- data.frame(test3)
coordinates(test3) = ~ lon + lat      
proj4string(test3) = CRS("+proj=longlat +datum=WGS84")
test3 <- SpatialPointsDataFrame(test3, data = data.frame( ID = row.names(test3) ) )  
m <- plotGoogleMaps(test3, filename='myMap1.html')


# example with shiny/opcs/data/datafile_20150827
datafile <- read.csv("data/datafile_20150827.csv")
datafile$lat <- sapply(datafile$lat_lon, function(x) as.numeric(unlist(str_split(x, ":")))[1])
datafile$lon <- sapply(datafile$lat_lon, function(x) as.numeric(unlist(str_split(x, ":")))[2])
datafile <- datafile[ , 35:38]
coordinates(datafile) = ~ lon + lat      
proj4string(datafile) = CRS("+proj=longlat +datum=WGS84")
datafile_spdf <- SpatialPointsDataFrame(datafile, data = data.frame( ID = row.names(datafile) ) )  
map <- plotGoogleMaps(datafile_spdf, filename='map.html')

# works for Andrew, but not for my data
andrew3 <- Andrew
coordinates(andrew3) = ~ Long + Lat     
proj4string(andrew3) = CRS("+proj=longlat +datum=WGS84")
andrew3_spdf <- SpatialPointsDataFrame(andrew3, data = data.frame( ID = row.names(andrew3) ) )  
map <- plotGoogleMaps(andrew3_spdf, filename='map.html')

# example http://stackoverflow.com/questions/30130437/how-to-get-image-iconmarker-working-for-plotgooglemaps-r
vessels = data.frame(id = c(1:10)
                     , lat = c(22.0959, 22.5684, 21.9189, 21.8409, 22.4663, 22.7434, 22.1658, 24.5691, 22.4787, 22.3039)
                     , lon = c(114.021, 114.252, 113.210, 113.128, 113.894, 114.613, 113.803, 119.730, 113.910, 114.147))
group1 = vessels[1:5,]
group2 = vessels[6:10,]

coordinates(group1) = ~ lon + lat
proj4string(group1) = CRS("+proj=longlat +datum=WGS84")
group1 <- SpatialPointsDataFrame( group1 , data = data.frame( ID = row.names( group1 ) ))

coordinates(group2) = ~ lon + lat
proj4string(group2) = CRS("+proj=longlat +datum=WGS84")
group2 <- SpatialPointsDataFrame( group2 , data = data.frame( ID = row.names( group2 ) ))


m <- plotGoogleMaps(group1, legend = FALSE, layerName = "Vessels 1"
                    , add =T,
                    iconMarker=rep('http://maps.google.com/mapfiles/kml/shapes/placemark_circle.png',nrow(group1) ), 
                    mapTypeId='ROADMAP', filename = "out.htm")

m <- plotGoogleMaps(group2,legend = FALSE, layerName = "Vessels 2"
                    , previousMap = m , add = F
                    , iconMarker = rep('http://maps.google.com/mapfiles/kml/shapes/placemark_circle.png',nrow(group2) )
                    , filename = "out.htm")

# example w changing icons
# http://www.inside-r.org/packages/cran/plotgooglemaps/docs/iconlabels

# Data preparation
data(meuse)
coordinates(meuse)<-~x+y
proj4string(meuse) <- CRS('+init=epsg:28992')

# zcol argument assigns the icon label
m<-plotGoogleMaps(meuse,zcol='zinc',filename='myMap_z1.htm')
# see results in your working directory

# zinc labels
# assigns just the number value of zinc, gets rid of pin
ic=iconlabels(meuse$zinc, height=12)
m<-plotGoogleMaps(meuse,zcol='zinc',filename='myMap_z2.htm', iconMarker=ic)

# landuse labels and markers
# gets rid of pin and just uses text value for landuse
ic=iconlabels(meuse$landuse, height=12, colPalette=rainbow(15) )
m<-plotGoogleMaps(meuse,zcol='landuse',colPalette=rainbow(15), filename='myMap_lu.htm', iconMarker=ic)

# keeps pin and uses a color
ic=iconlabels(meuse$landuse, height=12, colPalette='#9ECAE1', icon=TRUE)
m<-plotGoogleMaps(meuse,zcol='landuse',colPalette='#9ECAE1', filename='myMap_lu2.htm', iconMarker=ic)

