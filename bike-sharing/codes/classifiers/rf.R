source("common.R")

#Random Forest Library
library('randomForest')

## training RF and computing average error
trainRF <- function(iterations =10){
  errs <- c()
  for(i in 1:iterations){
      sample_index <- sample(1:nrow(trainData), round(0.7 * nrow(trainData)))
      train_sample <- trainData[sample_index,]
      test_sample <- trainData[-sample_index,]
      gtruth <- test_sample[,ncol(test_sample)]
      
      model <- randomForest(count ~ .,data = train_sample,ntree = 300,mtry = 7)
      plot(model)
      pred <- predict( model ,test_sample[,-ncol(test_sample)], predict.all = T)$aggregate
      err <- rmsle(actual=gtruth, predicted=pred)
      cat("Iteration : ", i , "| RMSLE Error : " , err , "\n")
      errs <- append(errs, err)
    }
    plot(errs, xlab="Iterations", ylab="RMSLE Error", main="Random Forest Error Rate", col="3", pch=20, type="b", ylim=c(0,1))
    cat("Average RMSLE Error : " , mean(errs))
}

RFFinalPredict <- function(ntree,mtry,outputFile){
  model <- randomForest(count ~ .,data = trainData,ntree = ntree,mtry = mtry)
  pred <- predict( model ,testData, predict.all = T)
  output <- pred$aggregate
  submit.rf <- data.frame(datetime = test_id$datetime, count=output)
  
  #write results to .csv for submission
  write.csv(submit.rf, file=outputFile, row.names=FALSE)
}