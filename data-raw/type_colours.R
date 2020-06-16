library(rvest)
library(janitor)
library(tidyverse)

pokemon_colour_page <- read_html("https://bulbapedia.bulbagarden.net/wiki/Category:Type_color_templates")

pokemon_colour_page %>%
  html_nodes(".wikitable") %>%
  html_table() %>%
  .[[1]]-> pokemon_colour_table

pokemon_colour_table %>%
  janitor::clean_names() %>%
  slice(1:75) %>%
  select(-video_game_types_3) %>%
  rename(type_full = video_game_types, colour = video_game_types_2) %>%
  filter(type_full != "") %>%
  mutate(
    type = tolower(str_trim(str_remove_all(type_full, "color|light|dark|\\:"))),
    colour_var = case_when(
      str_detect(type_full, "light") ~ "light",
      str_detect(type_full, "dark") ~ "dark"
    )
  ) %>%
  mutate(colour = paste0("#", colour)) %>%
  select(-type_full, type, colour_var, colour) -> type_colours

usethis::use_data(type_colours, overwrite = TRUE)

type_colours %>%
  filter(is.na(colour_var)) %>%
  select(-colour_var) %>%
  mutate(colour = set_names(colour, type)) %>%
  pull(colour) -> pokemon_type_scale_colours

usethis::use_data(pokemon_type_scale_colours, overwrite = TRUE)

type_colours %>%
  filter(colour_var == "light") %>%
  select(-colour_var) %>%
  mutate(colour = set_names(colour, type)) %>%
  pull(colour) -> pokemon_type_scale_colours_light

usethis::use_data(pokemon_type_scale_colours_light, overwrite = TRUE)

type_colours %>%
  filter(colour_var == "dark") %>%
  select(-colour_var) %>%
  mutate(colour = set_names(colour, type)) %>%
  pull(colour) -> pokemon_type_scale_colours_dark

usethis::use_data(pokemon_type_scale_colours_dark, overwrite = TRUE)

