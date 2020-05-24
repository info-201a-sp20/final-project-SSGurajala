#Generates line graph of Global DALY Rate from 1990-2017
line_graph <- function(dataset) {
#filtering data to DALY Measure, Global estimate, and Rate metric
  library(dplyr)
  plotting_data <- dataset %>%
    filter(measure == "DALYs (Disability-Adjusted Life Years)") %>%
    filter(metric == "Rate") %>%
    filter(location == "Global") %>%
    select(year, val)
#Generating 
  library(ggplot2)
  line_graph <- ggplot(plotting_data, aes(x = year, y = val)) +
    geom_line(color = "red", size = 1.5) +
    theme_bw() +
    labs(x = "Year", y = "DALY Rate per 100,000",
         title = "Global DALY Rate per 100,000 due
         to Neoplasms from 1990 - 2017")
  return(line_graph)
}
