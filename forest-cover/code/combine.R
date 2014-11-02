
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

outputs <- read.csv("~/aldaProject/main/data/combine_results.csv")
head(outputs)

ss <- outputs[which(outputs[,1] == outputs[,2] &
                    outputs[,1] == outputs[,3] &
                    outputs[,1] == outputs[,4] &
                    outputs[,1] == outputs[,5] &
                    outputs[,1] == outputs[,6] 
                    #outputs[,1] == outputs[,7] &  
                    #outputs[,1] == outputs[,8]
                    ),]
nrow(ss)
nrow(ss)/nrow(outputs) * 100
