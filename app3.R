library(shiny)
## Only run examples in interactive R sessions
if (interactive()) {
  
  ui <- fluidPage(
    titlePanel("Patient Data"),
    sidebarLayout(
      
      sidebarPanel(
        fileInput("datafile", "Choose CSV File", accept = c("text/csv","text/comma-separated-values,text/plain",".csv")),
        selectInput("var", "Variable", c("Age" = "age", "Height" = "height", "Weight" ="weight", "BMI" = "bmi")),
        tags$hr(),
        checkboxInput("header", "Header", TRUE),
        radioButtons("rb", "Choose a colour", c("Red" = "red", "Green" = "green", "Yellow" = "yellow", "Blue" = "blue"))
    ),
      
      mainPanel(
        tableOutput("contents"),
        plotOutput("box")
      )
      )
    )
    
  
  server <- function(input, output) {
    output$contents <- renderTable({
    (req(input$datafile))
    inFile <- input$datafile
    if (is.null(inFile))
      return(NULL)
    c <- read.csv(inFile$datapath, header = input$header)
     
    })
    output$box <- renderPlot({
      (req(input$datafile))
      inFile <- input$datafile
      data <- read.csv(inFile$datapath, header = input$header)
      var <- input$var
      col <- input$rb
      boxplot(data[,var], col=col, main=paste("Selected Variable", var))
    
     
      
      
      })
  }
  
  #Run the Application
  shinyApp(ui, server)
}
