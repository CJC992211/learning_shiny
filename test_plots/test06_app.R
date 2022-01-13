#load libraries
library(shiny)
library(tidyverse)

#make something with a checkbox
#make the graph update with button

iris_choices <- c("Sepal.Length", "Sepal.Width",  "Petal.Length", "Petal.Width")
iris_choices

#1. builds the ui, the web document (like the drop down menus) --------------------
ui <- fluidPage(
  titlePanel("hi"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "x",
        label = "Select x-axis",
        choices = iris_choices),
      actionButton(inputId = "button",
                    label = "update graph")),
    mainPanel(plotOutput(outputId = "plot"))
))

#2. functions to make the plot, table ----------------------------------------------------
server <- function(input, output) {
 
  
   output$plot <- renderPlot(
   iris %>%
     ggplot() +
      aes_string(x = input$x) +
      geom_density(fill = "red")
  )
}

#3. knits ui and server together --------------------------------------------------
shinyApp(ui = ui, server = server)