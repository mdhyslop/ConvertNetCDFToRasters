#load needed libraries
library(ncdf4)
library(raster)
library(maptools)
library(rgdal)
#check and set working directory
getwd()
setwd("E:/downloads")
#load NetCDF file name into variable object
kt <- "kt.nc"
#read header file of NetCDF file
nc_open(kt)
#put Precip varibale in RasterBrick object type
bkt <- brick(kt, varname="Prec")
#list slice names in file
names(bkt)
#copy names to list vector
names1<-names(bkt)
#list names
names1
#create name list without periods in it
names2<-chartr(".","-", names1)
#list converted names
names2
#export each daily raster to GeoTiff file
writeRaster(bkt, filename=names2, bylayer=TRUE, format="GTiff", overwrite=TRUE)
#writeRaster(bkt, filename=names(bkt), bylayer=TRUE, format="GTiff")
#writeRaster(bkt, filename=names(bkt), bylayer=TRUE, format="GTiff", overwrite=TRUE)
#help(writeRaster)

for(i in seq_along(names(bkt))){writeRaster(bkt, filename=names2, bylayer=TRUE, format="GTiff", overwrite=TRUE)}

foo.export = NULL
for(i in seq_along(names(bkt))){
  foo.export[i] = writeRaster(bkt, filename=names(bkt), bylayer=TRUE, format="GTiff", overwrite=TRUE)
  }
rm(list=ls())