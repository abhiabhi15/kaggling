
# Kmeans

kc <- kmeans(trainData[,-ncol(trainData)], iter.max=10, centers=5)
head(trainData[,-ncol(trainData)])
