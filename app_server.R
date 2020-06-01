library(dplyr)
library(shiny)
library(plotly)

# Read in data
dataset <- read.csv("data/neoplasm/neoplasms_data.csv",
                    stringsAsFactors = FALSE)

# Define server function
server <- function(input, output) {
  output$summary <- renderTable({ 
    return()
  })
}
