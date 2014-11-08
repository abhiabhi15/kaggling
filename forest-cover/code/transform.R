#
# Code for Data Transformation
#

source("utils.R")

# Features Reduction
getReducedData <- function(forest_data){
    cover_type <- forest_data[,56]
    area_wild_data <- forest_data[,12:15]
    soil_type_data <- forest_data[,16:55]
    
    forest_data <- forest_data[,2:11]
    forest_data$Area_Of_Wilderness <- crossProduct(area_wild_data, 1:4)
    forest_data$Soil_Type <- crossProduct(soil_type_data, 1:40)
    forest_data$Cover_Type <- cover_type
    forest_data
}

forest_data <- read.csv("../train/train.csv", header=T)
forest_data <- getReducedData(forest_data)
write.csv(forest_data, "../train/transform1.csv", row.names=F)

## Normalization of Data
# Designed for Reduced DataSet only

getNormalizedData <- function(forest_data){
    new_data <- data.frame(matrix(NA, nrow=15120, ncol=10))
    for( col in 1:10){
        col_mean <- mean(forest_data[,col], na.rm=TRUE)
        col_sd <- sd(forest_data[,col], na.rm=TRUE)
        norm_col <- sapply(forest_data[,col], getNormalize, col_mean, col_sd)
        new_data[,col] <- norm_col
    }
    colNames <- names(forest_data)
    sliceCol <- forest_data[,11:13]
    forest_data <- cbind2(new_data, sliceCol)
    names(forest_data) <- colNames
    rm(new_data,sliceCol)
    forest_data
}

forest_data <- getNormalizedData(forest_data)
write.csv(forest_data, "../train/transform2.csv")

## To convert forest data nominal attributes into non-integer form 
getNominalTransformData <- function(forestData){
  forestData$Cover_Type <- paste("C", forestData$Cover_Type, sep = "")
  forestData$Soil_Type <- paste("S", forestData$Soil_Type, sep = "")
  forestData$Area_Of_Wilderness <- paste("W", forestData$Area_Of_Wilderness, sep = "")
  forestData
}

forest_data <- getNominalTransformData(forest_data)
write.csv(forest_data, "../train/transform3.csv", row.names=F)

## To Perform Min-Max Normailization on Reduced Data

getMinMaxNormalizedData <- function(forest_data){
  test_data <- read.csv("../test/test_transform1.csv",header = T)
  for( col in 1:10){
      col_max <- max(test_data[,col], na.rm=TRUE)
      col_min <- min(test_data[,col], na.rm=TRUE)
      norm_col <- sapply(forest_data[,col], getMinMax, col_max, col_min)
      forest_data[,col] <- norm_col
  }
  forest_data
}

forest_data <- getData("../test/test_transform1.csv")
forest_data <- getMinMaxNormalizedData(forest_data)
#forest_data <- getNominalTransformData(forest_data)
write.csv(forest_data, "../test/test_transform5.csv", row.names=F)


forest_data <- getData("../train/enhance2.csv")
forest_data <- getNominalTransformData(forest_data)
write.csv(forest_data, "../train/enhance2_n.csv", row.names=F)

forest_data <- getData("../test/test_transform4.csv")

forest_data$Cover_Type <- "C1" 
head(forest_data)
write.csv(forest_data, "../test/test_transform4_l.csv", row.names=F)
