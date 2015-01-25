---
title       : Titanc trip
subtitle    : Find out if you would have survived the Titanic sinking
author      : Alexandru Vasile
job         : student
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Introduction

The sinking of the Titanic is one of the most infamous shipwrecks in history.  On April 15, 1912, during her maiden voyage, the Titanic sank after colliding with an iceberg, killing 1502 out of 2224 passengers and crew (67.5% death rate). 
This sensational tragedy shocked the international community and led to better safety regulations for ships.

This small app tells you if you would have survived the Titanic sinking.
It is doing this by stimulating your trip on the ship: you insert your information and ticket preferentials and based on a random forest model it makes a prediction of your survival chance.

The app cand be found at: https://alex-ro.shinyapps.io/shiny-app/

---

## The data

The training data is obtained from the Titanic Kaggle competition (http://www.kaggle.com/c/titanic-gettingStarted). It contains the following information about every passenger of the boat:

```r
train <- read.csv('../shiny-app/titanic-train.csv')
colnames(train)
```

```
##  [1] "PassengerId" "Survived"    "Pclass"      "Name"        "Sex"        
##  [6] "Age"         "SibSp"       "Parch"       "Ticket"      "Fare"       
## [11] "Cabin"       "Embarked"
```
and we have informations about 

```
## [1] 891
```
passengers.

---
## The model

To make the prediction for new data point I trained a model with random forest algorithm, but using only 5 variables: Sex, Age, Passenger Class, Fare and Embarked city.

```
fit <- randomForest(as.factor(Survived) ~ Pclass + Sex + Age + Fare + Embarked, 
data=train, importance=TRUE, ntree=1000)
```

This model has a prediction accuracy of 78%.

---
## Final thoughts

This model is really basic and can be easily improved by adding more variables and also with feature engineering.


#### Have fun with the app!


### Thank you!
