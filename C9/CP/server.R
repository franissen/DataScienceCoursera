library(shiny)
library(ggplot2)

f_calculate_bmi <- function(weight, height, measure_type) {
  
   bmi.value <- 0
   bmi.description <- "Not calculated"
  
   # In function of the type of the measure (standard or metric) the BMI is calculated in a different way.  
   if (measure_type == 0) {
      bmi.value <- round(((weight/(height^2))*703), digits = 1)
   } 
   else if (measure_type == 1) {      
	  bmi.value <- round((weight/(height^2)), digits = 1)
   }
  
   if (bmi.value < 18.5) {
      bmi.description <- "Underweight (< 18.5)"
   }
   else if (bmi.value >= 18.5 & bmi.value < 25) {
      bmi.description <- "Normal weight (18.5 ~ 24.9)"
   }
   else if (bmi.value > 25 & bmi.value < 30) {
      bmi.description <- "Overweight (25 ~ 29.9)"
   } else if (bmi.value >= 30) {
      bmi.description <- "Obesity (>=30)"
   }
  
   return(c(bmi.value, bmi.description))
   
}

shinyServer(
  function(input, output) {
    output$weight <- renderPrint({input$weight})
    output$height <- renderPrint({input$height})
    output$bmi.value <- renderPrint({f_calculate_bmi(input$weight, input$height, input$measure_type)[1]})
    output$bmi.description <- renderPrint({f_calculate_bmi(input$weight, input$height, input$measure_type)[2]})
  }
)