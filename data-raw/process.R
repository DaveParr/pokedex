library(tidyverse)

# List files in directory
file_list <- list.files("./data-raw/", "*.csv")

# Read as list of tibbles
file_list %>%
  map( ~ read_csv(paste0("./data-raw/", .))) %>%
  set_names(., str_replace(file_list, ".csv", "")) -> pokedex

usethis::use_data(pokedex, overwrite = TRUE)

