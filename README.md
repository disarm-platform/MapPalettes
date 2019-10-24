# MapPalettes
A set of nifty palettes and functions for maps designed by the DiSARM team at UCSF

# Install
```r
library(devtools)  
install_github("disarm-platform/MapPalettes")
library(MapPalettes)
```
# Palettes
<img src="https://raw.githubusercontent.com/HughSt/mappalettes/master/images/palettes.png" height="600">

# Examples
```r
view_palette("green_machine", n=64, type = "raster") 
```
<img src="https://raw.githubusercontent.com/HughSt/mappalettes/master/images/hugh_div_swz_elev.png" width="500">

### To create a hex bin plot from a raster
```r
library(leaflet) # for colorNumeric function
data("swz_elev")
hexbins <- hexbin_raster(swz_elev, n=300, function(x) mean(x, na.rm = TRUE))
col_pal <- colorNumeric(map_palette("bruiser", n=10), hexbins$stat)
plot(hexbins, col = col_pal(hexbins$stat))
```
<img src="https://raw.githubusercontent.com/HughSt/mappalettes/master/images/hexbin_bruiser.png" width="500">


### To create a hex bin plot from points and plot using leaflet
This example uses the supplied Demographic and Health Survey data on BCG vaccination 
in the DRC
```r
library(leaflet) 

# Load data
data("BCG_vaccination_DRC")

# Generate hexbins
hexbins <- hexbin_points(BCG_vaccination_DRC, n = 400, fun = mean, z = "coverage")

# Generate color palette
col_pal <- colorNumeric(rev(map_palette("tealberry_pie", n=10)), hexbins$stat)

# Plot
leaflet() %>% addProviderTiles("CartoDB.DarkMatter") %>%
          addPolygons(data = hexbins, col = col_pal(hexbins$coverage),
          fillOpacity = 0.7) %>%
          addLegend(pal = col_pal, values = hexbins$coverage, 
          title = "Coverage")
```
<img src="https://raw.githubusercontent.com/HughSt/mappalettes/master/images/hexbin_points_leaflet.png" width="800">


### To get main color groups from an image
```r
get_colors_from_image("https://raw.githubusercontent.com/HughSt/mappalettes/master/images/nathan-lindahl-1j18807_ul0-unsplash.jpg",5)
[1] "#0C080B" "#142D40" "#425662" "#B3330C" "#F8A14B"
```
<img src="https://raw.githubusercontent.com/HughSt/mappalettes/master/images/fire_colors.png" width="500">
