#load libraries
library(shiny)

#1. builds the ui, the web document (like the drop down menus) --------------------
ui <- fluidPage(
  pageWithSidebar(
    headerPanel("Shiny fun"),
    sidebarPanel(
      actionButton(
        inputId = "button",
        label = "Click")
      ),
    #panel for what you want to show
    mainPanel(textOutput(outputId = "text"))
  ))
 
#inputs = things you can toggle, adds values to the app
#outputs = what you see/what responds to input changes, the plot, table, text, etc.

#2. functions to make the plot, table ----------------------------------------------------
server <- function(input, output) {
  output$text <- renderText( #render____ defines what type of output it should be
    print(input$button)
  ) 
}

#3. knits ui and server together --------------------------------------------------
shinyApp(ui = ui, server = server)
