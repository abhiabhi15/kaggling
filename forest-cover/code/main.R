# Main File to call all the functions
## Set the directory path to code
setwd("code/")

# To Run SVM
source("classifiers/svm.R")
predictSVM()
tuneSVM(); dev.off();


# To Run KNN
source("classifiers/knn.R")
trainKNN(k=3)
predictKNN(k=3)
cvKNN("Cross Validation for Extracted Training Set");dev.off()

# To Run Naive Bayesian
source("classifiers/naiveB.R")
trainNB()
cvNB()
predictNB()


# To Run Random Forest
source("classifiers/rf.R")
trainRF(ntree=500, mtry=4)
cvRF();dev.off()
predictRF(ntree=20, mtry=4)

# To Run Neural Network
source("classifiers/nnet.R")
trainNNet(hidden=20, threshold=0.0001)
fit <-cvNNet()
plot(fit)

# To Run DTree CART
source("classifiers/dtree.R")
cvDT();dev.off()
trainDT()

