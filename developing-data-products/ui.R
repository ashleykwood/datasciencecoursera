library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel(h1("Annual National Park Visits", 
                style = "font-family:franklin gothic heavy")),
  
  sidebarLayout(
    sidebarPanel(p("This Shiny app allows the user to select from a list of 20 US 
                   national parks, and will plot the annual attendance at the 
                   selected parks over any span of years between 2007 and 
                   2016."),
      
      # checkbox group for user-selected parks
       checkboxGroupInput("parks",
                   label = h4(em("choose parks")),
                   choices = list("Badlands NP" = 1, "Big Bend NP" = 2, 
                                  "Carlsbad Caverns NP" = 3, 
                                  "Death Valley NP" = 4, "Everglades NP" = 5,
                                  "Glacier NP" = 6, "Grand Canyon NP" = 7,
                                  "Great Sand Dunes NP & Preserve" = 8, 
                                  "Great Smoky Mountains NP" = 9, 
                                  "Guadalupe Mountains NP" = 10, 
                                  "Hot Springs NP" = 11, "Joshua Tree NP" = 12, 
                                  "Olympic NP" = 13, "Pinnacles NP" = 14, 
                                  "Rocky Mountain NP" = 15, "Saguaro NP" = 16, 
                                  "Sequoia & Kings Canyon NP" = 17,
                                  "Yellowstone NP" = 18, "Yosemite NP" = 19, 
                                  "Zion NP" = 20), 
                   selected = 1:20),
       
       #slider for user-selected years
       sliderInput("years", label = h4(em("year range")), min = 2007, max = 2016, 
                   value = c(2007, 2016), sep = "")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotlyOutput("NPplot", height = "650px")
       
    )
  )
))
