source("classifiers/common.R")
library('randomForest')

## Cross Validation
cvRF <- function(){
    forest.rf <- randomForest(Cover_Type ~ .,data = forest_data,ntree = 500,mtry = 4)
    forest.cv <- rfcv(forest_data[,1:ncol(forest_data)-1],forest_data[,ncol(forest_data)],cv.fold = 10)
    forest.cv
}

## Training using sample [Categorical]
trainRF <- function(ntree, mtry){
    forest.rf <- randomForest(Cover_Type ~ .,data =train_data,ntree = ntree,mtry = mtry)
    forest.pred <- predict(forest.rf,test_sample[,-ncol(test_sample)],predict.all = T)
    confusionMatrix(forest.pred$aggregate, gtruth)
}

## Tuning RF using libraries
tuneRF <- function(){
  
}

## Performing Grid Search, for KNN Tuning
gridRF <- function(from, to, incr){
  
}

# Prediction of Test Data
predictRF <- function(ntree, mtry){
    forest.rf <- randomForest(Cover_Type ~ ., data = forest_data, ntree = ntree, mtry = mtry)
    forest.pred <- predict(forest.rf, test_data, predict.all = T)
    writeOutput("RF", "../results/rf/rf_output1.csv", pred)
}
