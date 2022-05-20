library(raster)
library(sf)

#### SET WORKING DIRECTORY ####
require(funr)
setwd(funr::get_script_path())

# dir <- "~/Box Sync/Work/The Nature Conservancy/Provide Food & Water/Food Systems Science Team/Climate Mitigation/BEF-Ag & Grasslands/Grasslands/data"
# setwd(dir)

# Read in land cover data
landCover1992 <- raster("ESACCI-LC-L4-LCCS-Map-300m-P1Y-1992-v2.0.7.tif")
landCover2020 <- raster("C3S-LC-L4-LCCS-Map-300m-P1Y-2020-v2.1.1.tif")

# Reclassify land cover rasters
Grasslands1992 <- clamp(landCover1992, lower=110, upper=130, useValues=TRUE, filename="Grasslands1992.tif")
Grasslands2020 <- clamp(landCover2020, lower=110, upper=130, useValues=TRUE, filename="Grasslands2020.tif")
Agriculture2020 <- clamp(landCover2020, lower=10, upper=40, useValues=TRUE, filename="Agriculture2020.tif")



# Read in carbon data
# manage <- raster('scenario_grass.full_dSOC_Y20.tif')
# restore <- raster('scenario_rewilding_dSOC_Y80.tif')


# # mask data
# masked <- mask(rewild, land)
# 
# # Set data to no data
# x <- reclassify(fullRestoration, cbind(-Inf,0, NA), right=TRUE)
# 
# # Reclassify broader areas
# y <- focal(x, w=matrix(1/25,nrow=5,ncol=5), fun=mean, na.rm=TRUE, NAonly = FALSE)
# 


#writeRaster(y,'scenario_grass.full_dSOC_Y20_smoothed.tif')
