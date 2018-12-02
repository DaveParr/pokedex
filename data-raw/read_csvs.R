library(tidyverse)
library(git2r)

# Clone down veekun most recent master branch
git2r::clone('https://github.com/veekun/pokedex', './data-raw/veekun')

# Copy selected files to data-raw
file.copy(from = './data-raw/veekun/pokedex/data/csv', to = './data-raw/', recursive = TRUE)

# Delete veekun
unlink('./data-raw/veekun', recursive = TRUE, force = TRUE)

# List files in directory
file_list <- list.files("./data-raw/csv", "*.csv")

# Read as list of tibbles
file_list %>%
  map( ~ read_csv(paste0("./data-raw/csv/", .))) %>%
  set_names(., str_replace(file_list, ".csv", "")) -> pokedex

usethis::use_data(pokedex)
