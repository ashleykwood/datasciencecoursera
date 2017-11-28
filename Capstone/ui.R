library(shiny)


# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel(
    h1("Predictive Text Model",
             style = "font-family: 'Arial Rounded MT Bold'; color: #5CA5C1")),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    
    sidebarPanel(
      p("This app will accept a string of words and use natural language 
        processing to predict the user's next word. The model offers the top 
        predicted word, as well as up to three other possible choices."),
      br(),
      br(),
      br(),
      h3("text input"),
      p("Enter a word or string of words below and press", em('Enter'), 
        "to predict. Please allow a moment to produce a prediction."),
      br(),
       textInput("text",
                 label = NA,
                 value = "enter text here..."),
       actionButton(inputId = "button", 
                    label = strong("Enter"),
                    style = "color: #167C60")
    ),
    
    mainPanel(
      
      conditionalPanel(
        condition = "output.noprediction != 'good'",
        h2(textOutput("noprediction"))),
      
      conditionalPanel(
      condition = "output.noprediction == 'good'",
      h3(textOutput("intro")),
      h2(textOutput("word1"),
         style = "font-family: 'Arial Rounded MT Bold'; color: #167C60"),
      br(),
      br(),
      em(textOutput("intro2")),
      br(),
      tableOutput("restwords")
    )
      
    
  )
  )
))
