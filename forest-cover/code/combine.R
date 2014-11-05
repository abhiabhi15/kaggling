
# TODO: To change the code as per new directory structure
files <- list.files("../results/")
print(files)
combine <- data.frame(0,nrow=565893, ncol=10)
for( i in 1:length(files)){
    file <- paste("outputs", files[i], sep="/")
    xx <- read.csv(file, header=FALSE)
    combine <- cbind(combine, xx[,2])
}

combine <- combine[,-c(1:3)]
colnames(combine) <- c(1:10)
write.csv(combine, file="combine_results.csv", row.names=F)


## TO Enhance Training Data Set
outputs <- read.csv("~/aldaProject/main/data/combine_results.csv")
head(outputs)

pureClass <- which(outputs[,1] == outputs[,2] &
            outputs[,1] == outputs[,3] &
            outputs[,1] == outputs[,4] &
            outputs[,1] == outputs[,5] &
            outputs[,1] == outputs[,6] &
            outputs[,1] == outputs[,7] 
       )

labels <- outputs[pureClass, 1]
length(pureClass)/nrow(outputs) * 100

test_data <- getData("../test/test_transform5.csv")
subset_index <- sample(1:length(pureClass), 40000)

pureClass <- pureClass[subset_index]
labels <- labels[subset_index]

pick_data <- test_data[pureClass,]
pick_data$Cover_Type <- labels
forest_data <- getData("../train/transform5.csv")
forest_data <- rbind(forest_data, pick_data)

write.csv(forest_data, "../train/enhance2.csv", row.names=F)