source("utils.R")

## Converting probabilistic output to nearby number
output_data <- getData("../results/svm/svm_en2_output2.csv")
output_data$Cover_Type <- round(output_data$Cover_Type)
writeData(output_data, "../results/svm/svm_output_en2_1.csv")

## Selecting output Data
output_data <- getData("~/Desktop/output.csv")
output_data <- output_data$prediction.Cover_Type.
writeOutput(classifier="SVM",filename="../results/svm/svm_t7_output5.csv",output_data)


getData <- getData("../results/svm/svm_t7_output3.csv")
table(getData$Cover_Type)/565892
