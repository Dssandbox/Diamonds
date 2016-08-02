library(shiny)
library(ggplot2)
library(dplyr)
library(scales)
data(diamonds)

shinyServer(function(input, output) {

  output$diamondPlot <- renderPlot({

    # Prepare the data for the calculation:
    # The relationship between carats and price
    # is linear between and 1.0 and 2.0 carats
    data <- filter(diamonds,color==input$colour) %>%
      filter(carat >= 1.0 & carat <= 2.0)
    
    # Calculation:
    # 1/ Make a linear model based on choice of colour and carat weight
    # 2/ Use the model to predict a price
    model <- lm(price ~ carat, data=data)
    prediction <- predict(model, data.frame(carat=c(input$carats)))
    
    # Prepare the display data - show all colours
    displaydata <- filter(diamonds,carat >= 0.8 & carat <= 2.2)
    
    g <- ggplot(displaydata,aes(carat,price,color=color))
    g <- g + theme(legend.title=element_blank())
    g <- g + coord_cartesian(xlim = c(0.8, 2.2))
    g <- g + geom_point(size=4,alpha=0.3)
    g <- g + geom_point(data=data,size=4,alpha=0.8) # highlight selected colour
    g <- g + geom_smooth(data=data,method="lm",color="black")
    g <- g + labs(x = "Weight (carats)", y = "Price (USD)")
    g <- g + annotate("point", x = input$carats, y = prediction[1], 
                       size=5, shape=18,color="black")
    g <- g + annotate("text", x = input$carats, y = prediction[1] + 1000, 
                       label = dollar(prediction[1]),size=7)
    g <- g + annotate("rect", xmin = 1, ymin = 0, 
                      xmax=2, ymax=20000,color="black",alpha=0)
    print(g)
    
  })

})
