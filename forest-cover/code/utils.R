getData <- function(filename){
    data <- read.csv(filename, header = T)
    data
}

crossProduct <- function(data1, data2){
    data1 <- as.matrix(data1)
    len   <- length(data2)
    data2 <- matrix(data=data2, nrow=len, ncol=1)
    data1 %*% data2
}

getNormalize <- function(x, mu, sigma){
    round((x-mu)/sigma,3)
}

getMinMax <- function(x, max, min){
    round((x-min)/(max - min), 3)
}

genPlotFileName <- function(classifier, content){
    plotFile <- paste(paste(classifier, content, sep="_"), "png", sep=".")
    plotFile <- paste(paste("../results",tolower(classifier), sep="/"), plotFile, sep="/")
    plotFile
}
