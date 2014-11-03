source("classifiers/common.R")

## Cross Validation
cvKNN <- function(){
    knnFit <- train(forest_data[,-ncol(forest_data)], label_data, method = "knn",
                  tuneLength = 10, trControl = trainControl(method = "cv"))
    confusionMatrix(knnFit)
}

## Training using sample
trainKNN <- function(k){
    res <- knn(train_data[,-ncol(train_data)] ,k=k, test_sample[,-ncol(test_sample)], cl=cover_type)
    confusionMatrix(data=res, reference=gtruth)
}

## Tuning KNN using libraries
tuneKNN <- function(){
  knnFit <- train(forest_data[,-ncol(forest_data)], forest_data[,ncol(forest_data)], method = "knn",
                  tuneLength = 10, trControl = trainControl(method = "cv"))
}

## Performing Grid Search, for KNN Tuning
gridKNN <- function(from, to, incr){
    i <- 1.1
    accuracies <- c()
    kseq <- seq(from, to, incr)
    for(k in kseq){
        cat("Running knn for : k ", k)
        cm <- trainKNN(k)
        file <- paste(paste("knn_output/knn_output_cm",i,sep=""), "csv" , sep=".")
        write.csv(cm$table, file=file)    
        file <- paste(paste("knn_output/knn_output_metrics",i,sep=""), "csv" , sep=".")
        write.csv(t(cm$byClass), file=file)    
        i <- i+.1
        accuracies <- append(accuracies, cm$overall[1])
    }
    png(filename="KNN_Performance1.1.png", width=980, height=520, units="px")
    plot(sigmaSeq, accuracies, main="KNN classification Accuracy Plot", xlab="k", ylab="Accuracy", pch=20, col="blue")
    dev.off()
}

# Prediction of Test Data
predictKNN <- function(k){
  pred <- knn(forest_data[-ncol(forest_data)], test_data, cl=forest_data$Cover_Type)
  writeOutput("KNN", "../results/knn/knn_output1.csv", pred)
}
