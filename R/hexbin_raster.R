#' The hexbin_raster function
#'
#' This function allows you to create a hexbin plot of a rasterLayer.
#' @param r The rasterLayer
#' @param n The approximate number of hexbin cells
#' @param fun The function you want to apply when summarizing raster values in each hexbin.
#' Note that hexbin_raster uses velox which currently does not support na.rm. To ignore NAs
#' pass function which includes na.rm. See examples.
#' @import velox raster sp
#' @export
#' @keywords hexbin
#' @examples # Generate hexbins and calculate raster mean in each bin
#' hexbin_raster("swz_elev", n = 100, function(x) mean(x, na.rm=TRUE))

hexbin_raster <- function(r, n, fun){

  # create velox
  r_velox <- velox(r)
  r_sp <- as(r, "SpatialPixelsDataFrame")

  # Create hexbin
  set.seed(1981)
  HexPts <-spsample(r_sp, n=n, type="hexagonal")
  HexPols <- HexPoints2SpatialPolygons(HexPts)

  # Extract with function
  HexPols$stat <- r_velox$extract(sp=HexPols, fun=fun)
  return(HexPols)
}
