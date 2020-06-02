library(dplyr)
library(shiny)
library(plotly)

# Read in data
neoplasm <- read.csv("data/neoplasm/neoplasms_data.csv",
                    stringsAsFactors = FALSE)
cardiovascular <- read.csv("data/cardiovascular disease/
                           cardiovascular_disease_data.csv",
           stringsAsFactors = FALSE)
chronic_respiratory <- read.csv("data/chronic respiratory disease/
                                chronic_respiratory_disease_data.csv",
                    stringsAsFactors = FALSE)
# Define server function
server <- function(input, output) {
  output$summary <- renderTable( {
    return()
  })
}



