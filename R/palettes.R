# Script to update color palettes image
names <- c("green_machine",
           "bruiser",
           "tealberry_pie", 
           "the_joker",
           "sunset",
           "irish_flag")

n_pal <- length(names)

# Loop through each palette
par(mfrow=c(6, 1), mar=c(3,3,3,15))
for(i in 1:n_pal){
  barplot(rep(1, 5), 
          axes=F, 
          space=0, 
          border=NA,
          col = map_palette(names[i], 5))
  mtext(names[i], 4, las = 1)
}