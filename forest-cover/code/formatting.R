source("utils.R")

## Converting probabilistic output to nearby number
output_data <- getData("../results/svm/svm_output_en2_1.csv")
output_data$Cover_Type <- round(output_data$Cover_Type)
writeData(output_data, "../results/svm/svm_output_en2_1.csv")
