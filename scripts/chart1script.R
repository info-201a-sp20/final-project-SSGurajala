# Generates scatterplot of DALY Rate, YLL Rate, and Mortality Rate
# Versus SDI value
scatter_plot_2017 <- function(neoplasms_data, sdi_data) {
  library(dplyr)
  # Filter neoplasms data
  neoplasms_data_1 <- neoplasms_data %>%
    filter(year == "2017") %>%
    filter(metric == "Rate") %>%
    select(location, val, measure)
  # Filter sdi data
  sdi_data_1 <- sdi_data %>%
    filter(Year == "2017") %>%
    select(Location, SDI.Index.Value) %>%
    rename(location = Location)
  # Join data sets
  plotting_data <- na.omit(left_join(neoplasms_data_1, sdi_data_1)) %>%
    select(val, SDI.Index.Value, measure)
  # Making the plot
  library(viridis)
  scatter_plot <- ggplot(plotting_data, aes(x = val, y = SDI.Index.Value)) +
    geom_point(aes(color = SDI.Index.Value)) +
    scale_color_viridis(option = "inferno") +
    scale_x_continuous(name = "Rate per 100,000 population") +
    scale_y_continuous(name = "SDI Index Value") +
    ggtitle("Disease Burden of Neoplasms vs SDI Index Value
            for 402 locations in 2017") +
    facet_wrap(~measure) +
    theme_bw()
  return(scatter_plot)
}
