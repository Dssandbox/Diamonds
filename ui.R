library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Diamond Price Estimator"),

  # Input: dropdown, slider
  sidebarLayout(
    sidebarPanel(
      p("This application will estimate the price of a diamond 
        in U.S. dollars, for a given 
        colour and weight (in carats).\n"), 
      p("Select values below, and an estimated price will be 
        displayed on the plot."), 
      # Specify the colour
      selectInput("colour", 
                  label = "Colour",
                  choices = list("D","E","F","G","H","I","J"),
                  selected = "G"),
      # Specify the carat weight
      sliderInput("carats", "Carats",
                  min = 1.0, max = 2.0, value = 1.5, step=0.1)

    ),

    # Show a plot of diamonds with the selected characteristics
    # Reactive output
    mainPanel(
      plotOutput("diamondPlot")
    )
  )
))
