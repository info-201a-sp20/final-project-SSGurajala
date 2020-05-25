## Aggregate Table Script

dataset <- read.csv("data/neoplasm/neoplasms_data.csv", stringsAsFactors=FALSE)

#finds average YYLs per country by percent (1990-2017)

aggregate <- function(dataset) {
  YYLs <- dataset %>%
    group_by(location) %>%
    filter(measure == "YLLs (Years of Life Lost)" 
           & metric == "Percent") %>%
    summarise(mean_YYLs = mean(val))
  
  Deaths <- dataset %>%
    group_by(location) %>%
    filter(measure == "Deaths" 
           & metric == "Percent") %>%
    summarise(mean_Deaths = mean(val))
  
  DALYs <- dataset %>%
    group_by(location) %>%
    filter(measure == "DALYs (Disability-Adjusted Life Years)" 
           & metric == "Percent") %>%
    summarise(mean_DALYs = mean(val))
  
  table <- left_join(YYLs, Deaths) %>%
    left_join(DALYs)
  
  kable(table, col.names = c("Location", "Years of Life Lost", 
  "Deaths", "Disability-Adjusted Life Years"))
}

aggregate_table <- aggregate(dataset)

