#install party package
source("common.R")
library(party)
library(rpart)

formula <- count ~ season + season1 + workingday + holiday +daypart+ good_weather + temp  + hour + day + month + humidity + windspeed

cvDTree <- function(){
    dtFit <- train(trainData[,-ncol(trainData)], label_data, method = "ctree2",
                    tuneLength = 10)
    print(dtFit)
    cat(" ---- Summary of DT FIt ------\n")
    summary(dtFit)
    filename= genPlotFileName(classifier="dtree", content="Ctree Cross Validation Performance")
    png(filename=filename, width=600, height=520, units="px")
    plot(dtFit)
}

## Training and Computing Average Error
trainDT <- function(iterations =10){
    errs <- c()
    for(i in 1:iterations){
        sample_index <- sample(1:nrow(trainData), round(0.7 * nrow(trainData)))
        train_sample <- trainData[sample_index,]
        test_sample <- trainData[-sample_index,]
        gtruth <- test_sample[,ncol(test_sample)]
        fit.tree <- train(train_sample[,-ncol(train_sample)], train_sample[,ncol(train_sample)], method = "ctree2",
                          tuneLength = 10)
        #fit.tree <- rpart(formula, data=train_sample)
        predict.tree <- predict(fit.tree, test_sample[,-ncol(test_sample)])
        err <- rmsle(actual=gtruth, predicted=predict.tree)
        cat("Iteration : ", i , "| RMSLE Error : " , err , "\n")
        errs <- append(errs, err)
    }
    plot(errs, xlab="Iterations", ylab="RMSLE Error", main="CTree Error Rate", col="3", pch=20, type="b", ylim=c(0,1))
    cat("Average RMSLE Error : " , mean(errs))
}

## Tuning DT using libraries
trainDTRpart <- function(){
    model <- rpart(formula, data=trainData)
    pred <- predict(object = model, newdata = test_sample[,-ncol(test_sample)])  
}

## Performing Grid Search, for DT Tuning
gridDT <- function(){
}

# Prediction of Test Data
predictDT <- function(){
    fit.tree <- ctree(formula, data=trainData)
    predict.tree <- predict(fit.tree, testData)
    submit.tree <- data.frame(datetime = test_id$datetime, count=predict.tree)
    #write results to .csv for submission
    write.csv(submit.tree, file="../results/dtree/ctree_output_v4.csv",row.names=FALSE)
}

