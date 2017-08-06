#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Exploring global temperatures"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      h2("Select the Year or Play!"),
      sliderInput("year", "Year",
                  min = 1900, max = 2000,
                  value = 1900, animate = TRUE)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h2("Global Average Land Temperature by Country"),
      plotlyOutput("worldmap")
    )
  )
))
