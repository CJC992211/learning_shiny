#Shiny basic template ----------------------------------------------------------
library(shiny) #load shiny library
ui <- fluidPage() #builds the ui, the web document (like the drop down menus)

server <- function(input, output) {} #functions to make the plot

shinyApp(ui = ui, server = server) #knits ui and server together

#Run App is like knit in R Markdown
#creates a blank app because we haven't added anything

#can add text
ui <- fluidPage("Hello World") 

server <- function(input, output) {} 

shinyApp(ui = ui, server = server) 


#inputs and outputs ------------------------------------------------------------

#inputs = things you can toggle, adds values to the app (drop down)
#ex. selecting which variable to display on the plot

#outputs = what you see/what responds to input changes, the plot, table, text, etc.

#how to add inputs and outputs
ui <- fluidPage(
  #____Input() functions, 
  #____Output() functions 
  )
  
 
