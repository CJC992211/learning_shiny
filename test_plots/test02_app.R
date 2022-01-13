#load libraries
library(shiny)
library(tidyverse)

iris_choices <- c("Sepal.Length", "Sepal.Width",  "Petal.Length", "Petal.Width")
iris_choices

#1. builds the ui, the web document (like the drop down menus) --------------------
ui <- fluidPage(
  #adds a title to the page
  titlePanel("My second shiny???"),
  pageWithSidebar(
    #header
    headerPanel("iris dataset"),
    #panel for the selections
    sidebarPanel(
      selectInput(inputId = "meas", #set a name for the inputs, used later when messing with output
                  label = "Select measurement", #give a name for the drop down
                  choices = iris_choices, #what to pick from
                  selected = "Petal.Length"), #makes it so that this variable is preselected
      selectInput(inputId = "color",
                  label = "Select color",
                  choices = c("red", "yellow", "blue")), #colors
      sliderInput(inputId = "slider", #slider menu
                  label = "Select bins", #need a label for everything
                  min = 1, #minimum value it can be at (we don't 0 bc that means no bins)
                  max = 20, #maximum amount of bins
                  value = 8)), #what the slider starts at
    #panel for what you want to show (the plot)
    mainPanel = (plotOutput(outputId = "histogram"))
  ))

#inputs = things you can toggle, adds values to the app
#outputs = what you see/what responds to input changes, the plot, table, text, etc.

#2. functions to make the plot, table ----------------------------------------------------
server <- function(input, output) {
  #the output for the plot panel
  output$histogram <- renderPlot( #render____ defines what type of output it should be
    iris %>%
      ggplot() +
      #input$name, was defined earlier (the inputId)
      aes_string(x = input$meas) + #aes() did not work because x is considered a string
    geom_histogram(bins = input$slider,
                   fill = input$color,
                   color = "black") +
      theme_classic()
  )
}

#3. knits ui and server together --------------------------------------------------
shinyApp(ui = ui, server = server)
