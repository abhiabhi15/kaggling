
source("common.R")
attach(trainData)
names(trainData)

## Raw Data EDA Plots
plot(jitter(season), jitter(count),col=24- 2 *holiday, main="Season Vs Bike Count", xlab="Season", ylab="Bike Count")
hist(count, col="blue", main="Bike Count Histogram", xlab="Bike Count")

## Plot for Day-time fields

mnths <- unique((trainData$month))
for(i in 1:length(mnths)){
    sample <- trainData[month==mnths[i],]
    cat("Month is ", as.character(mnths[i]), "\n")  
    aggrs <- aggregate(sample$count,list(sample$hour),mean)
    if(i == 1){
        plot(aggrs, type="b", col=i, pch=20, ylim=c(0,600), xlab="Hours of a Day", ylab="Bike Rental Count", main="Bike Rental Pattern Month-Day") 
    }else{
        points(aggrs, type="b", col=i,  pch=20)  
    }
    Sys.sleep(1)
}

## Plots for Day-Hour Wise Plot for 
days <- unique(trainData$day)))
for(i in 1:length(days)){
    cat("Day is ", as.character(days[i]) ,"\n")
    sample <- trainData[day==days[i],]
    aggrs <- aggregate(sample$count,list(sample$hour),mean)
    if(i == 1){
        plot(aggrs, type="b", col=i, pch=20, ylim=c(0,600), xlab="Hours of a Day", ylab="Bike Rental Count", main="Bike Rental Pattern Day-Hour") 
    }else{
        points(aggrs, type="b", col=i,  pch=20)  
    }
    Sys.sleep(2)
}

## Plots for Season-Hour Wise Plot for 
seasons <- unique(trainData$season)
for(i in 1:length(seasons)){
    cat("Season is ", seasons[i] ,"\n")
    sample <- trainData[season==seasons[i],]
    aggrs <- aggregate(sample$count,list(sample$hour),mean)
    if(i == 1){
       plot(aggrs, type="b", col=i, pch=20, ylim=c(0,600), xlab="Hours of a Day", ylab="Bike Rental Count", main="Bike Rental Pattern Hour-Season") 
    }else{
       points(aggrs, type="b", col=i,  pch=20)  
  }
  Sys.sleep(2)
}

## Plots for Weather-Hour Wise Plot for 
weathers <- unique(trainData$weather)
for(i in 1:length(weathers)){
    cat("Weather is ", weathers[i] ,"\n")
    sample <- trainData[weather==weathers[i],]
    aggrs <- aggregate(sample$count,list(sample$hour),mean)
    if(i == 1){
        plot(aggrs, type="b", col=i, pch=20, ylim=c(0,600), xlab="Hours of a Day", ylab="Bike Rental Count", main="Bike Rental Pattern Hour-Weather") 
    }else{
        points(aggrs, type="b", col=i,  pch=20)  
    }
    Sys.sleep(2)
}


qplot(x = trainData$weather, y = trainData$count,geom = "auto",margins = T, xlab = "Weather", ylab = "Count")


