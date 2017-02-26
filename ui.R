# Visualization of British Columbia Liquor Store data - user interface part


# Load the library shiny
library(shiny)

# Define UI 
shinyUI(fluidPage(
  
  # Define the title
  titlePanel("Liquor Store"),
  
  # Sidebar with input
  sidebarLayout(
    sidebarPanel(
      # Documentation
      p("This application shows a distribution of the alcohol content of liquor. It is filtered per country and per liquor type
        within a given price range.
        "),
      p("Additionally, the underlying data is shown with detailed information in a table below."),
      p("One can choose between four different type of liquors and three countries. Plus, the price range can be defined
        individually."),
      p("It can occur that no plot is shown. In that case no data is available."),
      # Insert a slider to vary price limits of liquor
      sliderInput("pricein",
                  "Price",
                  min = 0,
                  max = 100,
                  value = c(5, 50),
                  pre = "€"),
      # Insert radio buttons to choose between different types of liquor
      radioButtons("typein",
                   "Product",
                   choices = c("BEER", "REFRESHMENT BEVERAGE", "SPIRITS", "WINE")),
      # Insert a selection to choose between different countries
      selectInput("countryin", 
                  "Country", 
                  choices = c("GERMANY", "FRANCE", "ITALY"))
      ),
      
    # Show the results of the filtered data - a plot and a table
    mainPanel(
      plotOutput("plot"), 
      tableOutput("table")
    )
  )
))
