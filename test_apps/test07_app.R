#load libraries
library(shiny)
library(tidyverse)
library(shinydashboard)
library(shinyWidgets)

iris_choices <- names(iris)[names(iris) != "Species"]
iris_choices

lib <- c("shiny", "tidyverse", "shinydashboard", "shinyWidgets")
lib

#1. builds the ui, the web document (like the drop down menus) --------------------
#dashboardPage instead of fluidPage
#from shinydashboard
ui <- dashboardPage(
  dashboardHeader(title = "hello"),
  #sets up the sidebar
  dashboardSidebar(
    #this function is for each thing that will be in the sidebar
    menuItem("Main", #name in the sidebar
             tabName = "main", #this needs to be the same as tabName further down
             icon = icon("dashboard")), #what the picture will be
    menuItem("Libraries", 
             tabName = "libraries", 
             icon = icon("th"))),
  #where the plots, tables, etc will go
  dashboardBody(
    #designates what should go in what tab
    tabItems(
      tabItem(tabName = "main",
              h2("Main tab content"), #adds a title in the body
    #Boxes need to be put in a row (or column)
    fluidRow(
      #add boxes for each thing
      box(
        plotOutput("plot", 
                   #how long the plot is?
                     height = 300)),
      box(
        title = "Select x-axis",
        #from shinyWidgets, replaces radioButtons
        awesomeRadio(inputId = "x",
                     label = "iris dataset",
                     choices = iris_choices,
                     inline = TRUE)) #makes the buttons inline
      ))),
    tabItem(tabName = "libraries",
            h2("Libraries tab content"),
      fluidRow(
        box(title = "Libraries",
          tableOutput("table")))
  )
  ))

#2. functions to make the plot, table ----------------------------------------------------
server <- function(input, output) {
  output$plot <- renderPlot(
    iris %>%
      ggplot() +
      aes_string(x = input$x) +
      geom_density(fill = "turquoise"))
  
  output$table <-renderTable(
    lib
  )
}

#3. knits ui and server together --------------------------------------------------
shinyApp(ui = ui, server = server)