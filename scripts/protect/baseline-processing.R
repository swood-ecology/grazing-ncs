library(raster) # package for raster manipulation
library(tidyverse)
library(sf)

setwd("~/Library/CloudStorage/Box-Box/Work/The Nature Conservancy/Provide Food & Water/Food Systems Science Team/Climate Mitigation/BEF-Ag & Grasslands/Grasslands")

# countries <- read_sf("~/Data/gis-data/political/global-national-borders/global-national-borders-10m.shp")
# world_outline <- as(st_geometry(countries), Class="Spatial")

# Read in baseline, defined as SSP 2, RCP 4.5

# # Save the print(nc) dump to a text file
# {
#   sink('ssp2_rcp45_modelmean_2020.txt')
#   print(baseline_2020)
#   sink()
# }

# 2020 Grassland
{
  c4_baseline_2020 <- brick('data/GCAM_Demeter/GCAM_Demeter_LU_ssp2_rcp45_modelmean_2020.nc', varname="PFT14")
  c4_baseline_2020 <- t(flip(c4_baseline_2020, 2))
  proj4string(c4_baseline_2020)=CRS("+proj=longlat +datum=WGS84 +no_defs")
  
  c3_baseline_2020 <- brick('data/GCAM_Demeter/GCAM_Demeter_LU_ssp2_rcp45_modelmean_2020.nc', varname="PFT13")
  c3_baseline_2020 <- t(flip(c3_baseline_2020, 2))
  proj4string(c3_baseline_2020)=CRS("+proj=longlat +datum=WGS84 +no_defs")
  
  c3arctic_baseline_2020 <- brick('data/GCAM_Demeter/GCAM_Demeter_LU_ssp2_rcp45_modelmean_2020.nc', varname="PFT12")
  c3arctic_baseline_2020 <- t(flip(c3arctic_baseline_2020, 2))
  proj4string(c3arctic_baseline_2020)=CRS("+proj=longlat +datum=WGS84 +no_defs")
}

# 2040 Grassland
{
  c4_baseline_2040 <- brick('data/GCAM_Demeter/GCAM_Demeter_LU_ssp2_rcp45_modelmean_2040.nc', varname="PFT14")
  c4_baseline_2040 <- t(flip(c4_baseline_2040, 2))
  proj4string(c4_baseline_2040)=CRS("+proj=longlat +datum=WGS84 +no_defs")
  
  c3_baseline_2040 <- brick('data/GCAM_Demeter/GCAM_Demeter_LU_ssp2_rcp45_modelmean_2040.nc', varname="PFT13")
  c3_baseline_2040 <- t(flip(c3_baseline_2040, 2))
  proj4string(c3_baseline_2040)=CRS("+proj=longlat +datum=WGS84 +no_defs")
  
  c3arctic_baseline_2040 <- brick('data/GCAM_Demeter/GCAM_Demeter_LU_ssp2_rcp45_modelmean_2040.nc', varname="PFT12")
  c3arctic_baseline_2040 <- t(flip(c3arctic_baseline_2040, 2))
  proj4string(c3arctic_baseline_2040)=CRS("+proj=longlat +datum=WGS84 +no_defs")
}

# 2100 Grassland
{
  c4_baseline_2100 <- brick('data/GCAM_Demeter/GCAM_Demeter_LU_ssp2_rcp45_modelmean_2100.nc', varname="PFT14")
  c4_baseline_2100 <- t(flip(c4_baseline_2100, 2))
  proj4string(c4_baseline_2100)=CRS("+proj=longlat +datum=WGS84 +no_defs")
  
  c3_baseline_2100 <- brick('data/GCAM_Demeter/GCAM_Demeter_LU_ssp2_rcp45_modelmean_2100.nc', varname="PFT13")
  c3_baseline_2100 <- t(flip(c3_baseline_2100, 2))
  proj4string(c3_baseline_2100)=CRS("+proj=longlat +datum=WGS84 +no_defs")
  
  c3arctic_baseline_2100 <- brick('data/GCAM_Demeter/GCAM_Demeter_LU_ssp2_rcp45_modelmean_2100.nc', varname="PFT12")
  c3arctic_baseline_2100 <- t(flip(c3arctic_baseline_2100, 2))
  proj4string(c3arctic_baseline_2100)=CRS("+proj=longlat +datum=WGS84 +no_defs")
}

# Aggregate to composite datasets
{
  grass_2020 <- c4_baseline_2020 + c3_baseline_2020 + c3arctic_baseline_2020
  grass_2040 <- c4_baseline_2040 + c3_baseline_2040 + c3arctic_baseline_2040
  grass_2100 <- c4_baseline_2100 + c3_baseline_2100 + c3arctic_baseline_2100
  
  rm(c4_baseline_2020); rm(c3_baseline_2020); rm(c3arctic_baseline_2020);
  rm(c4_baseline_2040); rm(c3_baseline_2040); rm(c3arctic_baseline_2040);
  rm(c4_baseline_2100); rm(c3_baseline_2100); rm(c3arctic_baseline_2100)
}

# 2020 Shrubland
{
  temp_ever_baseline_2020 <- brick('data/GCAM_Demeter/GCAM_Demeter_LU_ssp2_rcp45_modelmean_2020.nc', varname="PFT9")
  temp_ever_baseline_2020 <- t(flip(temp_ever_baseline_2020, 2))
  proj4string(temp_ever_baseline_2020)=CRS("+proj=longlat +datum=WGS84 +no_defs")
  
  temp_decid_baseline_2020 <- brick('data/GCAM_Demeter/GCAM_Demeter_LU_ssp2_rcp45_modelmean_2020.nc', varname="PFT10")
  temp_decid_baseline_2020 <- t(flip(temp_decid_baseline_2020, 2))
  proj4string(temp_decid_baseline_2020)=CRS("+proj=longlat +datum=WGS84 +no_defs")
  
  bor_decid_baseline_2020 <- brick('data/GCAM_Demeter/GCAM_Demeter_LU_ssp2_rcp45_modelmean_2020.nc', varname="PFT11")
  bor_decid_baseline_2020 <- t(flip(bor_decid_baseline_2020, 2))
  proj4string(bor_decid_baseline_2020)=CRS("+proj=longlat +datum=WGS84 +no_defs")
}

# 2040 Shrubland
{
  temp_ever_baseline_2040 <- brick('data/GCAM_Demeter/GCAM_Demeter_LU_ssp2_rcp45_modelmean_2040.nc', varname="PFT9")
  temp_ever_baseline_2040 <- t(flip(temp_ever_baseline_2040, 2))
  proj4string(temp_ever_baseline_2040)=CRS("+proj=longlat +datum=WGS84 +no_defs")
  
  temp_decid_baseline_2040 <- brick('data/GCAM_Demeter/GCAM_Demeter_LU_ssp2_rcp45_modelmean_2040.nc', varname="PFT10")
  temp_decid_baseline_2040 <- t(flip(temp_decid_baseline_2040, 2))
  proj4string(temp_decid_baseline_2040)=CRS("+proj=longlat +datum=WGS84 +no_defs")
  
  bor_decid_baseline_2040 <- brick('data/GCAM_Demeter/GCAM_Demeter_LU_ssp2_rcp45_modelmean_2040.nc', varname="PFT11")
  bor_decid_baseline_2040 <- t(flip(bor_decid_baseline_2040, 2))
  proj4string(bor_decid_baseline_2040)=CRS("+proj=longlat +datum=WGS84 +no_defs")
}

# 2100 Shrubland
{
  temp_ever_baseline_2100 <- brick('data/GCAM_Demeter/GCAM_Demeter_LU_ssp2_rcp45_modelmean_2100.nc', varname="PFT9")
  temp_ever_baseline_2100 <- t(flip(temp_ever_baseline_2100, 2))
  proj4string(temp_ever_baseline_2100)=CRS("+proj=longlat +datum=WGS84 +no_defs")
  
  temp_decid_baseline_2100 <- brick('data/GCAM_Demeter/GCAM_Demeter_LU_ssp2_rcp45_modelmean_2100.nc', varname="PFT10")
  temp_decid_baseline_2100 <- t(flip(temp_decid_baseline_2100, 2))
  proj4string(temp_decid_baseline_2100)=CRS("+proj=longlat +datum=WGS84 +no_defs")
  
  bor_decid_baseline_2100 <- brick('data/GCAM_Demeter/GCAM_Demeter_LU_ssp2_rcp45_modelmean_2100.nc', varname="PFT11")
  bor_decid_baseline_2100 <- t(flip(bor_decid_baseline_2100, 2))
  proj4string(bor_decid_baseline_2100)=CRS("+proj=longlat +datum=WGS84 +no_defs")
}

# Aggregate to composite datasets
{
  shrub_2020 <- temp_ever_baseline_2020 + temp_decid_baseline_2020 + bor_decid_baseline_2020
  shrub_2040 <- temp_ever_baseline_2040 + temp_decid_baseline_2040 + bor_decid_baseline_2040
  shrub_2100 <- temp_ever_baseline_2100 + temp_decid_baseline_2100 + bor_decid_baseline_2100
  
  rm(temp_ever_baseline_2020); rm(temp_ever_baseline_2040); rm(temp_ever_baseline_2100);
  rm(temp_decid_baseline_2020); rm(temp_decid_baseline_2040); rm(temp_decid_baseline_2100);
  rm(bor_decid_baseline_2020); rm(bor_decid_baseline_2040); rm(bor_decid_baseline_2100)
}

# Export rasters
{
  grass_baseline_stk <- stack(grass_2020,grass_2040,grass_2100)
  names(grass_baseline_stk) <- c('grass_2020','grass_2040','grass_2100')
  stars::write_stars(stars::st_as_stars(grass_baseline_stk), "output_data/spatial/grass_baseline.tif")
  rm(grass_2020); rm(grass_2040); rm(grass_2100); rm(grass_baseline_stk)
}

{
  shrub_baseline_stk <- stack(shrub_2020,shrub_2040,shrub_2100)
  names(shrub_baseline_stk) <- c('shrub_2020','shrub_2040','shrub_2100')
  stars::write_stars(stars::st_as_stars(shrub_baseline_stk), "output_data/spatial/shrub_baseline.tif")
  rm(shrub_2020); rm(shrub_2040); rm(shrub_2100); rm(shrub_baseline_stk)
}

# # Read in crops
# crop_baseline_stk <- stack(raster(ncvar_get(baseline_2020, "PFT15"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
#                            raster(ncvar_get(baseline_2020, "PFT16"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
#                            raster(ncvar_get(baseline_2020, "PFT17"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
#                            raster(ncvar_get(baseline_2020, "PFT18"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
#                            raster(ncvar_get(baseline_2020, "PFT19"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
#                            raster(ncvar_get(baseline_2020, "PFT20"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
#                            raster(ncvar_get(baseline_2020, "PFT25"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
#                            raster(ncvar_get(baseline_2020, "PFT26"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
#                            raster(ncvar_get(baseline_2020, "PFT29"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
#                            raster(ncvar_get(baseline_2020, "PFT30"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
#                            raster(ncvar_get(baseline_2040, "PFT15"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
#                            raster(ncvar_get(baseline_2040, "PFT16"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
#                            raster(ncvar_get(baseline_2040, "PFT17"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
#                            raster(ncvar_get(baseline_2040, "PFT18"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
#                            raster(ncvar_get(baseline_2040, "PFT19"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
#                            raster(ncvar_get(baseline_2040, "PFT20"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
#                            raster(ncvar_get(baseline_2040, "PFT25"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
#                            raster(ncvar_get(baseline_2040, "PFT26"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
#                            raster(ncvar_get(baseline_2040, "PFT29"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
#                            raster(ncvar_get(baseline_2040, "PFT30"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
#                            raster(ncvar_get(baseline_2100, "PFT15"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
#                            raster(ncvar_get(baseline_2100, "PFT16"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
#                            raster(ncvar_get(baseline_2100, "PFT17"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
#                            raster(ncvar_get(baseline_2100, "PFT18"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
#                            raster(ncvar_get(baseline_2100, "PFT19"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
#                            raster(ncvar_get(baseline_2100, "PFT20"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
#                            raster(ncvar_get(baseline_2100, "PFT25"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
#                            raster(ncvar_get(baseline_2100, "PFT26"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
#                            raster(ncvar_get(baseline_2100, "PFT29"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
#                            raster(ncvar_get(baseline_2100, "PFT30"), xmn=-360, xmx=360, ymn=-90, ymx=90, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
#                            )
# names(crop_baseline_stk) <- c("corn_2020","wheat_2020","soy_2020","sugar_2020","energy_2020",
#                               "corn_2040","wheat_2040","soy_2040","sugar_2040","energy_2040",
#                               "corn_2100","wheat_2100","soy_2100","sugar_2100","energy_2100")
# 
# {
#   stars::write_stars(stars::st_as_stars(crop_baseline_stk), "output_data/spatial/crop_baseline.tif")
#   rm(crop_baseline_stk)
# }
