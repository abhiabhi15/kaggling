source("classifiers/common.R")
library('randomForest')

## Training using sample
trainRF <- function(ntree,mtry){
  forest.rf <- randomForest(Cover_Type ~ .,data = train_data[,-ncol(train_data)],ntree = 500,mtry = 4)
  confusionMatrix(data=forest.rf, reference=gtruth)
}

## Cross Validation
cvRF <- function(k){
  forest.cv <- rfcv(forest_data[,-ncol(forest_data)],forest_data[,ncol(forest_data)],cv.fold = k)
}

# Prediction of Test Data
predictRF <- function(model){
  forest.pred <- predict(model,test_data,predict.all = T)
  writeOutput("Random Forest", "../results/rf/rf_output1.csv", pred)
}

## Performing Grid Search, for Random Forests Tuning
mtreeGridRF <- function(from, to, incr){
  i <- 1.1
  accuracies <- c()
  kseq <- seq(from, to, incr)
  for(k in kseq){
    cat("Running rf for mtree : ", k)
    cm <- trainKNN(k)
    file <- paste(paste("rf_output/rf1_output_cm",i,sep=""), "csv" , sep=".")
    write.csv(cm$table, file=file)    
    file <- paste(paste("rf_output/rf1_output_metrics",i,sep=""), "csv" , sep=".")
    write.csv(t(cm$byClass), file=file)    
    i <- i+.1
    accuracies <- append(accuracies, cm$overall[1])
  }
  png(filename="RF1_Performance1.1.png", width=980, height=520, units="px")
  plot(sigmaSeq, accuracies, main="RF1 classification Accuracy Plot", xlab="k", ylab="Accuracy", pch=20, col="blue")
  dev.off()
}

## Performing Grid Search, for Random Forests Tuning
ntryGridRF <- function(from, to, incr){
  i <- 1.1
  accuracies <- c()
  kseq <- seq(from, to, incr)
  for(k in kseq){
    cat("Running rf for ntry: ", k)
    cm <- trainKNN(k)
    file <- paste(paste("rf2_output/rf2_output_cm",i,sep=""), "csv" , sep=".")
    write.csv(cm$table, file=file)    
    file <- paste(paste("rf2_output/rf2_output_metrics",i,sep=""), "csv" , sep=".")
    write.csv(t(cm$byClass), file=file)    
    i <- i+.1
    accuracies <- append(accuracies, cm$overall[1])
  }
  png(filename="RF2_Performance1.1.png", width=980, height=520, units="px")
  plot(sigmaSeq, accuracies, main="RF2 classification Accuracy Plot", xlab="k", ylab="Accuracy", pch=20, col="blue")
  dev.off()
}