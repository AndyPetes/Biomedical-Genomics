library(shiny)

ui <- fluidPage(
  headerPanel("Normal Probability Dstribution"),
  numericInput(inputId = "n",
               "Random Samples",
               value = 30),
  sliderInput(inputId = "mean",
              label = "Mean",
              value = 25, min = 1, max = 100),
  sliderInput(inputId = "sd",
              label = "Standard Deviation",
              value = 10, min = 1, max = 100),
  plotOutput("hist")
)

server <- function(input, output) {
  output$hist <- renderPlot({
    hist(rnorm(input$n, mean = input$mean, sd = input$sd), main = "Normal Distribution of Data", xlab = "X axis")
  })
  
}

shinyApp(ui = ui, server = server)
