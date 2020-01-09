#' The hexbin_points function
#'
#' This function allows you to create a hexbin plot from point data.
#' @param points The sfc points object to summarize
#' @param n The approximate number of hexbin cells
#' @param fun The function to apply when summarizing point values in each hexbin cell
#' @param z The column of the SF points object to apply the function to
#' @param buffer The distance by which to buffer the convex hull
#' of points used to create the hexbin cells as a proportion of the
#' maximum interpoint distance. By default set to 0.1 (10\%)
#' @param return.na Logical. Whether or not to return hexbin cells with NAs.
#' @import sf sp
#' @export
#' @keywords hexbin
#' @examples
#' # Load BCG vaccination data
#' data("BCG_vaccination_DRC")
#'
#' # Get mean coverage per hexbin
#' hexbin_points(BCG_vaccination_DRC, n = 250, fun = mean, z = "coverage")
#'
#' # Get number of points per hexbin
#' hexbin_points(BCG_vaccination_DRC, n = 250, fun = length, z = "coverage")

hexbin_points <- function(points,
                          n,
                          fun,
                          z,
                          buffer = 0.1,
                          return.na = FALSE){

  # # Convert sf to sp points
  points_sp <- as(points, "Spatial")

  # create convex hull
  hull <- st_convex_hull(st_union(points))

  # Buffer slightly
  max_dist <- max(dist(st_coordinates(points)))
  hull <- st_buffer(hull, max_dist * buffer)
  hull <- as(hull, "Spatial")

  # Create hexbin
  set.seed(1981)
  HexPts <- spsample(hull, n=n, type="hexagonal")
  HexPols <- HexPoints2SpatialPolygons(HexPts)


  # Calc which hexbin each point is in
  points_sp$hexbin <- over(points_sp, HexPols)

  # Apply function to each hexbin group
  summ_stat <- aggregate(points_sp@data[,z], by=list(points_sp$hexbin), FUN=fun)
  names(summ_stat) <- c("ID", z)
  HexPols <- SpatialPolygonsDataFrame(HexPols,
                                      data.frame(ID = 1:length(HexPols),
                                                 row.names=row.names(HexPols)))
  HexPols <- merge(HexPols, summ_stat, by = "ID", all.x = return.na)

  # Return
  return(st_as_sf(HexPols))
}
