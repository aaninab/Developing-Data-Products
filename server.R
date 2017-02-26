# Visualization of British Columbia Liquor Store data - server part


# Load the libraries shiny, ggplot and dplyr(data manipulation)
library(shiny)
library(ggplot2)
library(dplyr)

# Load the data of the British Columbia Liquor Store into a variable 
bcls <- read.csv("BC_Liquor_Store_Product_Price_List.csv", stringsAsFactors = FALSE) 


shinyServer(function(input, output) {
  
  # Draw a histrogram of alcohol content according to the chosen filters
  output$plot <- renderPlot({
    # Filter the data to reduce number of lines in the data sets
    bcls_filt <- bcls %>%
                 filter(
                   CURRENT_DISPLAY_PRICE >= input$pricein[1],
                   CURRENT_DISPLAY_PRICE <= input$pricein[2],
                   PRODUCT_COUNTRY_ORIGIN_NAME == input$countryin,
                   PRODUCT_CLASS_NAME == input$typein
                 )
    # Draw the histogram with ggplot and name the axis and title
    ggplot(data = bcls_filt, aes(x = PRODUCT_ALCOHOL_PERCENT)) + 
      geom_histogram() + 
      ggtitle("Histogram of Alcohol Content") + 
      xlab("Alcohol Content in %") + 
      ylab("Number of Liquors")
  })
  
  # Show some details about the underlying data of the histogram
  output$table <- renderTable({
    bcls_filt <- bcls %>%
      filter(
        CURRENT_DISPLAY_PRICE >= input$pricein[1],
        CURRENT_DISPLAY_PRICE <= input$pricein[2],
        PRODUCT_COUNTRY_ORIGIN_NAME == input$countryin,
        PRODUCT_CLASS_NAME == input$typein
      )
    bcls_filt[,c("PRODUCT_LONG_NAME", "PRODUCT_ALCOHOL_PERCENT", "CURRENT_DISPLAY_PRICE")]
  })
  
})
