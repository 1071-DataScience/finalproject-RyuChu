#
# randomforest
#
d <- read.csv("finaldata.csv",stringsAsFactors = F)
library("caret")
library(randomForest)
folds<-createFolds(y = d[,14],k= 5)

trainAcc <- 0
testAcc <- 0
validAcc <-0
for(i in 1:5){
  test.data <- d[folds[[i]],]
  if(i==1){
    validation.data <- d[folds[[5]],]
  }
  else{
    validation.data <- d[folds[[(i-1)]],]
  }
  if(i==1){
    m.data <- d[-folds[[i]],]
    train.data <- m.data[-folds[[5]],]
  }
  else{
    m.data <- d[-folds[[i]],]
    train.data <- m.data[-folds[[i-1]],]
  }
  library(class)
  set.seed(101)

  test_model <- randomForest(factor(總額元)~.,data = train.data,ntree=200,mtry=7)
  prediction <- predict(test_model,train.data)
  trainAcc <- trainAcc + length(which(prediction == train.data$總額元))/nrow(train.data)

  prediction <- predict(test_model,test.data)
  testAcc <- testAcc +  length(which(prediction == test.data$總額元))/nrow(test.data)

  prediction <- predict(test_model,validation.data)
  validAcc <- validAcc +  length(which(prediction == validation.data$總額元))/nrow(validation.data)
  
  saveRDS(test_model, "test_model.rds")
}
