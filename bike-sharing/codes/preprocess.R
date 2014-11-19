
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
train_data$hour <- as.numeric(substring(train_data$time, 1, 2))
test_data$hour <- as.numeric(substring(test_data$time, 1, 2))

## Adding Day Part
train_data$daypart <- "1"
test_data$daypart <- "1"

# 7 to 10 AM
train_data$daypart[(train_data$hour >= 7) & (train_data$hour <= 10)] <- 2
test_data$daypart[(test_data$hour >=7) & (test_data$hour <= 10)] <- 2

# 11 AM to 15 PM
train_data$daypart[(train_data$hour >= 11) & (train_data$hour <= 15)] <- 3
test_data$daypart[(test_data$hour >= 11) & (test_data$hour <= 15)] <- 3

# 16 PM to 20PM
train_data$daypart[(train_data$hour >= 16) & (train_data$hour <= 20)] <- 4
test_data$daypart[(test_data$hour >= 16) & (test_data$hour <= 20)] <- 4

# 21 PM to 24PM
train_data$daypart[(train_data$hour >= 21) & (train_data$hour <= 24)] <- 5
test_data$daypart[(test_data$hour >= 21) & (test_data$hour <= 24)] <- 5

## Setting hour as factor
train_data$hour <- as.numeric(substring(train_data$time, 1, 2))
test_data$hour <- as.numeric(substring(test_data$time, 1, 2))

## Adding season1 as a feature
train_data$season1 <- "0"
train_data$season1[train_data$season == "1"] <- "1"

test_data$season1 <- "0"
test_data$season1[test_data$season == "1"] <- "1"

## Adding weather as a bad/good feature
train_data$good_weather <- "0"
train_data$good_weather[train_data$weather == "1" | train_data$weather == "2"] <- "1"

test_data$good_weather <- "0"
test_data$good_weather[test_data$weather == "1" | test_data$weather == "2"] <- "1"


## Getting Important Features

train_data <- train_data[c("month", "day", "hour", "daypart", "season1", "good_weather", "season","holiday", "workingday","weather", "temp","atemp", "humidity","windspeed","count")]
test_data <- test_data[c("month", "day", "hour", "daypart", "season1", "good_weather","season","holiday", "workingday","weather", "temp","atemp", "humidity","windspeed")]
writeData(data=train_data, filename="../train/transform2.csv")
writeData(data=test_data, filename="../test/test_transform2.csv")

## Storing just the testdata datetime as id
test_id <- testData$datetime
test_id <- as.data.frame(test_id)
colnames(test_id) <- c("datetime")
writeData(data=test_id, filename="../test/test_id.csv")




str(train_data)
head(train_data, 20)




