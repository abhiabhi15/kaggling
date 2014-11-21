source("common.R")
library(kernlab)

## Cross Validation
cvSVM <- function(){
    svmFit <- train(trainData[,-ncol(trainData)], label_data, method = "svmRadial",
                  tuneLength = 10)
    print(svmFit)
    cat(" ---- Summary of SVM FIt ------")
    summary(svmFit)
    filename= genPlotFileName(classifier="svmRadial", content="Cross Validation Performance")
    png(filename=filename, width=600, height=520, units="px")
    plot(svmFit)
}

## Model using ksvm
modelKsvm <- function(sigma, data){
    model <- ksvm(count~., data=trainData, type = "eps-svr", kernel="rbfdot", cross=10,  C=7, kpar=list(sigma=0.1))
    model
}

## Model using Libsvm(e1071 package)
modelLibsvm <- function(data){
    model <- svm(count ~ ., data = trainData, gamma=1, cost=4)
    print(summary(model))
    plot(model)
    model
}

## Training using sample
trainSVM <- function(iterations=10){
  errs <- c()
  for(i in 1:iterations){
    sample_index <- sample(1:nrow(trainData), round(0.7 * nrow(trainData)))
    train_sample <- trainData[sample_index,]
    test_sample <- trainData[-sample_index,]
    gtruth <- test_sample[,ncol(test_sample)]
    
    model <- svm(count ~ ., data = trainData, gamma=10, cost=4)
    summary(model)
    pred <- predict( model ,test_sample[,-ncol(test_sample)])
    err <- rmsle(actual=gtruth, predicted=pred)
    cat("Iteration : ", i , "| No of Support Vectors : " , model$tot.nSV , " | RMSLE Error : " , err , "\n")
    errs <- append(errs, err)
  }
  plot(errs, xlab="Iterations", ylab="RMSLE Error", main="SVM Error Rate", col="3", pch=20, type="b", ylim=c(0,1))
  cat("Average RMSLE Error : " , mean(errs))
}

## Tuning SVM using libraries
tuneSVM <- function(){
    obj <- tune(svm, Cover_Type~., data = forest_data, ranges = list(gamma = 2^(-2:7), cost = 2^(2:4)),
              tunecontrol = tune.control(sampling = "fix"))
    print(summary(obj))
    png(filename="SVM_Grid_Search2.png", width=600, height=520, units="px")
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
    writeOutput("SVM", "../results/svm/svm_output_gopt2.csv", pred)
}
