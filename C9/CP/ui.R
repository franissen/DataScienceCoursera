library(shiny)
library(ggplot2)

shinyUI(pageWithSidebar(
  headerPanel("BMI Calculator"),  
  sidebarPanel(
    h3("Description"),
    p("Body mass index (BMI) is a measure of body fat based on height and weight that applies to adult men and women."),
    p("You'll have to enter your weight and height using standard (pounds & inches) or metric (kilograms & meters) measures and press the button submit to see the results."),
    h4("Introduce the following data:"),
	selectInput("measure_type", "Standard or metric notation?",
				c("Standard" = 0, "Metric" = 1)),
    numericInput("weight", "Your weight:", 135, min = 0, max = 300, step = 1),
    numericInput("height", "Your height", 70, min = 0, max = 100, step = 0.01),
    submitButton("Submit")
  ),
  
  mainPanel(
    h3("Results:"),
    h4('Your weight:'),
    verbatimTextOutput("weight"),
    h4('Your height'),
    verbatimTextOutput("height"),
    h4('Your BMI calculated:'),
    verbatimTextOutput("bmi.value"),
    h4('What your BMI says:'),
    verbatimTextOutput("bmi.description")
  )
))