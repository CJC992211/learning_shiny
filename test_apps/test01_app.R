#load libraries
library(shiny)
library(tidyverse)
library(dplyr)

iris_choices <- c("Sepal.Length", "Sepal.Width",  "Petal.Length", "Petal.Width")
iris_choices

#1. builds the ui, the web document (like the drop down menus) --------------------
ui <- fluidPage(
  #adds a title to the page
  titlePanel("My first Shiny"), #functions separated by commas
  #creates main and side panel
  sidebarLayout(
    #panel for the selections
   sidebarPanel( 
      selectInput(inputId = "x", #set a name for the inputs, used later when messing with output
                label = "Select x-axis", #give a name for the drop down
                choices = iris_choices), #what to pick from
      selectInput(inputId = "y",
                label = "Select y-axis",
                choices = iris_choices,
                selected = "Sepal.Width")), #makes it so that this variable is preselected
    #panel for what i want to show (the plot and table)
   mainPanel(plotOutput(outputId = "plot"),
                tableOutput(outputId = "table"))
   )
)

#inputs = things you can toggle, adds values to the app
#outputs = what you see/what responds to input changes, the plot, table, text, etc.

#2. functions to make the plot, table ----------------------------------------------------
server <- function(input, output) {
  #the output for the plot panel 
  output$plot <- renderPlot( #render____ defines what type of output it should be
    iris %>%
      ggplot() +
      #input$name, was defined earlier (the inputId) 
      aes_string(x = input$x, #aes() did not work because the x and y are considered strings
                 y = input$y) + 
      geom_point())
  
#the different outputs are not separated by commas
  
  #table of iris species
  output$table <- renderTable(
    iris %>%
      select(Species) %>% #dlpyr works in shiny too
      distinct()
  )
}

#3. knits ui and server together --------------------------------------------------
shinyApp(ui = ui, server = server)
