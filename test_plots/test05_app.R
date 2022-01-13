#load libraries
library(shiny)
library(tidyverse)

iris_choices <- c("Sepal.Length", "Sepal.Width",  "Petal.Length", "Petal.Width")
iris_choices

iris_species <- c("setosa","versicolor","virginica")
iris_species

#1. builds the ui, the web document (like the drop down menus) --------------------
ui <- fluidPage(
  pageWithSidebar(
    headerPanel("f this plot"),
    sidebarPanel(
      selectInput(inputId = "x",
                 label = "Select measurement",
                 choices = iris_choices),
      radioButtons("species", 
                   label= "Select a species",
                   choices = iris_species)),
    mainPanel(plotOutput(outputId = "plot"))
  )
)

#2. functions to make the plot, table ----------------------------------------------------
server <- function(input, output) {
  
  #data wrangling
  data_iris <- reactive({ #makes things happen
    return(iris[iris$Species %in% input$species,]) #filters based on user input from the UI
  })
  
  #plot
  output$plot <- renderPlot({
    data_iris() %>%
      ggplot() +
      aes_string(x = input$x) +
      aes(fill = input$species) +
      geom_density() +
      labs(y = "Density",
           title = "this was annoying") +
      theme_classic() +
      theme(legend.position = "none")

  })
}

#3. knits ui and server together --------------------------------------------------
shinyApp(ui = ui, server = server)

