#' The view palette function
#'
#' This function allows you to create a hexbin plot of a rasterLayer.
#' @param r The rasterLayer 
#' @param n The approximate number of hexbin cells
#' @param fun The function you want to apply (e.g. mean, max, min) when summarizing raster values in each hexbin
#' @keywords hexbin
#' @export
#' @examples hexbin_raster("swz_elev", 100, mean)

library(sp)
library(leaflet)
library(velox)


hexbin_raster <- function(r, n, fun){
  
  # create velox
  r_velox <- velox(r)
  r_sp <- as(r, "SpatialPixelsDataFrame")
  
  # Create hexbin
  HexPts <-spsample(r_sp, n=n, type="hexagonal")
  HexPols <- HexPoints2SpatialPolygons(HexPts)
  
  # Extract with function
  HexPols$stat <- r_velox$extract(sp=HexPols, fun=fun)
  return(HexPols)
}