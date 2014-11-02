source("classifiers/common.R")

## Cross Validation
cvNB <- function(){
  nbFit <- train(forest_data[,-ncol(forest_data)], forest_data[,ncol(forest_data)], method = "nb",
                  tuneLength = 10, trControl = trainControl(method = "cv"))
  nbFit
}

## Training using sample [Categorical]
trainNB <- function(){
  model <- naiveBayes(Cover_Type ~ ., data = train_data, laplace=3)
  pred <- predict(model, train_data[,-ncol(train_data)])
  confusionMatrix(data=pred, reference=cover_type)
}

## Tuning NB using libraries
tuneNB <- function(){
  
}

## Performing Grid Search, for KNN Tuning
gridNB <- function(from, to, incr){
  
}

# Prediction of Test Data
predictNB <- function(k){
  model <- naiveBayes(Cover_Type ~ ., data = forest_data)
  pred <- predict(model, test_data)
  writeOutput("NB", "../results/nb/nb_output1.csv", pred)
}
