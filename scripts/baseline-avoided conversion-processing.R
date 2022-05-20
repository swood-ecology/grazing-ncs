library(ncdf4) # package for netcdf manipulation
library(raster) # package for raster manipulation
library(rgdal) # package for geospatial analysis
library(ggplot2) # package for plotting

setwd("~/Library/CloudStorage/Box-Box/Work/The Nature Conservancy/Provide Food & Water/Food Systems Science Team/Climate Mitigation/BEF-Ag & Grasslands/Grasslands")

# Read in baseline, defined as SSP 2, RCP 4.5
{
  baseline_2020 <- nc_open('data/GCAM_Demeter/GCAM_Demeter_LU_ssp2_rcp45_modelmean_2020.nc')
  baseline_2040 <- nc_open('data/GCAM_Demeter/GCAM_Demeter_LU_ssp2_rcp45_modelmean_2040.nc')
  baseline_2100 <- nc_open('data/GCAM_Demeter/GCAM_Demeter_LU_ssp2_rcp45_modelmean_2100.nc')
}

# # Save the print(nc) dump to a text file
# {
#   sink('ssp2_rcp45_modelmean_2020.txt')
#   print(baseline_2020)
#   sink()
# }

## Read in non-forest data
## In Chen et al forest is defined as PFT1-8

# Read in grasslands
# 2020
{
  c4_baseline_2020 <- ncvar_get(baseline_2020, "PFT14")
  c3_baseline_2020 <- ncvar_get(baseline_2020, "PFT13")
  c3arctic_baseline_2020 <- ncvar_get(baseline_2020, "PFT12")
}
# 2040
{
  c4_baseline_2040 <- ncvar_get(baseline_2040, "PFT14")
  c3_baseline_2040 <- ncvar_get(baseline_2040, "PFT13")
  c3arctic_baseline_2040 <- ncvar_get(baseline_2040, "PFT12")
}
# 2100
{
  c4_baseline_2100 <- ncvar_get(baseline_2100, "PFT14")
  c3_baseline_2100 <- ncvar_get(baseline_2100, "PFT13")
  c3arctic_baseline_2100 <- ncvar_get(baseline_2100, "PFT12")
}

# Read in shrublands
# 2020
{
  temp_ever_baseline_2020 <- ncvar_get(baseline_2020, "PFT9")
  temp_decid_baseline_2020 <- ncvar_get(baseline_2020, "PFT10")
  bor_decid_baseline_2020 <- ncvar_get(baseline_2020, "PFT11")
}
# 2040
{
  temp_ever_baseline_2040 <- ncvar_get(baseline_2040, "PFT9")
  temp_decid_baseline_2040 <- ncvar_get(baseline_2040, "PFT10")
  bor_decid_baseline_2040 <- ncvar_get(baseline_2040, "PFT11")
}
# 2100
{
  temp_ever_baseline_2100 <- ncvar_get(baseline_2100, "PFT9")
  temp_decid_baseline_2100 <- ncvar_get(baseline_2100, "PFT10")
  bor_decid_baseline_2100 <- ncvar_get(baseline_2100, "PFT11")
}

# Convert files to rasters
# Grass
{
  grass_2020 <- raster(c4_baseline_2020, xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")) +
    raster(c3_baseline_2020, xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")) +
    raster(c3arctic_baseline_2020, xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
  rm(c4_baseline_2020); rm(c3_baseline_2020); rm(c3arctic_baseline_2020)
}

{
  grass_2040 <- raster(c4_baseline_2040, xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")) +
    raster(c3_baseline_2040, xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")) +
    raster(c3arctic_baseline_2040, xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
  rm(c4_baseline_2040); rm(c3_baseline_2040); rm(c3arctic_baseline_2040)
}

{
  grass_2100 <- raster(c4_baseline_2100, xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")) +
    raster(c3_baseline_2100, xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")) +
    raster(c3arctic_baseline_2100, xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
  rm(c4_baseline_2100); rm(c3_baseline_2100); rm(c3arctic_baseline_2100)
}

# Shrub
{
  shrub_2020 <- raster(temp_ever_baseline_2020, xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")) +
    raster(temp_decid_baseline_2020, xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")) +
    raster(bor_decid_baseline_2020, xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
  rm(temp_ever_baseline_2020); rm(temp_decid_baseline_2020); rm(bor_decid_baseline_2020)
}

{
  shrub_2040 <- raster(temp_ever_baseline_2040, xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")) +
    raster(temp_decid_baseline_2040, xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")) +
    raster(bor_decid_baseline_2040, xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
  rm(temp_ever_baseline_2040); rm(temp_decid_baseline_2040); rm(bor_decid_baseline_2040)
}

{
  shrub_2100 <- raster(temp_ever_baseline_2100, xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")) +
    raster(temp_decid_baseline_2100, xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")) +
    raster(bor_decid_baseline_2100, xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
  rm(temp_ever_baseline_2100); rm(temp_decid_baseline_2100); rm(bor_decid_baseline_2100)
}

# # Plot rasters
# plot(grass_2020,main="2020 Grasslands")
# plot(grass_2040,main="2040 Grasslands")
# plot(grass_2100,main="2100 Grasslands")
# 
# plot(shrub_2020,main="2020 Shrublands")
# plot(shrub_2040,main="2040 Shrublands")
# plot(shrub_2100,main="2100 Shrublands")

# Export rasters
{
  grass_baseline_stk <- stack(grass_2020,grass_2040,grass_2100)
  names(grass_baseline_stk) <- c('grass_2020','grass_2040','grass_2100')
  stars::write_stars(stars::st_as_stars(grass_baseline_stk), "output_data/grass_baseline.tif")
  rm(grass_2020); rm(grass_2040); rm(grass_2100); rm(grass_baseline_stk)
}

{
  shrub_baseline_stk <- stack(shrub_2020,shrub_2040,shrub_2100)
  names(shrub_baseline_stk) <- c('shrub_2020','shrub_2040','shrub_2100')
  stars::write_stars(stars::st_as_stars(shrub_baseline_stk), "output_data/shrub_baseline.tif")
  rm(shrub_2020); rm(shrub_2040); rm(shrub_2100); rm(shrub_baseline_stk)
}

# Read in crops
crop_baseline_stk <- stack(raster(ncvar_get(baseline_2020, "PFT15"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
                           raster(ncvar_get(baseline_2020, "PFT16"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
                           raster(ncvar_get(baseline_2020, "PFT17"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
                           raster(ncvar_get(baseline_2020, "PFT18"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
                           raster(ncvar_get(baseline_2020, "PFT19"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
                           raster(ncvar_get(baseline_2020, "PFT20"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
                           raster(ncvar_get(baseline_2020, "PFT25"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
                           raster(ncvar_get(baseline_2020, "PFT26"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
                           raster(ncvar_get(baseline_2020, "PFT29"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
                           raster(ncvar_get(baseline_2020, "PFT30"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
                           raster(ncvar_get(baseline_2040, "PFT15"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
                           raster(ncvar_get(baseline_2040, "PFT16"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
                           raster(ncvar_get(baseline_2040, "PFT17"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
                           raster(ncvar_get(baseline_2040, "PFT18"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
                           raster(ncvar_get(baseline_2040, "PFT19"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
                           raster(ncvar_get(baseline_2040, "PFT20"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
                           raster(ncvar_get(baseline_2040, "PFT25"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
                           raster(ncvar_get(baseline_2040, "PFT26"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
                           raster(ncvar_get(baseline_2040, "PFT29"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
                           raster(ncvar_get(baseline_2040, "PFT30"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
                           raster(ncvar_get(baseline_2100, "PFT15"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
                           raster(ncvar_get(baseline_2100, "PFT16"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
                           raster(ncvar_get(baseline_2100, "PFT17"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
                           raster(ncvar_get(baseline_2100, "PFT18"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
                           raster(ncvar_get(baseline_2100, "PFT19"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
                           raster(ncvar_get(baseline_2100, "PFT20"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
                           raster(ncvar_get(baseline_2100, "PFT25"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
                           raster(ncvar_get(baseline_2100, "PFT26"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0")),
                           raster(ncvar_get(baseline_2100, "PFT29"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))+
                           raster(ncvar_get(baseline_2100, "PFT30"), xmn=0, xmx=7200, ymn=0, ymx=3600, crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
                           )
names(crop_baseline_stk) <- c("corn_2020","wheat_2020","soy_2020","sugar_2020","energy_2020",
                              "corn_2040","wheat_2040","soy_2040","sugar_2040","energy_2040",
                              "corn_2100","wheat_2100","soy_2100","sugar_2100","energy_2100")

{
  stars::write_stars(stars::st_as_stars(crop_baseline_stk), "output_data/crop_baseline.tif")
  rm(crop_baseline_stk)
}

# Close read in
nc_close(baseline_2020); nc_close(baseline_2040); nc_close(baseline_2100)
rm(baseline_2020); rm(baseline_2040); rm(baseline_2100)
