#' The view palette function
#'
#' This function allows you to easily view beautiful palettes designed for maps.
#' @param name The name of the palette. One of "green_machine",
#' "irish_flag", "tealberry_pie", "sunset", "the_joker" or "bruiser".
#' @param n The number of colors in the palette, Defaults to 5. 
#' @param type Either "bars" which shows palette as bars, 
#' "raster" which shows elevation in Swaziland or "polys" which 
#' shows mean elevation in Swaziland by admin 2 area. 
#' @export
#' @examples view_palette("bruiser")
 
view_palette <- function(name, 
                         n = 5,
                         type = "bars"){
  
  if(type=="bars"){
  barplot(rep(1, n), 
          axes=F, 
          space=0, 
          border=NA,
          col = map_palette(name, n))
  }
  
  if(type=="polys"){
    data("adm2")
    pal <- colorNumeric(map_palette(name, n), adm2$elev)
    plot(adm2, col=pal(adm2$elev))
  }
  
  if(type=="raster"){
    data("swz_elev")
    plot(swz_elev, col=map_palette(name, n), axes=F)
  }
  
}