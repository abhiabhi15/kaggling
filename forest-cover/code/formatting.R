source("utils.R")

## Converting probabilistic output to nearby number
output_data <- getData("../results/svm/svm_en2_output2.csv")
output_data$Cover_Type <- round(output_data$Cover_Type)
writeData(output_data, "../results/svm/svm_output_en2_1.csv")

## Selecting output Data
output_data <- getData("~/Desktop/output.csv")
output_data <- output_data$prediction.Cover_Type.
writeOutput(classifier="SVM",filename="../results/svm/svm_t7_output6.csv",output_data)


getData <- getData("../results/svm/svm_t7_output4.csv")
table(getData$Cover_Type)/56589

# Modifying Transform7 to transform8
forest_data <- getData("../train/transform7.csv")
CT <- as.character(forest_data$Cover_Type)
split <- function(x){
  strsplit(x, "[^[:digit:]]")[[1]][[2]]
}
forest_data$Cover_Type <- as.numeric(sapply(CT, split))
writeData(data=forest_data, filename="../train/transform8.csv")
