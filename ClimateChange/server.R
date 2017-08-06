#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(lubridate)
library(plyr)
library(dplyr)
library(plotly)



# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  
  climate <- read.csv("C:/Users/bamini/Documents/Coursera/Developing_Data_Products/Course_Project/GlobalLandTemperaturesByCountry.csv", 
                      header = TRUE, fileEncoding="UTF-8-BOM", colClasses = c("Date", "numeric", "numeric", "factor", "factor"))
  
  climate$year <- year(climate$dt)
  
  yr_climate <- aggregate(x=climate$AverageTemperature, by=list(climate$year, climate$Country),FUN=mean)
  names(yr_climate) <- c("Year", "Country", "AverageT")
  
     
  output$worldmap <- renderPlotly({

    test <- subset(yr_climate, Year == input$year)
    
    # specify map projection/options
    g <- list(
      showframe = FALSE,
      showcoastlines = FALSE,
      projection = list(type = 'Mercator')
    )
    
    p <- plot_geo(test) %>%
      add_trace(
        z = ~AverageT, color = ~AverageT,
        text = test$Country, locations = test$Country, locationmode = "country names") %>%
      colorbar(title = 'Mean Temp.', limits = c(-20, 35)) %>%
      layout(
        title = 'Global Temperatures',
        geo = g
      )
    
  })
  
})
