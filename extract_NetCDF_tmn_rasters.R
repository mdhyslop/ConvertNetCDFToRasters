library(ncdf4)    #allows R to read netCDF format files
library(raster)   #adds raster processig functiuons to R
library(maptools) #adds functionality for handling spatial objects
library(rgdal)    #adds raster library GDAL

#filenames of 3 files to import - monthly average min temperature values
nctmn15 <- "cru_ts3.24.01.2011.2015.tmn.dat.nc"
nctmn00 <- "cru_ts3.24.01.1991.2000.tmn.dat.nc"
nctmn10 <- "cru_ts3.24.01.2001.2010.tmn.dat.nc"

#read cdf files into variables
ncin15 <- nc_open(nctmn15)
ncin00 <- nc_open(nctmn00)
ncin10 <- nc_open(nctmn10)
#Convert CDF files to RasterBrick format 
#second commented lines with writeRaster would separate into individual monthly GeoTiffs; 
#this step is unnecessary with extract command in next code block
b15 <- brick(nctmn15, varname="tmn")
#writeRaster(b, filename=names(b), bylayer=TRUE, format="GTiff")
b00 <- brick(nctmn00, varname="tmn")
#writeRaster(b0, filename=names(b0), bylayer=TRUE, format="GTiff")
b10 <- brick(nctmn10, varname="tmn")
#writeRaster(b1, filename=names(b1), bylayer=TRUE, format="GTiff")

#read point location data into SPDF
#shapefile is named "all" and is in CWD
shapefileData <- readOGR(".", "all")

#extract raster values at point locations
#write.csv saves values to text file
rasterOut15 <- extract(b15, shapefileData)
write.csv(rasterOut15, file = "tmn_monthly2011_15.csv")
rasterOut00 <- extract(b00, shapefileData)
write.csv(rasterOut00, file = "tmn_monthly1991_00.csv")
rasterOut10 <- extract(b10, shapefileData)
write.csv(rasterOut10, file = "tmn_monthly2001_10.csv")