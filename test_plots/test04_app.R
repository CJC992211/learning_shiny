#load libraries
library(shiny)
library(tidyverse)
library(dplyr)

#this didn't work
#iris_choices <- iris %>% select(-Species)
iris_choices <- c("Sepal.Length", "Sepal.Width",  "Petal.Length", "Petal.Width")
iris_choices

#1. builds the ui, the web document (like the drop down menus) --------------------
ui <- fluidPage(
  pageWithSidebar(
    #adds a title
    headerPanel("Scatterplot"),
    #panel for the selections
    sidebarPanel(
      selectInput(inputId = "x", #set a name for the inputs, used later when messing with output
                  label = "Select x-axis", #give a name for the drop down
                  choices = iris_choices, #what to pick from
                  selected = "Sepal.Length"), #makes it so that this variable is preselected
      selectInput(inputId = "y",
                  label = "Select y-axis",
                  choices = iris_choices,
                  selected = "Sepal.Width"),
      textInput(inputId = "title",
                label = "Type plot name"),
      radioButtons(inputId = "color", #adds buttons to pick from instead of drop down menu
                   label = "Select point color",
                   choices = c("red", "yellow", "blue"))
    ),
    #panel for what i want to show (the plot and table)
    mainPanel(plotOutput(outputId = "plot"),
              tableOutput(outputId = "table")
)))

#inputs = things you can toggle, adds values to the app
#outputs = what you see/what responds to input changes, the plot, table, text, etc.

#2. functions to make the plot, table ----------------------------------------------------
server <- function(input, output) {
  #the output for the plot panel
  output$plot <- renderPlot( #render____ defines what type of output it should be
    iris %>%
      ggplot() +
      #input$name, was defined earlier (the inputId) 
        aes_string(x = input$x,#aes() did not work because the x and y are considered strings
                   y = input$y) +
        geom_point(color = input$color,
                   size = 3) +
      geom_smooth(method = "lm",
                  color = "black") +
      labs(title = input$title) +
      theme_classic()
  )
  #the different outputs are not separated by commas
  
  #table output
  output$table <- renderTable(
    iris %>%
    summarize("Mean" = mean(Petal.Length), 
              "Median" = median(Petal.Length),
              "StDev" = sd(Petal.Length), 
              "Min" = min(Petal.Length),
              "Max" = max(Petal.Length)),
    #adds a title to the table
    caption = "Petal.Length summary statistics",
    caption.placement = getOption("xtable.caption.placement", "top") #makes it so caption/title is above
  )
}

#3. knits ui and server together --------------------------------------------------
shinyApp(ui = ui, server = server)