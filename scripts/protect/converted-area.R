library(raster)
library(tidyverse)
library(sf)
library(exactextractr)
library(units)

# READ IN DATA
grass_baseline <- brick("output_data/spatial/grass_baseline.tif")
shrub_baseline <- brick("output_data/spatial/shrub_baseline.tif")
countries <- st_read("~/Data/gis-data/political/global-national-borders/global-national-borders-10m.shp")

# CALCULATE CHANGE
{
  grass_baseline_change_2040 <- grass_baseline$grass_2040 - grass_baseline$grass_2020
  grass_baseline_change_2100 <- grass_baseline$grass_2100 - grass_baseline$grass_2020
  shrub_baseline_change_2040 <- shrub_baseline$shrub_2040 - shrub_baseline$shrub_2020
  shrub_baseline_change_2100 <- shrub_baseline$shrub_2100 - shrub_baseline$shrub_2020
}

# MULTIPLY BY AREA TO GET AREA CONVERTED
{
  base_grass_area <- (grass_baseline$grass_2020/100) * area(grass_baseline$grass_2020,unit="km")
  area_grass_baseline_change_2040 <- (grass_baseline_change_2040/100) * area(grass_baseline_change_2040,unit="km")
  area_grass_baseline_change_2100 <- (grass_baseline_change_2100/100) * area(grass_baseline_change_2100,unit="km")
}

{
  base_shrub_area <- (shrub_baseline$shrub_2020/100) * area(shrub_baseline$shrub_2020,unit="km")
  area_shrub_baseline_change_2040 <- (shrub_baseline_change_2040/100) * area(shrub_baseline_change_2040,unit="km")
  area_shrub_baseline_change_2100 <- (shrub_baseline_change_2100/100) * area(shrub_baseline_change_2100,unit="km")
}

{
  # Clean up layers
  rm(grass_baseline); rm(shrub_baseline); rm(grass_baseline_change_2040); 
  rm(grass_baseline_change_2100); rm(shrub_baseline_change_2040); rm(shrub_baseline_change_2100)  
}

# # SUMMARIZE TOTAL AREA LOST
# # -1,310,208 sq km grassland lost to 2040 under baseline
# cellStats(area_grass_baseline_change_2040,stat='sum')
# # -9,702,720 sq km grassland lost to 2100 under baseline
# cellStats(area_grass_baseline_change_2100,stat='sum')
# # -1,700,823 sq km shrubland lost to 2040 under baseline
# cellStats(area_shrub_baseline_change_2040,stat='sum')
# # -5,946,521 sq km shrubland lost to 2100 under baseline
# cellStats(area_shrub_baseline_change_2100,stat='sum')

# WRITE DATA
{
  writeRaster(area_grass_baseline_change_2040, "output_data/spatial/area_grass_baseline_change_2040.tif", overwrite=TRUE)
  writeRaster(area_grass_baseline_change_2100, "output_data/spatial/area_grass_baseline_change_2100.tif", overwrite=TRUE)
  
  writeRaster(area_shrub_baseline_change_2040, "output_data/spatial/area_shrub_baseline_change_2040.tif", overwrite=TRUE)
  writeRaster(area_shrub_baseline_change_2100, "output_data/spatial/area_shrub_baseline_change_2100.tif", overwrite=TRUE)
}

# AGGREGATE BY COUNTRY
{
  countries_correct <- st_make_valid(countries)
  countries_correct$area <- units::set_units(st_area(countries_correct),km^2)
  countries_correct$starting_grass <- exact_extract(base_grass_area, countries_correct, 'sum')
  countries_correct$starting_shrub <- exact_extract(base_shrub_area, countries_correct, 'sum')
}

# Total
{
  countries_correct$total_grass_convert_baseline_2040 <- exact_extract(area_grass_baseline_change_2100, countries_correct, 'sum')
  countries_correct$total_grass_convert_baseline_2100 <- exact_extract(area_grass_baseline_change_2040, countries_correct, 'sum')
  countries_correct$total_shrub_convert_baseline_2040 <- exact_extract(area_shrub_baseline_change_2100, countries_correct, 'sum')
  countries_correct$total_shrub_convert_baseline_2100 <- exact_extract(area_shrub_baseline_change_2040, countries_correct, 'sum')
}

# By fraction of area
{
  countries_correct$pctarea_grass_convert_baseline_2040 <- countries_correct$total_grass_convert_baseline_2040 / countries_correct$area
  countries_correct$pctarea_grass_convert_baseline_2100 <- countries_correct$total_grass_convert_baseline_2100 / countries_correct$area
  countries_correct$pctarea_shrub_convert_baseline_2040 <- countries_correct$total_shrub_convert_baseline_2040 / countries_correct$area
  countries_correct$pctarea_shrub_convert_baseline_2100 <- countries_correct$total_shrub_convert_baseline_2100 / countries_correct$area
}

# By fraction of initial grassland area
{
  countries_correct$pctgrassarea_convert_baseline_2040 <- countries_correct$total_grass_convert_baseline_2040 / countries_correct$starting_grass
  countries_correct$pctgrassarea_convert_baseline_2100 <- countries_correct$total_grass_convert_baseline_2100 / countries_correct$starting_grass
  countries_correct$pctshrubarea_convert_baseline_2040 <- countries_correct$total_shrub_convert_baseline_2040 / countries_correct$starting_shrub
  countries_correct$pctshrubarea_convert_baseline_2100 <- countries_correct$total_shrub_convert_baseline_2100 / countries_correct$starting_shrub
}

{
  rm(area_grass_baseline_change_2040); rm(area_grass_baseline_change_2100); rm(area_shrub_baseline_change_2040);
  rm(area_shrub_baseline_change_2100); rm(base_grass_area); rm(base_shrub_area)
}

# WRITE DATA
countries_correct %>% st_drop_geometry() %>% write.csv("output_data/tabular/baseline_area.csv")

rm(countries); rm(countries_correct)
