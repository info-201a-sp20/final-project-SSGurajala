# Generates histogram of DALY rate in 2017
density_histogram_2017 <- function(dataset) {
  # filters data down to DALY measure, 201, and Rate metric
  library(dplyr)
  plotting_data <- dataset %>%
    filter(year == "2017") %>%
    filter(measure == "DALYs (Disability-Adjusted Life Years)") %>%
    filter(metric == "Rate") %>%
    select(val)
  # Generates Histogram of density of value distribution
  library(ggplot2)
  histogram <- ggplot(plotting_data, aes(x = val)) +
    geom_histogram(
      binwidth = 200, aes(y = ..density..),
      color = "black", fill = "white"
    ) +
    geom_density(alpha = 0.3, fill = "#FF6666") +
    geom_vline(aes(xintercept = mean(val))) +
    labs(
      title = "Global Density Distribution of 2017 DALY Rate per 100,000",
      x = "DALY rate per 100,000",
      y = "Density"
    ) +
    theme_bw()
  return(histogram)
}
