#' The view palette function
#'
#' This function allows you to easily view beautiful palettes designed for maps.
#' @param palette The name of the palette. One of "green_machine",
#' "irish_flag", "tealberry_pie", "sunset", "the_joker" or "bruiser"
#' or a vector of 5 hex codes.
#' @param n The number of colors in the palette, Defaults to 5. Set to length(palette) if hex codes
#' provided as 'palette'.
#' @param type Either "bars" which shows palette as bars,
#' "raster" which shows elevation in Swaziland or "polys" which
#' shows mean elevation in Swaziland by admin 2 area.
#' @import leaflet
#' @export
#' @examples view_palette("bruiser")
#'
#' # Use custom set of hexcodes
#' view_palette(c("#1D3141","#096168","#209478","#75C56E","#E2EE5E"),
#' type="raster")

view_palette <- function(palette,
                         n = 5,
                         type = "bars"){

  if(length(palette)>1){
    palette <- palette
  }else{
    palette <- map_palette(palette, n)
  }

  if(type=="bars"){
  barplot(rep(1, n),
          axes=F,
          space=0,
          border=NA,
          col = palette)
  }

  if(type=="polys"){
    data("swz_adm2")
    pal <- leaflet::colorQuantile(palette, swz_adm2$elev, n = length(palette))
    plot(swz_adm2, col=pal(swz_adm2$elev))
  }

  if(type=="raster"){
    data("swz_elev")
    plot(swz_elev, col=palette, axes=F)
  }

}
