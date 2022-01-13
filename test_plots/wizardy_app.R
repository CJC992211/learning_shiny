library(shiny)
library(ggplot2)

#from here:
#https://stackoverflow.com/questions/37343387/r-shiny-ggplot2-checkboxgroup-to-plot-specific-data

ui=shinyUI(fluidPage(checkboxGroupInput("region_choose", label = "Choose a region",
                                        choices = c("setosa","versicolor","virginica")
),

plotOutput("housePlot")
))

server=function(input,output){
  #data manipulation
  data_1=reactive({
    return(iris[iris$Species%in%input$region_choose,])
  })
  #plot
  output$housePlot <- renderPlot({
    ggplot(data=data_1(), aes(x=Sepal.Length, y=Petal.Width, group=Species, colour=Species)) +
      geom_line() +
      geom_point()
  })
}

shinyApp(ui,server)