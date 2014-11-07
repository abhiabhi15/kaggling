source("classifiers/common.R")
library('randomForest')

## Training using sample
trainRF <- function(ntree,mtry){
  forest.rf <- randomForest(Cover_Type ~ .,data = forest_data,ntree = ntree,mtry = mtry)
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
    cm <- trainRF(ntree = k,mtry = 4)
    file <- paste(paste("../results/rf_output/rf_ntree_output_cm",k,sep=""), "csv" , sep=".")
    write.csv(cm$table, file=file)    
    file <- paste(paste("../results/rf_output/rf_ntree_output_metrics",k,sep=""), "csv" , sep=".")
    write.csv(t(cm$byClass), file=file)
    i <- i + 1
    accuracies <- append(accuracies, cm$overall[1])
  }
  png(filename="../results/rf_output/RF1_ntree_Performance1.1.png", width=980, height=520, units="px")
  plot(kseq, accuracies,type = "b", main="RF1 classification ntree Accuracy Plot", xlab="k", ylab="Accuracy", pch=20, col="blue")
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
    cm <- trainRF(ntree = 90,mtry = k)
    file <- paste(paste("../results/rf_output/rf_mtry_output_cm",k,sep=""), "csv" , sep=".")
    write.csv(cm$table, file=file)    
    file <- paste(paste("../results/rf_output/rf_m try_output_metrics",k,sep=""), "csv" , sep=".")
    write.csv(t(cm$byClass), file=file)                         m
    i <- i + 1
    accuracies <- append(accuracies, cm$overall[1])
  }
  png(filename="../results/rf_output/RF1_mtry_Performance1.1.png", width=980, height=520, units="px")
  plot(kseq, accuracies,type = "b", main="RF1 classification mtry Accuracy Plot", xlab="k", ylab="Accuracy", pch=20, col="blue")
  dev.off()
}