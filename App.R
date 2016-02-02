#### Load necessary packages and data ####
library(shiny)
library(networkD3)

#### UI ####

ui <- shinyUI(fluidPage(
  
  titlePanel("Traders for Stock A Ltd "),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("opacity", "Opacity", 0.6, min = 0.1,
                  max = 1, step = .1),
      dateInput("trading",
                label = 'Select a market day between January 2006 and February 2006',
                value = "2006-01-04",min="2006-01-04",max="2006-02-28"
                
      )
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Simple Network", simpleNetworkOutput("simple"))
      )
      
    )
  )
))

#### Server ####
server <- function(input, output) {
  
  output$simple <- renderSimpleNetwork({
    netdata <- read.csv("MM.csv")
    netdata$Date<-as.Date(netdata$Date,"%d/%m/%Y")
    subdata<-subset(netdata,netdata$Date==input$trading)
    simpleNetwork(subdata, Source = "Seller", Target = "Buyer", height = NULL,
                  width = NULL, linkDistance = 50, charge = -200, fontSize = 14,
                  fontFamily = "serif", linkColour = "black", nodeColour = "green",
                  nodeClickColour = "red", textColour = "black", input$opacity,
                  zoom = F)
    
  })
}



#### Run ####
shinyApp(ui = ui, server = server)