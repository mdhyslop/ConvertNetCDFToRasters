#Process_NetCDF_to_individual_rasters
#Script by Michael D. Hyslop, Michigan Tech, November 2017
#This script will read a multidimensional NetCDF file into a RasterBrick object
#and convert each time slice to individual GeoTiff rasters

#list R version
sessionInfo()

#load needed libraries
library(ncdf4)
library(raster)
library(maptools)
library(rgdal)

#check and set working directory - change to your environment
getwd()
setwd("I:/ConvertNetCDFToRasters")

#load NetCDF file name into variable object. Modify for additional files 
#or add loop to process a folder of files. NetCDF File name goes in "" and must be in working directory
#or full path needs to be supplied
kt <- "kt.nc"

#read header file of NetCDF file
nc_open(kt)

#load Precip variable into a RasterBrick object
bkt <- brick(kt, varname="Prec")

#list slice names in file
names(bkt)

#------------------------------------------
#copy names to list vector
#names1<-names(bkt)
#list names
#names1
#create name list without periods in it
#names2<-chartr(".","-", names1)
#------------------------------------------

names2<-chartr(".","-", names(bkt))
#list converted names
# names2

#export each daily raster to GeoTiff file
writeRaster(bkt, filename=names2, bylayer=TRUE, format="GTiff", overwrite=TRUE)

#list objects
ls()

#clean up workspace - removes all objects from memory
rm(list=ls())
ls()


