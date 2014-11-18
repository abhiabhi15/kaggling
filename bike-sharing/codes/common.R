rm(list=ls())
source("utils.R")
trainData <- getData(getProp("train_data"))
testData <- getData(getProp("test_data"))
test_id <- getData("../test/test_id.csv")

