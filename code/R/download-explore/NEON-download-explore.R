## ----packages, eval=FALSE------------------------------------------------
## 
## install.packages("devtools")
## install.packages("neonUtilities")
## install.packages("raster")
## devtools::install_github("NEONScience/NEON-geolocation/geoNEON")
## install.packages("BiocManager")
## BiocManager::install("rhdf5")
## 


## ----setup, eval=FALSE---------------------------------------------------
## 
## # load packages
## library(neonUtilities)
## library(geoNEON)
## library(raster)
## library(rhdf5)
## 
## # Set global option to NOT convert all character variables to factors
## options(stringsAsFactors=F)
## 


## ----stacking-portal, eval=FALSE-----------------------------------------
## 
## # Modify the file path to match the path to your zip file
## stackByTable("~/Downloads/NEON_par.zip")
## 


## ----run-zipsByProduct, eval=FALSE---------------------------------------
## 
## zipsByProduct(dpID="DP1.10098.001", site="WREF",
##               package="expanded", check.size=T,
##               savepath="~/Downloads")
## 


## ----zips-to-stack, eval=FALSE-------------------------------------------
## 
## stackByTable(filepath="~/Downloads/filesToStack10098")
## 


## ----aop-tile, eval=FALSE------------------------------------------------
## 
## byTileAOP("DP3.30015.001", site="WREF", year="2017",
##           easting=580000, northing=5075000, savepath="~/Downloads")
## 


## ----read-par, eval=FALSE------------------------------------------------
## 
## par30 <- readTableNEON(dataFile="~/Downloads/NEON_par/stackedFiles/PARPAR_30min.csv",
##                        varFile="~/Downloads/NEON_par/stackedFiles/variables.csv")
## View(par30)
## 


## ----read-par-var, eval=FALSE--------------------------------------------
## 
## parvar <- read.csv("~/Downloads/NEON_par/stackedFiles/variables.csv")
## View(parvar)
## 


## ----plot-par, eval=FALSE------------------------------------------------
## 
## plot(PARMean~startDateTime,
##      data=par30[which(par30$verticalPosition=="080"),],
##      type="l")
## 


## ----read-vst, eval=FALSE------------------------------------------------
## 
## vegmap <- readTableNEON("~/Downloads/filesToStack10098/stackedFiles/vst_mappingandtagging.csv",
##                      "~/Downloads/filesToStack10098/stackedFiles/variables.csv")
## View(vegmap)
## 
## vegind <- readTableNEON("~/Downloads/filesToStack10098/stackedFiles/vst_apparentindividual.csv",
##                      "~/Downloads/filesToStack10098/stackedFiles/variables.csv")
## View(vegind)
## 


## ----read-vst-var, eval=FALSE--------------------------------------------
## 
## vstvar <- read.csv("~/filesToStack10098/stackedFiles/variables.csv")
## View(vstvar)
## 
## vstval <- read.csv("~/filesToStack10098/stackedFiles/validation.csv")
## View(vstval)
## 


## ----stems, eval=FALSE---------------------------------------------------
## 
## names(vegmap)
## vegmap <- geoNEON::getLocTOS(vegmap, "vst_mappingandtagging")
## names(vegmap)
## 


## ----vst-merge, eval=FALSE-----------------------------------------------
## 
## veg <- merge(vegind, vegmap, by=c("individualID","namedLocation",
##                                   "domainID","siteID","plotID"))
## 


## ----plot-vst, eval=FALSE------------------------------------------------
## 
## symbols(veg$adjEasting[which(veg$plotID=="WREF_085")],
##         veg$adjNorthing[which(veg$plotID=="WREF_085")],
##         circles=veg$stemDiameter[which(veg$plotID=="WREF_085")]/100,
##         xlab="Easting", ylab="Northing", inches=F)
## 


## ----read-aop, eval=FALSE------------------------------------------------
## 
## chm <- raster("~/Downloads/DP3.30015.001/2017/FullSite/D16/2017_WREF_1/L3/DiscreteLidar/CanopyHeightModelGtif/NEON_D16_WREF_DP3_580000_5075000_CHM.tif")
## 


## ----plot-aop, eval=FALSE------------------------------------------------
## 
## plot(chm, col=topo.colors(6))
## 

