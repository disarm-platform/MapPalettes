# mappalettes
A set of palettes for maps

# Install
```r
library(devtools)  
install_github("HughSt/mappalettes")
```

# Example
```r
library(raster)  
swz_elev <- raster::getData('alt', country="SWZ")  
plot(swz_elev, col=map_palette("hugh_div", n=64), axes=F) 
```
![alt text](https://raw.githubusercontent.com/HughSt/mappalettes/master/images/hugh_div_swz_elev.png)
