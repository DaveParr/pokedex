library(tidyverse)

# List files in directory
file_list <- list.files("./data-raw/csv/", "*.csv") %>%
  discard(.p = str_detect, pattern = "^conquest") # for a wierd non-main game

# Read as list of tibbles
file_list %>%
  map( ~ read_csv(paste0("./data-raw/csv/", .))) %>%
  set_names(., str_replace(file_list, ".csv", "")) -> pokedex

# Expose the list of all the csv data
usethis::use_data(pokedex, overwrite = TRUE)
