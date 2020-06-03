library(dplyr)
library(shiny)
library(ggplot2)

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



#Page 1 plot code 
  #Neoplasm data
  neoplasms_data_1 <- neoplasm %>%
    filter(year == "2017") %>%
    filter(metric == "Rate") %>%
    filter(measure == "DALYs (Disability-Adjusted Life Years)") %>% 
    select(location, val, measure, cause)
  #Cardiovascular data
  cardiovascular_data_1 <- cardiovascular %>%
    filter(year == "2017") %>%
    filter(metric == "Rate") %>%
    filter(measure == "DALYs (Disability-Adjusted Life Years)") %>% 
    select(location, val, measure, cause)
  #Chronic Respiratory Disease Data
  chronic_data_1 <- chronic_respiratory %>%
    filter(year == "2017") %>%
    filter(metric == "Rate") %>%
    filter(measure == "DALYs (Disability-Adjusted Life Years)") %>% 
    select(location, val, measure, cause)
  #SDI data
  sdi_data_1 <- sdi_data %>%
    filter(Year == "2017") %>%
    select(Location, SDI.Index.Value) %>%
    rename(location = Location)
  #Full join first two data sets
  dataset_prelim <- full_join(neoplasms_data_1, cardiovascular_data_1)
  #Create data set with all three causes
  dataset_second <- full_join(dataset_prelim, chronic_data_1)
  #Add SDI data
  plot_1_data <- na.omit(left_join(dataset_second, sdi_data_1)) %>%
    select(val, SDI.Index.Value, measure, cause, location) %>%
    mutate(text = paste("location" = location, "\n",
                        "SDI Value" = SDI.Index.Value, "\n",
                        "DALY Rate" = val))

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
  
#Page 3 Plot Code 
  #neoplasm_data
  neoplasm_data_3 <- neoplasm %>%
    filter(measure == "DALYs (Disability-Adjusted Life Years)") %>%
    filter(metric == "Rate") %>%
    select(year, val, cause, location)
  #cardiovascular data
  cardiovascular_data_3 <- cardiovascular %>%
    filter(measure == "DALYs (Disability-Adjusted Life Years)") %>%
    filter(metric == "Rate") %>%
    select(year, val, cause, location)
  #chronic resp. data
  chronic_data_3 <- chronic_respiratory %>%
    filter(measure == "DALYs (Disability-Adjusted Life Years)") %>%
    filter(metric == "Rate") %>%
    select(year, val, cause, location)
  
  #initial full join
  plot_3_data_prelim <- full_join(neoplasm_data_3, cardiovascular_data_3)
  #final plotting dataset
  plot_3_data <- full_join(plot_3_data_prelim, chronic_data_3)
