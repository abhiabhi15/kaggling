#install party package
source("common.R")
library('party')


#build our formula
formula <- count ~ season + holiday + daypart + sunday + workingday + weather + temp + atemp + humidity + hour + day

#build our model
fit.ctree <- ctree(formula, data=trainData)

#examine model for variable importance
fit.ctree

#run model against test data set
predict.ctree <- predict(fit.ctree, testData)

#build a dataframe with our results
submit.ctree <- data.frame(datetime = test_id$datetime, count=predict.ctree)

#write results to .csv for submission
write.csv(submit.ctree, file="../ctree_output_v2.csv",row.names=FALSE)
