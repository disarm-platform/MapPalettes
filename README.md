# MapPalettes
A set of awesome palettes and functions for maps designed by the DiSARM team at UCSF

# Install
```r
library(devtools)  
install_github("disarm-platform/MapPalettes")
library(MapPalettes)
```
# Palettes
![alt text](https://raw.githubusercontent.com/HughSt/mappalettes/master/images/palettes.png | width=100)

# Examples
```r
view_palette("green_machine", n=64, type = "raster") 
```
![alt text](https://raw.githubusercontent.com/HughSt/mappalettes/master/images/hugh_div_swz_elev.png | width=100)

```r
# To create a hex bin plot from a raster
elevation <- raster::getData('alt', country="SWZ")
hexbins <- hexbin_raster(elevation, n=300, function(x) mean(x, na.rm = TRUE))
col_pal <- colorNumeric(map_palette("bruiser", n=10), hexbins$stat)
plot(hexbins, col = col_pal(hexbins$stat))
```
![alt text](https://raw.githubusercontent.com/HughSt/mappalettes/master/images/hexbin_bruiser.png | width=100)