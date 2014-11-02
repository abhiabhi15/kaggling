source("utils.R")
library(ggplot2)

sketchHist <- function(data, filename, main, xlab){
    png(filename = filename ,width = 480, height = 480, units = "px")
    hist(data, col = "red", main = main, xlab = xlab)
    dev.off()
}


## Loading Data
forest_data <- getData("../train/transform3.csv")

## Basic Scatter Plots
plot(forest_data$Cover_Type, forest_data$Elevation, xlab="Cover Type", ylab= "Elevation", col="red")
sketchHist(data=forest_data$Elevation,filename="R prog/ncsu/ALDA/sample.png",main="Elevation [Forest Data]", xlab="Elevation in Meters")

library(scatterplot3d)
scatterplot3d(forest_data$Elevation,forest_data$Horizontal_Distance_To_Roadways,forest_data$Horizontal_Distance_To_Fire_Points, main="3D Scatterplot")