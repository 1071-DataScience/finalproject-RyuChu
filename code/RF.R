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

}


# 
# KNN
# 
# d <- read.csv("~/資料科學實務/project/finaldata.csv",stringsAsFactors = F) 
# labels <-d[,14]
# standardized.d <- d[,-14]
# library("caret")
# folds<-createFolds(y = d[,14],k= 5)
# trainAcc <- 0
# testAcc <- 0
# validAcc <-0
# for(i in 1:5){
#   test.data <- standardized.d[folds[[i]],]
#   test.labels <- labels[folds[[i]]]
# 
#   if(i==1){
#     validation.data <- standardized.d[folds[[5]],]
#     validation.labels <- labels[folds[[5]]]
#   }
#   else{
#     validation.data <- standardized.d[folds[[(i-1)]],]
#     validation.labels <- labels[folds[[(i-1)]]]
#   }
# 
#   if(i==1){
#     m.data <- standardized.d[-folds[[i]],]
#     train.data <- m.data[-folds[[5]],]
# 
#     m.labels <- labels[-folds[[i]]]
#     train.labels <- m.labels[-folds[[5]]]
#   }
#   else{
#     m.data <- standardized.d[-folds[[i]],]
#     train.data <- m.data[-folds[[i-1]],]
# 
#     m.labels <- labels[-folds[[i]]]
#     train.labels <- m.labels[-folds[[i-1]]]
#   }
#   library(class)
#   set.seed(101)
# 
#   trainlabel <- knn(train.data,train.data,train.labels,k=1)
#   trainAcc <- trainAcc + length(which(trainlabel == train.labels))/nrow(train.data)
# 
#   testlabel <- knn(train.data,test.data,train.labels,k=1)
#   testAcc <- testAcc +  length(which(testlabel == test.labels))/nrow(test.data)
# 
#   validlabel <- knn(train.data,validation.data,train.labels,k=1)
#   validAcc <- validAcc +  length(which(validlabel == validation.labels))/nrow(validation.data)
# }
#
#SVM
#
# require(e1071)
# d <- read.csv("~/資料科學實務/project/finaldata.csv",stringsAsFactors = F)
# d$總額元 <- factor(d$總額元)
# library("caret")
# folds<-createFolds(y = d[,14],k= 5)
# y <- d$總額元
# x <- subset(d, select = -總額元)
# trainAcc <- 0
# testAcc <- 0
# validAcc <-0
# 
# for(i in 1:5){
#   test.data <- x[folds[[i]],]
#   test.labels <- y[folds[[i]]]
#   if(i==1){
#     validation.data <-x[folds[[5]],]
#     validation.labels <- y[folds[[5]]]
#   }else{
#     validation.data <- x[folds[[(i-1)]],]
#     validation.labels <- y[folds[[(i-1)]]]
#   }
#   if(i==1){
#     m.data <- x[-folds[[i]],]
#     train.data <- m.data[-folds[[5]],]
# 
#     m.labels <- y[-folds[[i]]]
#     train.labels <- m.labels[-folds[[5]]]
#   }else{
#     m.data <- x[-folds[[i]],]
#     train.data <- m.data[-folds[[i-1]],]
# 
#     m.labels <- y[-folds[[i]]]
#     train.labels <- m.labels[-folds[[i-1]]]
#   }
#   library(class)
#   set.seed(101)
# 
#   model <- svm(train.data,train.labels)
#   result <- predict(model,train.data)
#   trainAcc <- trainAcc + length(which(result== train.labels))/nrow(train.data)
#   
#   result <- predict(model,test.data)
#   testAcc <- testAcc +  length(which(result== test.labels))/nrow(test.data)
# 
#   result <- predict(model,validation.data)
#   validAcc <- validAcc +  length(which(result == validation.labels))/nrow(validation.data)
# }


