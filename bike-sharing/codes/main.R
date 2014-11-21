setwd("codes/")

## Decision Trees( Ctree, Rpart)
source("classifiers/dTree.R")
trainDT(20)

## Random Forest
source("classifiers/rf.R")
trainRF(iterations=3)
RFFinalPredict(ntree=400, mtry=7, outputFile="../results/rf/rf_output6.csv")
cvRF()
gridRF(from=10, to=20, incr=2)

## SVM
source("classifiers/svm.R")
trainSVM(iterations=3)
cvSVM()


## Random Classifiers # GBM
source("classifiers/trial.R")
trainModel()
