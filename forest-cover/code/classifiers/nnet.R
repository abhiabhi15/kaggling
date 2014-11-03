source("classifiers/common.R")
library("neuralnet")

## Cross Validation
cvNNet <- function(){
   nnFit <- train(forest_data[,-ncol(forest_data)], label_data, method = "nnet",
                  tuneLength = 10, trControl = trainControl(method = "cv"))
}

## Training using sample [Categorical]
trainNNet <- function(){
    model <- neuralnet(Cover_Type ~ Elevation + Aspect + Slope +
                           Horizontal_Distance_To_Hydrology + Vertical_Distance_To_Hydrology +
                           Horizontal_Distance_To_Roadways + Hillshade_9am + Hillshade_Noon +
                           Hillshade_3pm + Horizontal_Distance_To_Fire_Points + Area_Of_Wilderness + Soil_Type
                         , train_data, hidden = 15, linear.output = FALSE, threshold = 0.01)
    pred <- compute(model, test_sample[,-ncol(test_sample)])
    pred <- round(pred$net.result)
    pred
    #confusionMatrix(pred, gtruth)
}

## Tuning RF using libraries
tuneNNet <- function(){
  
}

## Performing Grid Search, for Neural Network Tuning
gridNNet <- function(from, to, incr){
  
}

# Prediction of Test Data
predictNNet <- function(){
    
}
