source("classifiers/common.R")

#Random Forest Library
library('randomForest')

## Training using sample
trainRF <- function(ntree,mtry){
  forest.rf <- randomForest(Cover_Type ~ .,data = train_data,ntree = ntree,mtry = mtry)
  pred <- predict(forest.rf,test_sample[,-ncol(test_sample)],predict.all = T)
  confusionMatrix(data=pred$aggregate, reference=gtruth)
}

## Cross Validation
cvRF <- function(k){
  forest.cv <- rfcv(forest_data[,-ncol(forest_data)],forest_data[,ncol(forest_data)],cv.fold = k)
}

# Prediction of Test Data
predictRF <- function(model){
  pred <- predict(model,test_sample[,-ncol(test_sample)],predict.all = T)
  confusionMatrix(data=pred$aggregate, reference=gtruth)
  writeOutput("Random Forest", "../results/rf/rf_output1.csv", pred$aggregate)
  file <- paste(paste("rf_output/rf1_output_metrics",i,sep=""), "csv" , sep=".")
  write.csv(t(pred$aggregate), file=file)
}

## Performing Grid Search, for Random Forests Tuning
ntreeGridRF <- function(from, to, incr){
  accuracies <- c()
  kseq <- seq(from, to, incr)
  i <- 1
  for(k in kseq){
    cat("Running rf for ntree : ", k)
    cat("\n")
    cm <- trainRF(ntree = k,mtry = 20)
    file <- paste(paste("../results/rf_output/rf_ntree_output_cm",k,sep=""), "csv" , sep=".")
    write.csv(cm$table, file=file)    
    file <- paste(paste("../results/rf_output/rf_ntree_output_metrics",k,sep=""), "csv" , sep=".")
    write.csv(t(cm$byClass), file=file)
    i <- i + 1
    accuracies <- append(accuracies, cm$overall[1])
  }
  png(filename="../results/rf_output/RF3_ntree_Performance1.1.png", width=980, height=520, units="px")
  plot(kseq, accuracies,type = "b", main="RF classification ntree Accuracy Plot", xlab="ntree", ylab="Accuracy(Cross-Validation)", pch=20, col="blue")
  dev.off()
}

## Performing Grid Search, for Random Forests Tuning
mtryGridRF <- function(from, to, incr){
  accuracies <- c()
  kseq <- seq(from, to, incr)
  i <- 1
  for(k in kseq){
    cat("Running rf for mtry : ", k)
    cat("\n")
    cm <- trainRF(ntree = 200,mtry = k)
    file <- paste(paste("../results/rf_output/rf_mtry_output_cm",k,sep=""), "csv" , sep=".")
    write.csv(cm$table, file=file)    
    file <- paste(paste("../results/rf_output/rf_mtry_output_metrics",k,sep=""), "csv" , sep=".")
    write.csv(t(cm$byClass), file=file)                         
    i <- i + 1
    accuracies <- append(accuracies, cm$overall[1])
  }
  png(filename="../results/rf_output/RF3_mtry_Performance1.1.png", width=980, height=520, units="px")
  plot(kseq, accuracies,type = "b", main="RF classification mtry Accuracy Plot", xlab="mtry", ylab="Accuracy(Cross-Validation)", pch=20, col="blue")
  dev.off()
}

RFFinalPredict <- function(ntree,mtry,outputFile){
  forest.rf <- randomForest(Cover_Type ~ .,data = forest_data,ntree = ntree,mtry = mtry)
  forest.pred <- predict(forest.rf,test_data,predict.all = T)
  output <- forest.pred$aggregate
  test_id <- read.csv("../test/test_id.csv") # Only ID
  output <- substr(output,2,2)
  output_data <- cbind(test_id, output)
  names(output_data) <- c("Id","Cover_Type")
  head(output_data)
  write.csv(output_data, outputFile, row.names=F)
}