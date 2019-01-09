#' The map palette function
#'
#' This function allows you to easily access beautiful palettes designed for maps.
#' @param name The name of the palette 
#' @param n The number of colors in the palette
#' @keywords cats
#' @export
#' @examples map_palette("hugh_div)

map_palette <- function(name,
                        n=5){
  
  if(name=="green_machine"){
    palette <- c("#1D3141","#096168","#209478","#75C56E","#E2EE5E")
  }
    
    pal <- colorRampPalette(palette)
    pal(n)
}

