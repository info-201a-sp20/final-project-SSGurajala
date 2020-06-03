library(dplyr)
library(shiny)
library(plotly)

# Read in data
neoplasm <- read.csv("data/neoplasm/neoplasms_data.csv",
                    stringsAsFactors = FALSE)

cardiovascular <- read.csv(
  "data/cardiovascular disease/cardiovascular_disease_data.csv",
           stringsAsFactors = FALSE)

chronic_respiratory <- read.csv(
  "data/chronic respiratory disease/chronic_respiratory_disease_data.csv",
                    stringsAsFactors = FALSE)

sdi_data <- read.csv("data/sdi/data_sdi.csv", stringsAsFactors = FALSE)

# Define server function
server <- function(input, output) {
  output$summary <- renderTable( {
    return()
  })
}


#Page 1 plot code 
neoplasms_data_1 <- neoplasm %>%
  filter(year == "2017") %>%
  filter(metric == "Rate") %>%
  filter(measure == "DALYs (Disability-Adjusted Life Years)") %>% 
  select(location, val, measure, cause)

cardiovascular_data_1 <- cardiovascular %>%
  filter(year == "2017") %>%
  filter(metric == "Rate") %>%
  filter(measure == "DALYs (Disability-Adjusted Life Years)") %>% 
  select(location, val, measure, cause)

chronic_data_1 <- chronic_respiratory %>%
  filter(year == "2017") %>%
  filter(metric == "Rate") %>%
  filter(measure == "DALYs (Disability-Adjusted Life Years)") %>% 
  select(location, val, measure, cause)

sdi_data_1 <- sdi_data %>%
  filter(Year == "2017") %>%
  select(Location, SDI.Index.Value) %>%
  rename(location = Location)

dataset_prelim <- full_join(neoplasms_data_1, cardiovascular_data_1)

dataset_second <- full_join(dataset_prelim, chronic_data_1)

plotting_data <- na.omit(left_join(dataset_second, sdi_data_1)) %>%
  select(val, SDI.Index.Value, measure, cause)

library(viridis)
scatter_plot <- ggplot(plotting_data, aes(x = val, y = SDI.Index.Value)) +
    geom_point(aes(color = SDI.Index.Value)) +
    scale_color_viridis(option = "inferno") +
    scale_x_continuous(name = "Rate per 100,000 population") +
    scale_y_continuous(name = "SDI Index Value") +
    ggtitle("Disease Burden vs SDI Index Value
            for 402 locations in 2017") +
    theme_bw()

#Page 2 Plot Code

#Neoplasm_data
neoplasms_data_2 <- neoplasm %>% 
  filter(measure == "DALYs (Disability-Adjusted Life Years)") %>%
  filter(metric == "Rate") %>%
  select(val, cause, year)
#Cardiovascular Data
cardiovascular_data_2 <- cardiovascular %>% 
  filter(measure == "DALYs (Disability-Adjusted Life Years)") %>%
  filter(metric == "Rate") %>%
  select(val, cause, year)
#Chronic Respiratory Disease Data
chronic_data_2 <- chronic_respiratory %>% 
  filter(measure == "DALYs (Disability-Adjusted Life Years)") %>%
  filter(metric == "Rate") %>%
  select(val, cause, year)

#full joining neoplasm and cardiovascular data   
plot_2_data_prelim <- full_join(neoplasms_data_2, cardiovascular_data_2)
#full joining neoplasm + cardiovascular data with chronic resp. disease data
plot_2_data <- full_join(plot_2_data_prelim, chronic_data_2)

#Code to make histogram 
histogram <- ggplot(plot_2_data, aes(x = val)) +
  geom_histogram(
    binwidth = 200, aes(y = ..density..),
    color = "black", fill = "white"
  ) +
  geom_density(alpha = 0.3, fill = "#FF6666") +
  geom_vline(aes(xintercept = mean(val))) +
  labs(
    title = "Global Density Distribution of DALY Rate per 100,000",
    x = "DALY rate per 100,000",
    y = "Density"
  ) +
  theme_bw()



