setwd("codes/")

## Decision Trees( Ctree, Rpart)
source("classifiers/dTree.R")
trainDT(20)

## Random Forest
source("classifiers/rf.R")
trainRF(iterations=3)
RFFinalPredict(ntree=50, mtry=7, outputFile="../results/rf/rf_output5.csv")


## SVM
source("classifiers/svm.R")
trainSVM(iterations=3)
cvSVM()
