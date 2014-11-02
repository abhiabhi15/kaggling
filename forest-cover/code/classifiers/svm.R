source("classifiers/common.R")
library(kernlab)

## Cross Validation
cvSVM <- function(){
  
}

## Training using sample
trainSVM <- function(sigma){
    model <- ksvm(Cover_Type~., data=train_data, type = "C-svc", kernel="rbfdot", cross=10,  C=7, kpar=list(sigma=sigma))
    pred <- predict(model, test_sample[,-ncol(test_sample)])
    confusionMatrix(data=pred, reference=gtruth)
}

## Tuning SVM using libraries
tuneSVM <- function(){
    obj <- tune(svm, Cover_Type~., data = forest_data, ranges = list(gamma = 2^(-1:1), cost = 2^(2:4)),
              tunecontrol = tune.control(sampling = "fix"))
    summary(obj)
    plot(obj)
}

## Performing Grid Search, for SVM Tuning
gridSVM <- function(from, to, incr){
    
    i <- 1.1
    accuracies <- c()
    sigmaSeq <- seq(from, to, incr)
    for(sigma in sigmaSeq){
        cat("Running svm for sigma: ", sigma)
        cm <- trainSVM(sigma)
        file <- paste(paste("svm_output/svm_output_cm",i,sep=""), "csv" , sep=".")
        write.csv(cm$table, file=file)    
        file <- paste(paste("svm_output/svm_output_metrics",i,sep=""), "csv" , sep=".")
        write.csv(t(cm$byClass), file=file)    
        i <- i+.1
        accuracies <- append(accuracies, cm$overall[1])
    }
    png(filename="SVM_Performance1.1.png", width=980, height=520, units="px")
    plot(sigmaSeq, accuracies, main="SVM classification Accuracy Plot [RBF kernel]", xlab="Sigma", ylab="Accuracy", pch=20, col="blue")
    dev.off()
}

# Prediction of Test Data
predictSVM <- function(sigma){
    modelT <- ksvm(Cover_Type~., data=forest_data , type = "C-svc", kernel="rbfdot", cross=10,  C=7, kpar=list(sigma=sigma))
    pred <- predict(modelT, test_data)
    writeOutput("SVM", "../results/svm/svm_output1.csv", pred)
}
