library(dplyr)

disease_summary_info <- function(db) {
  # create an empty list
  ret <- list()
  
  # row number
  ret$case_num <- nrow(db)
  
  # attribute names
  ret$attr_name <- colnames(db)
  
  # measure type
  db_type <- db %>%
    select(measure)
  db_type <- unique(db_type)
  ret$measure_type <- c(db_type)
  
  # year range (min and max)
  db_year <- db %>%
    select(year)
  db_year <- unique(db_year)
  ret$year_range$min <- min(db_year)
  ret$year_range$max <- max(db_year)
  
  # gender range(categories)
  db_gender <- db %>%
    select(sex)
  db_gender <- unique(db_gender)
  ret$gender_category <- c(db_gender)
  
  return(ret)
}