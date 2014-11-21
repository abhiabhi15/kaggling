source("common.R")
library("gbm")

formula <- count ~ season + season1 + workingday + holiday +daypart+ good_weather + temp  + hour + day + month + humidity + windspeed

## Cross Validation
cvModel <- function(){
    fit <- train(trainData[,-ncol(trainData)], label_data, method = "svmRadial",
                  tuneLength = 10)
    print(fit)
    cat(" ---- Summary of SampleFIt ------")
    summary(fit)
    filename= genPlotFileName(classifier="random", content="Cross Validation Performance")
    png(filename=filename, width=600, height=520, units="px")
    plot(fit)
}

## Training using sample
trainModel <- function(iterations=10){
    errs <- c()
    for(i in 1:iterations){
        sample_index <- sample(1:nrow(trainData), round(0.7 * nrow(trainData)))
        train_sample <- trainData[sample_index,]
        test_sample <- trainData[-sample_index,]
        gtruth <- test_sample[,ncol(test_sample)]
        
        model <- gbm(formula, data=train_sample,n.trees=500, cv.folds=10)
        summary(model)
        pred <- predict( model ,test_sample[,-ncol(test_sample)])
        err <- rmsle(actual=gtruth, predicted=pred)
        cat("Iteration : ", i , " | RMSLE Error : " , err , "\n")
        errs <- append(errs, err)
  }
  plot(errs, xlab="Iterations", ylab="RMSLE Error", main="GBM Error Rate", col="3", pch=20, type="b", ylim=c(0,1))
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
predictModel <- function(){
  modelT <- modelLibsvm(forest_data)
  pred <- predict(modelT, test_data)
  writeOutput("SVM", "../results/svm/svm_output_gopt2.csv", pred)
}
