
source("common.R")
attach(trainData)
names(trainData)

## Raw Data EDA Plots
plot(jitter(season), jitter(count),col=24- 2 *holiday, main="Season Vs Bike Count", xlab="Season", ylab="Bike Count")
hist(count, col="blue", main="Bike Count Histogram", xlab="Bike Count")

## Plot for Day-time fields

months <- unique(month)
for(i in 1:length(months)){
    sample <- trainData[month==months[i],]
    aggrs <- aggregate(sample$count,list(sample$hour),mean)
    if(i == 1){
        plot(aggrs, type="b", col=i, pch=20, ylim=c(0,600), xlab="Hours of a Day", ylab="Bike Rental Count", main="Bike Rental Pattern Month-Day") 
    }else{
        points(aggrs, type="b", col=i,  pch=20)  
    }
    Sys.sleep(1)
}

xx <- aggregate(count,list(hour),mean)
plot(xx, type="b", col=2, pch=20)


