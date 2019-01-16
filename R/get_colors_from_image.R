library(imager)
library(raster)
library(rgdal)
library(RColorBrewer)

# read image
get_colors_from_image <- function(image, n=5){
  
      pic <- load.image(image)

      # Convert to raster
      tiff_file <- paste0(tempfile(),"pic.jpeg")
      save.image(pic, tiff_file, quality = 0.5)
      pic_raster <- raster::brick(tiff_file)
      
      # Resample to lower res
      # agg_factor <- dim(pic_raster)[1:2][which.max(dim(pic_raster)[1:2])] /300
      # pic_raster <- aggregate(pic_raster, agg_factor)

      # Get main clusters
      clusters <- kmeans(values(pic_raster), n)
      dom_clusters <- rev(sort(table(clusters$cluster)))[1:n]
      means <- round(aggregate(values(pic_raster), list(clusters$cluster), mean), 0) 
      means <- subset(means, means$Group.1 %in% names(dom_clusters))
      colors <- NULL
      for(i in 1:nrow(means)){
        colors <- c(colors, 
                    rgb(means[i, 2]/255, 
                         means[i, 3]/255,
                         means[i, 4]/255))
      }
      
      par(mfrow=c(1,2), mar=rep(2,4))
      plot(pic, axes=F)
      barplot(rep(1, length(colors)), 
              axes=F, 
              space=0, 
              border=NA,
              col = colors)
      mtext(colors, at=seq(0.5, 4.5, 1))
      
      return(colors)
}
      
