# http://stackoverflow.com/questions/27180242/changing-point-color-on-a-gvismap-in-the-googlevis-r-package

# http://www.researchgate.net/publication/236154592_A_plotGoogleMaps_tutorial

# plotting plotgooglemaps in shiny
# http://stackoverflow.com/questions/18109815/plotgooglemaps-in-shiny-app

# http://diggdata.in/post/51396519384/plotting-geo-spatial-data-on-google-maps-in-r

library(plotGoogleMaps) 
library(sp)
library(googleVis) # for the data
data(Andrew)
coordinates(Andrew) = ~ Long + Lat      
proj4string(Andrew) = CRS("+proj=longlat +datum=WGS84")
Andrew2 <- SpatialPointsDataFrame(Andrew, data = data.frame( ID = row.names(Andrew) ) )  
m <- plotGoogleMaps(Andrew2, filename='myMap1.html')


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

