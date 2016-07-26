# server.R

library(quantmod)
source("helpers.R")

shinyServer(function(input, output) {

  output$plot <- renderPlot({
    data <- getSymbols(input$symb, src = "yahoo", 
      from = input$dates[1],
      to = input$dates[2],
      auto.assign = FALSE)
    ##if needed can remove to bring back to normal
    dataInput <- reactive({
      getSymbols(input$symb, src = "yahoo", 
                 from = input$dates[1],
                 to = input$dates[2],
                 auto.assign = FALSE)
    })
    
    
    ##Adding reactive for inflation, remove from here to next # to bring back to normal
    
    
    finalInput <- reactive({
      if (!input$adjust) return(dataInput())
      adjust(dataInput())
    })
    
    
    output$plot <- renderPlot({
      chartSeries(finalInput(), theme = chartTheme("white"), 
                  type = "line", log.scale = input$log, TA = NULL)})
    
    #############################################################
    
    ##Put back to data if needed back to normal
                 
    chartSeries(dataInput(), theme = chartTheme("white"), 
      type = "line", log.scale = input$log, TA = NULL)
  })
  
})
