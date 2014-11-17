
source("common.R")
# Train Data Factorizartion and feature Creation

train_data <- trainData
train_data$weather <- factor(train_data$weather)
train_data$season <- factor(train_data$season)
train_data$holiday <- factor(train_data$holiday)
train_data$workingday <- factor(train_data$workingday)

test_data <- testData
test_data$weather <- factor(test_data$weather)
test_data$season <- factor(test_data$season)
test_data$holiday <- factor(test_data$holiday)
test_data$workingday <- factor(test_data$workingday)

## Handling Date and Time
train_data$time <- substring(train_data$datetime, 12, 20)
test_data$time <- substring(test_data$datetime, 12, 20)

## Create Day from datetime field
train_data$day <- weekdays(as.Date(train_data$datetime))
train_data$day <- as.factor(train_data$day)

test_data$day <- weekdays(as.Date(test_data$datetime))
test_data$day <- as.factor(test_data$day)

#aggregate(train_data$count,list(train_data$day),mean)

## Create Month from datetime field
train_data$month <- months(as.Date(train_data$datetime))
train_data$month <- as.factor(train_data$month)

test_data$month <- months(as.Date(test_data$datetime))
test_data$month <- as.factor(test_data$month)

#aggregate(train_data$count,list(train_data$month),mean)


## Extracting hour from dataset
train_data$hour <- as.factor(substring(train_data$time, 1, 2))
test_data$hour <- as.factor(substring(test_data$time, 1, 2))

## Getting Important Features
train_data <- train_data[c("month", "day", "hour", "season","holiday", "workingday","weather", "temp","atemp", "humidity","windspeed","count")]
test_data <- test_data[c("month", "day", "hour", "season","holiday", "workingday","weather", "temp","atemp", "humidity","windspeed")]
test_id <- testData$datetime
test_id <- as.data.frame(test_id)
colnames(test_id) <- c("datetime")
writeData(data=train_data, filename="../train/transform1.csv")
writeData(data=test_data, filename="../test/test_transform1.csv")
writeData(data=test_id, filename="../test/test_id.csv")

str(train_data)
head(train_data, 20)

