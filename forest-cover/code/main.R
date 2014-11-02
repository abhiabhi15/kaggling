# Main File to call all the functions
## Set the directory path to code
setwd("code/")

# To Run SVM
source("classifiers/svm.R")
trainSVM(sigma =1)


# To Run KNN
source("classifiers/knn.R")
trainKNN(k=3)
predictKNN(k=1)


# To Run Naive Bayesian
source("classifiers/naiveB.R")
trainNB()
cvNB()
predictNB()
