
library(shiny)
library(dplyr)
library(tidyr)
library(plotly)
library(ggplot2)
library(viridis)

# load data and clean it up
NP <- read.csv("Annual Visitation By Park.csv", skip = 8, 
               stringsAsFactors = FALSE)
NP <- select(NP, -X, -X.1, -X.2, -Average)
NP <- NP[-377, ]
#data from 20 national parks
# BADL, BIBE, CAVE, DEVA, EVER, GLAC, GRCA, GRSA, GRSM, GUMO, 
# HOSP, JOTR, OLYM, PINN, ROMO, SAGU, SEKI, YELL, YOSE, ZION
prefixes <- c("Badl", "Big Bend", "Carlsbad", "Death", "Ever", "Glacier NP", 
              "Grand Can", "Great Sand", "Great Smoky", "Guadalupe", 
              "Hot Springs", "Joshua", "Olympic", "Pinn", "Rocky Mount", "Sagu",
              "Sequoia", "Yellow", "Yose", "Zion")

inds <- numeric(20)
for(i in 1:20){
  inds[i] <- NP$Park.Name %>%
    startsWith(prefixes[i]) %>%
    which()
}

#tidy NP dataframe
NP <- NP[inds, ]
NP <- NP %>%
  gather(year, visits, X2007:X2016)

#remove X from year and change class to numeric
NP$year <- NP$year %>%
  substring(2) %>%
  as.numeric()

NP <- arrange(NP, Park.Name)

#add id for simplified plotting
NP$park.id <- rep(1:20, each = 10)

#remove commas from visits and change class to numeric
NP$visits <- NP$visits %>%
  gsub(",", "", .) %>%
  as.numeric()


#choose which ones to plot ... use plotly to show points
#choose years to plot over

shinyServer(function(input, output) {
   
    # generate plot with selected parks
     NPdata <- reactive({
       yr <- input$years[1]:input$years[2]
       NP[(NP$park.id %in% input$parks) & NP$year %in% yr, ]
     })
    
    output$NPplot <- renderPlotly({
      p <- ggplot(NPdata(), aes(year, visits)) + geom_path(aes(col = Park.Name)) +
        theme_minimal() + scale_color_manual(values = inferno(length(input$parks)), name = "Park")
    p
      ggplotly(p)
      
    })
      
})
