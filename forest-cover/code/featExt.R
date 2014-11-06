## Code for feature selection, extraction, aggregation, PCA, SVD etc.
rm(list=ls())
source("utils.R")

## Features Subsetting
features <- c("Elevation", "Soil_Type", "Horizontal_Distance_To_Roadways", 
              "Horizontal_Distance_To_Fire_Points","Area_Of_Wilderness", "Horizontal_Distance_To_Hydrology",
              "Hillshade_3pm", "Aspect" ,"Cover_Type")

forest_data <- getData("../train/transform5.csv")
forest_data <- forest_data[,features]
write.csv(forest_data, "../train/extract1.csv", row.names=F)

names(forest_data)


## PCA 

forest_data <- getData("../train/transform5.csv")
forest_data <- forest_data[,features]
pca <- princomp(forest_data[,-ncol(forest_data)], center=TRUE)
EigenVectors <- pca$scores;  
plot(pca, main="Variance of ES for Transform5 Feature Selected Data")
main = "Transform5(Features Sel) : 1st Eigen vector "
plot(EigenVectors[,1],EigenVectors[,2], col=forest_data$Cover_Type, main=main)
plot(EigenVectors[,1], col=forest_data$Cover_Type, main=main)

## PCA for Soil Type
raw_data <- getData("../train/train.csv")
soil_types <- raw_data[,16:55]
pca <- princomp(soil_types, center=TRUE)
EigenVectors = pca$scores;  
plot(pca, main="Variance of ES for Transform5 Feature Selected Data")
main = "Transform5(Features Sel) : 1st Eigen vector "
plot(EigenVectors[,1],EigenVectors[,2], col=forest_data$Cover_Type, main=main)
plot(EigenVectors[,1], col=forest_data$Cover_Type, main=main)


# KPCA
library(kernlab)
kpc <- kpca(~., data=forest_data[,-ncol(forest_data)], kernel="rbfdot", kpar=list(sigma=0.06))
kpcv <- pcv(kpc)
