source("classifiers/common.R")
library(rpart)
## 1 Rpart : CART

## Cross Validation
cvDT <- function(){
    dtFit <- train(forest_data[,-ncol(forest_data)], label_data, method = "rpart",
                  tuneLength = 10, trControl = trainControl(method = "cv"))
    print(dtFit)
    cat(" ---- Summary of CART DTREE Fit ------")
    summary(dtFit)
    filename= genPlotFileName(classifier="dtree", content="Cross Validation Performance")
    png(filename=filename, width=600, height=520, units="px")
    plot(dtFit)
}

## Training using sample
trainDT <- function(){
   model <- rpart(Cover_Type ~ (Elevation + Horizontal_Distance_To_Hydrology + 
                    Horizontal_Distance_To_Roadways + Hillshade_3pm + Horizontal_Distance_To_Fire_Points 
                    + Soil_Type),
                      data=train_data, control = rpart.control(cp = 0.005702636))
   pred <- predict(object = model, newdata = test_sample[,-ncol(test_sample)])  
   confusionMatrix(round(pred), gtruth)
}

## Tuning DT using libraries
tuneDT <- function(){
}

## Performing Grid Search, for DT Tuning
gridDT <- function(from, to, incr){
}

# Prediction of Test Data
predictDT <- function(k){
}
