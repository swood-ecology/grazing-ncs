library(httr)
library(tidyverse)
library(boxr)
library(ncdf4) # package for netcdf manipulation

box_auth(client_id = "vtpj75wf93dx5p9v5hz68dyw3oxosm9p", client_secret = "nghlwNaWFKT647f6RDWMHXmaOr17GEwe")

res = GET("https://tnc.box.com/s/3b9avtw1gst47az1a3ij2qxzgp74w1rp")


nc_data_2015 <- nc_open('GCAM_Demeter_LU_ssp1_rcp26_modelmean_2015.nc')
