library(tidyverse)
library(git2r)
`%notin%` <- Negate(`%in%`)

# Clone down veekun most recent master branch https://github.com/veekun/pokedex/blob/master/doc/main-tables.rst
git2r::clone('https://github.com/veekun/pokedex', './data-raw/veekun')

# Copy selected files to data-raw
file.copy(from = './data-raw/veekun/pokedex/data/csv', to = './data-raw/', recursive = TRUE)

# Delete veekun
unlink('./data-raw/veekun', recursive = TRUE, force = TRUE)

# List files in directory
file_list <- list.files("./data-raw/", "*.csv") %>%
  discard(.p=str_detect, pattern="^conquest") # for a wierd non-main game

# Read as list of tibbles
file_list %>%
  map( ~ read_csv(paste0("./data-raw/", .))) %>%
  set_names(., str_replace(file_list, ".csv", "")) -> pokedex

usethis::use_data(pokedex, overwrite = TRUE)

pokedex$pokemon_types %>%
  left_join(pokedex$types, by = c("type_id" = "id")) %>%
  select(pokemon_id, slot, identifier) %>%
  pivot_wider(names_from = slot, values_from = identifier, names_prefix = "type_") -> simple_types

pokedex$pokemon_species_flavor_text %>%
  filter(language_id == 9) %>%
  group_by(species_id) %>%
  mutate(flavour_text = str_squish(flavor_text)) %>%
  distinct(flavour_text) %>%
  nest() %>%
  rename(flavour_text = data) -> simple_species_flavour_text

pokedex$pokemon_stats %>%
  left_join(pokedex$stat_names %>% filter(local_language_id == 9), by = c("stat_id")) %>%
  select(pokemon_id, name, base_stat) %>%
  pivot_wider(names_from = name, values_from = base_stat) %>%
  janitor::clean_names() -> simple_pokemon_stats

pokedex$pokemon %>%
  select(-order) %>%
  left_join(
    simple_pokemon_stats,
    by = c("id" = "pokemon_id")
  ) %>%
  left_join(simple_types, by = c("id" = "pokemon_id")) %>%
  left_join(
    simple_species_flavour_text,
    by = c("id" = "species_id")
  ) %>%
  left_join(
    pokedex$pokemon_species_names %>%
      filter(local_language_id == 9),
    by = c("id" = "pokemon_species_id")
    ) %>%
  left_join(
    pokedex$pokemon_species %>% select(-order),
    by = c("species_id" = "id", "identifier"),
    suffix = c("_mon", "_species")
  ) %>%
  left_join(
    pokedex$pokemon_evolution,
    by = c("id"),
    suffix = c("_mon", "_evolution")
  ) %>%
  left_join(
    pokedex$pokemon_forms %>% select(-order),
    by = c("species_id" = "id", "identifier"),
    suffix = c("_mon", "_form")
  ) -> pokemon



