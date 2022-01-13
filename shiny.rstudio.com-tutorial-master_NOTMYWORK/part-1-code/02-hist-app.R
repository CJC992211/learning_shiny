library(shiny)

ui <- fluidPage(
  #input syntax: inputId = argument
  sliderInput(inputId = "num", #adds a slider
    label = "Choose a number", 
    #extra arguments for the input to do its job
    #3. use input values with input$
    value = 25, min = 1, max = 100), #value is where the slider starts, also setting a range
  #output syntax: type of output you want(outputId = argument)
  plotOutput("hist"))
#should give unique names for in/outputId to avoid problems


server <- function(input, output) 
  #1. save objects to display to output$
  #both need to be the same (hist): plotOutput("hist") output$hist
  {output$hist <- renderPlot({ #2. build objects to display with render____(), creates the output you want
    hist(rnorm(input$num))})} #rnorm = random number of values, rnorm(100), 100 random values 

shinyApp(ui = ui, server = server)
