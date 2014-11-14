source("classifiers/common.R")
library(kernlab)

## Cross Validation
cvSVM <- function(){
    svmFit <- train(forest_data[,-ncol(forest_data)], label_data, method = "svmRadial",
                  tuneLength = 10, trControl = trainControl(method = "cv"))
    print(svmFit)
    cat(" ---- Summary of SVM FIt ------")
    summary(svmFit)
    filename= genPlotFileName(classifier="SVM", content="Cross Validation Performance")
    png(filename=filename, width=600, height=520, units="px")
    plot(svmFit)
}

## Model using ksvm
modelKsvm <- function(sigma, data){
    model <- ksvm(Cover_Type~., data=data, type = "C-svc", kernel="rbfdot", cross=10,  C=7, kpar=list(sigma=sigma))
    model
}

## Model using Libsvm(e1071 package)
modelLibsvm <- function(data){
  model <- svm(Cover_Type ~ ., data = data)
  model
}

## Training using sample
trainSVM <- function(sigma){
    model <- modelKsvm(sigma, train_data)
    pred <- predict(model, test_sample[,-ncol(test_sample)])
    confusionMatrix(data=pred, reference=gtruth)
}

## Tuning SVM using libraries
tuneSVM <- function(){
    obj <- tune(svm, Cover_Type~., data = forest_data, ranges = list(gamma = 2^(-2:7), cost = 2^(2:4)),
              tunecontrol = tune.control(sampling = "fix"))
    summary(obj)
    png(filename="SVM_Grid_Search.png", width=600, height=520, units="px")
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
predictSVM <- function(){
    modelT <- modelLibsvm(forest_data)
    pred <- predict(modelT, test_data)
    writeOutput("SVM", "../results/svm/svm_output_en2_1.csv", pred)
}
