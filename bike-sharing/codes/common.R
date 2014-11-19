rm(list=ls())
source("utils.R")
library(class)
library(caret)
library(e1071)
library(Metrics)

trainData <- getData(getProp("train_data"))
testData <- getData(getProp("test_data"))
test_id <- getData("../test/test_id.csv")

## Sampling data for Evaluation
label_data <- trainData[,ncol(trainData)]
sample_index <- sample(1:nrow(trainData), round(0.9 * nrow(trainData)))
train_sample <- trainData[sample_index,]
count_sample <- train_sample[,ncol(train_sample)]
test_sample <- trainData[-sample_index,]
gtruth <- test_sample[,ncol(test_sample)]



