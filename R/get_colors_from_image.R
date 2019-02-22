#' The get_colors_from_image function
#'
#' This function allows you to identify the dominant colors in an image.
#' @param image The path to the image. Supports most image types.
#' See image_read from magick package.
#' @param n The number of colors in the palette. Defaults to 5.
#' @return The hex codes of the n colors in the palette
#' @export
#' @import magick
#' @examples get_colors_from_image("https://upload.wikimedia.org/wikipedia/commons/e/e3/Red-eyed_Tree_Frog_%28Agalychnis_callidryas%29_1.png")


library(magick)
library(raster)

get_colors_from_image <- function(image, n=5){

      pic <- image_read(image)

      # Resample to lower res
      pic <- image_scale(pic, "300x")

      # Convert to raster
      tiff_file <- paste0(tempfile(),"pic.jpeg")
      image_write(pic, path = tiff_file, format = 'tiff')
      pic_raster <- raster::brick(tiff_file)


      # Get main clusters
      set.seed(1981)
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

      # To sort colors, choose closest
      # then sequentially choose nearest neighbour
      RGBs <- means[,-1]
      # num_clusters <- 2
      # EPS <- 100
      # clusters <- list(NULL)
      # i <- 1
      # while(num_clusters<5){
      #
      #   dbscan_res <- dbscan(RGBs, EPS, minPts = 1)
      #   num_clusters <- length(unique(dbscan_res$cluster))
      #   clusters[[i]] <- dbscan_res$cluster
      #   EPS <- EPS - 0.1
      #   i <- i+1
      # }
      #
      # uniques <- unique(clusters)
      # i <- length(uniques)-1
      #
      # cluster_order <- list()
      # while(i > 0){
      #   cluster_order[[i]] <-
      #     which(uniques[[i]] %in% uniques[[i]][duplicated(uniques[[i]])])
      #   i <- i - 1
      # }

      hc <- hclust(dist(RGBs))
      browser()
      par(mfrow=c(1,2), mar=rep(2,4))
      plot(pic)
      barplot(rep(1, length(colors)),
              axes=F,
              space=0,
              border=NA,
              col = colors[hc$order])
      #mtext(colors, at=seq(0.5, n-0.5, length.out = n),
      #      las = 0, cex=0.6)

      return(colors)
}

