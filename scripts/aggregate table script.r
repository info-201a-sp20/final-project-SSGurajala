## Aggregate Table Script

dataset <- read.csv("data/neoplasm/neoplasms_data.csv",
                    stringsAsFactors = FALSE)

# finds average YLLs (Years of Life Lost), average Deaths,
# and average DALYs (Disability-Adjusted Life Years) per
# country by percent (1990-2017)

aggregate <- function(dataset) {

  #finding average percent YYLs by location
  years_lost <- dataset %>%
    group_by(location) %>%
    filter(measure == "YLLs (Years of Life Lost)"
           & metric == "Percent") %>%
    summarise(mean_YYLs = mean(val))

  #finding average percent deaths by location
  deaths <- dataset %>%
    group_by(location) %>%
    filter(measure == "Deaths"
           & metric == "Percent") %>%
    summarise(mean_deaths = mean(val))

  #finding average percent DALYs by location
  disability_adjusted <- dataset %>%
    group_by(location) %>%
    filter(measure == "DALYs (Disability-Adjusted Life Years)"
           & metric == "Percent") %>%
    summarise(mean_DALYs = mean(val))

  #combining dataframes
  table <- left_join(years_lost, deaths) %>%
    left_join(disability_adjusted)

  #turning dataframe into table
  kable(table, col.names = c("Location", "Years of Life Lost",
  "Deaths", "Disability-Adjusted Life Years"))
}

aggregate_table <- aggregate(dataset)
