library(shiny)

shinyUI(
    fluidPage(
        titlePanel("Titanic trip ... of death"),
        sidebarLayout(
            sidebarPanel(
                h3("Let's book you a trip on Titanic"),
                textInput("Name", label = strong("Your name")),
                selectInput("Sex", label = strong("Sex"),
                            choices = list("Male" = "male", 
                                           "Female" = "female")),
                sliderInput("Age", label = strong("Age"),
                            min = 1, max = 80, value = 1),
                selectInput("Pclass", label = strong("Passenger class"),
                            choices = list("1st" = 1,
                                           "2nd" = 2,
                                           "3rd" = 3)),
                selectInput("Embarked", label = strong("Embarked from"),
                            choices = list("Cherbourg" = "C",
                                           "Queenstown" = "Q",
                                           "Southampton" = "S")),
                sliderInput("Fare", label = strong("Fare you want to pay ($)"),
                            min = 1, max = 500, value = 1),
                submitButton("Submit")
            ),
            mainPanel(
                h2("After you book the trip, you will find out if you would 
                   have survived the Titanic sinking."),
                p("The sinking of the Titanic is one of the most infamous 
                  shipwrecks in history.  On April 15, 1912, during her maiden 
                  voyage, the Titanic sank after colliding with an iceberg, 
                  killing 1502 out of 2224 passengers and crew (67.5% death rate). 
                  This sensational tragedy shocked the international community
                  and led to better safety regulations for ships."),
                br(),
                h4(textOutput("result")),
                br(),
                textOutput("accuracy")
            )
        )
    )
)