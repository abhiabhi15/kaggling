source("common.R")

#Random Forest Library
library('randomForest')

# Prediction of Test Data
predictRF <- function(model){
  pred <- predict(model,test_sample[,-ncol(test_sample)],predict.all = T)
  confusionMatrix(data=pred$aggregate, reference=gtruth)
  writeOutput("Random Forest", "../results/rf/rf_output1.csv", pred$aggregate)
  file <- paste(paste("rf_output/rf1_output_metrics",i,sep=""), "csv" , sep=".")
  write.csv(t(pred$aggregate), file=file)
}

RFFinalPredict <- function(ntree,mtry,outputFile){
  model <- randomForest(count ~ .,data = trainData,ntree = 200,mtry = 9)
  pred <- predict( model ,testData, predict.all = T)
  output <- pred$aggregate
  submit.rf <- data.frame(datetime = test_id$datetime, count=output)
  
  #write results to .csv for submission
  write.csv(submit.rf, file="../results/rf/rf_output3.csv",row.names=FALSE)
}