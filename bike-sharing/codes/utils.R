getData <- function(filename){
    data <- read.csv(filename, header = T)
    data
}

writeData <- function(data, filename){
    write.csv(data, filename, row.names=F)
}

getProp <- function(property){
    myProp <- read.table( "bike-prop.R", header=FALSE, sep="=", row.names=1, strip.white=TRUE, na.strings="NA", stringsAsFactors=FALSE)
    myProp[property,1]
}

genPlotFileName <- function(classifier, content){
    plotFile <- paste(paste(classifier, content, sep="_"), "png", sep=".")
    plotFile <- paste(paste("../results",tolower(classifier), sep="/"), plotFile, sep="/")
    plotFile
}
