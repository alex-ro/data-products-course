setwd('~/workspace/data-science-specialization/data-products-course/shiny-app')
library(shiny)
library(rpart)
library(randomForest)

train <- read.csv('./titanic-train.csv')

train$Pclass <- as.factor(train$Pclass)
#fill the missing age rows with an aproximation
Agefit <- rpart(Age ~ Pclass + Sex + SibSp + Parch + Fare + Embarked,
                data=train[!is.na(train$Age),], method="anova")
train$Age[is.na(train$Age)] <- predict(Agefit, train[is.na(train$Age),])

#fill other missing values
train$Embarked[c(62,830)] = "S"
train$Embarked <- factor(train$Embarked)

#the prediction with random forest
set.seed(415)
fit <- randomForest(as.factor(Survived) ~ Pclass + Sex + Age + Fare + Embarked,
                    data=train, importance=TRUE, ntree=1000)

#used to make the test data frame. with out this the random forest doesn't work
fakeDf <- data.frame(
    Sex = c("male", "female", "female"),
    Age = c(1, 3, 11),
    Pclass = as.factor(c(1, 2, 3)),
    Fare = c(10, 100, 400),
    Embarked = c("C", "S", "Q")
)

shinyServer(function(input, output) {
    # name, sex, age, class, fare, embarked /// 78% accuracy
    output$result <- renderText({ 
        
        #the 4th row is the input from the user
        test <- rbind(fakeDf, c(
            input$Sex, input$Age, input$Pclass, input$Fare, input$Embarked
        ))
        
        prediction <- predict(fit, test, OOB=TRUE, type = "response")
        
        if (prediction[4] == 1) {
            paste(input$Name, ", you are lucky, you would have a pretty 
                  good chance to survive the Titanic trip!", sep = "")
        } else {
            paste(input$Name, ", sorry, there is a pretty good chance that you 
                  would have died if you were on Titanic!", sep = "")
        }
    })
    output$accuracy <- renderText({
        "The model has an accuracy of 78%."
    })
})