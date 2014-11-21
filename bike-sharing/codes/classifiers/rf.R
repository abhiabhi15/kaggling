source("common.R")

library('randomForest')
library(scatterplot3d)

## Cross Validation
cvRF <- function(){
    rfFit <- train(trainData[,-ncol(trainData)], label_data, method = "rf", tuneLength = 10)
    print(rfFit)
    cat(" ---- Summary of RF FIt ------")
    print(summary(rfFit))
    filename= genPlotFileName(classifier="RF", content="Cross Validation Performance")
    png(filename=filename, width=600, height=520, units="px")
    plot(rfFit)
}


## training RF and computing average error
trainRF <- function(iterations =10, ntree, mtry){
  errs <- c()
  for(i in 1:iterations){
      sample_index <- sample(1:nrow(trainData), round(0.7 * nrow(trainData)))
      train_sample <- trainData[sample_index,]
      test_sample <- trainData[-sample_index,]
      gtruth <- test_sample[,ncol(test_sample)]
      
      model <- randomForest(count ~ .,data = train_sample,ntree = ntree,mtry = mtry)
      # plot(model)
      pred <- predict( model ,test_sample[,-ncol(test_sample)], predict.all = T)$aggregate
      err <- rmsle(actual=gtruth, predicted=pred)
      #cat("Iteration : ", i , "| RMSLE Error : " , err , "\n")
      errs <- append(errs, err)
    }
    #plot(errs, xlab="Iterations", ylab="RMSLE Error", main="Random Forest Error Rate", col="3", pch=20, type="b", ylim=c(0,1))
    #cat("Average RMSLE Error : " , mean(errs))
    mean(errs)
}

gridRF <- function(from, to, incr){
    errs <- c()
    nseq <- seq(from, to, incr)
    mseq <- seq(3, 5, 1)
    ns <- c(); ms <- c()
    for(n in nseq){
        for( m in mseq){
            cat("Running rf for ntree : ", n, " | attrs m : ", m ,"\n")
            err <- trainRF(iterations=3, ntree=n, mtry=m)
            cat("Error Rate : ", err ,"\n--------------------\n")
            errs <- append(errs, err)  
            ns <- append(ns, n)
            ms <- append(ms, m)
        }
    }
    minErr <- which.min(errs)
    cat("Overall Mininum Error  ", errs[minErr], "\n")
    cat("Number of tree : " ,nseq[minErr], "\n")
    cat("Number of Attributes : ", mseq[minErr], "\n")
    z <- errs
    x <- ns
    y <- ms
    scatterplot3d(x, y, z, highlight.3d = TRUE, col.axis = "blue", xlab="No of Trees", 
                  ylab="No of Attrs", zlab="Error Rate", col.grid = "lightblue",
                  main = "Random Forest Error Plot", pch = 20)
}



RFFinalPredict <- function(ntree,mtry,outputFile){
  model <- randomForest(count ~ .,data = trainData,ntree = ntree,mtry = mtry)
  pred <- predict( model ,testData, predict.all = T)
  output <- pred$aggregate
  submit.rf <- data.frame(datetime = test_id$datetime, count=output)
  
  #write results to .csv for submission
  write.csv(submit.rf, file=outputFile, row.names=FALSE)
}