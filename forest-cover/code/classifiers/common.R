rm(list=ls())
library(class)
library(caret)
library(e1071)
source("utils.R")

## Global Data Sets
forest_data <- getData("../train/enhance2_n.csv")
label_data <- forest_data[,ncol(forest_data)]
sample_index <- sample(1:nrow(forest_data), round(0.9 * nrow(forest_data)))
train_data <- forest_data[sample_index,]
cover_type <- train_data[,ncol(train_data)]
test_sample <- forest_data[-sample_index,]
gtruth <- test_sample[,ncol(test_sample)]
test_data <- getData("../test/test_transform4.csv")

writeOutput <- function(classifier, filename, output){
  
  test_dataId <- getData("../test/test_id.csv") # Only ID
  output_data <- cbind(test_dataId, output)
  names(output_data) <- c("Id","Cover_Type")
  write.csv(output_data, filename, row.names=F)
  
  plotFile <- paste(paste(classifier, "Prediction", sep="_"), "png", sep=".")
  plotFile <- paste(paste("../results",tolower(classifier), sep="/"), plotFile, sep="/")
  png(filename=plotFile, width=600, height=520, units="px")
  main <- paste("Prediction of forest cover:", classifier, sep=" ")
  hist(as.numeric(output), main=main, xlab="cover type")
  dev.off()
}
