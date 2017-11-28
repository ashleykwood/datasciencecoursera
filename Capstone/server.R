library(shiny)
library(dplyr)

source("predictionmodel.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  observeEvent(
   eventExpr = input$button,
   handlerExpr = {
     
     output$noprediction <- renderText("I'm sorry, I don't have a prediction for you.")
     
     allwords <- predict.next.word(input$text)
     if (length(allwords[[1]]) > 0){
       output$noprediction <- renderText("good")
     output$intro <- renderText(paste("Top prediction: ", input$text, "..."))
     output$intro2 <- renderText("other choices")
     output$word1 <- renderText(allwords[1])
     
     output$restwords <- renderTable(allwords[2:length(allwords)],
       colnames = FALSE,
       spacing = "l")
     }
   }
  ) 
})
