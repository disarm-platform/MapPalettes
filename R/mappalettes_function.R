#' The map palette function
#'
#' This function allows you to easily access beautiful palettes designed for maps.
#' @param name The name of the palette 
#' @param n The number of colors in the palette
#' @keywords cats
#' @export
#' @examples map_palette("green_machine")

map_palette <- function(name,
                        n=5){
  
  if(name=="green_machine"){
    palette <- c("#1D3141","#096168","#209478","#75C56E","#E2EE5E")
  }
  
  if(name=="irish_flag"){
    palette <- c("#2a8f27", "#95c08b", "#f1f1f1", "#ffbefe", "#ff8b26")
  }
  
  if(name=="tealberry_pie"){
    palette <- c("#00778a", "#82a2bf", "#d4d2e5", "#b77daf", "#a30248")
  }
  
  if(name=="sunset"){
    palette <- c("#f09000", "#fec289", "#f6f6f6", "#9dc7e4", "#0099d1")
  }
  
  if(name=="the_joker"){
    palette <- c("#488f31", "#8cbcac", "#f1f1f1", "#b896d6", "#783dba")
  }
  
  if(name=="bruiser"){
    palette <- c("#1E313E","#43435A","#725370","#A4607C","#D4717D","#FA8975")
  }
    
    pal <- colorRampPalette(palette)
    pal(n)
}

