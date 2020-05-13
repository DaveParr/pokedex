# Create a tidy pokemon table, with key info
library(tidyverse)
library(pokedex)

# Simple types
pokedex$pokemon_types %>%
  left_join(pokedex$types, by = c("type_id" = "id")) %>%
  select(pokemon_id, slot, identifier) %>%
  pivot_wider(names_from = slot, values_from = identifier, names_prefix = "type_") -> simple_types

# Simple flavour text
pokedex$pokemon_species_flavor_text %>%
  filter(language_id == 9) %>%
  group_by(species_id) %>%
  mutate(flavour_text = str_squish(flavor_text)) %>%
  distinct(flavour_text) %>%
  nest() %>%
  rename(flavour_text = data) -> simple_species_flavour_text

# Simple stats
pokedex$pokemon_stats %>%
  left_join(pokedex$stat_names %>% filter(local_language_id == 9), by = c("stat_id")) %>%
  select(pokemon_id, name, base_stat) %>%
  pivot_wider(names_from = name, values_from = base_stat) %>%
  janitor::clean_names() -> simple_pokemon_stats

# Simple species names
pokedex$pokemon_species_names %>%
  filter(local_language_id == 9) %>%
  select(pokemon_species_id, name, genus) -> simple_species_names

# Simple species
pokedex$pokemon_species %>%
  select(id,
         identifier,
         generation_id,
         evolves_from_species_id,
         evolution_chain_id,
         color_id,
         shape_id,
         habitat_id) -> simple_species

# Create the table
pokedex$pokemon %>%
  filter(id < 10001) %>% # remove pokemon with different forms
  select(-order) %>%
  left_join(simple_pokemon_stats,
            by = c("id" = "pokemon_id")) %>%
  left_join(simple_types, by = c("id" = "pokemon_id")) %>%
  left_join(
    simple_species_flavour_text,
    by = c("id" = "species_id")
  ) %>%
  left_join(
    simple_species_names,
    by = c("id" = "pokemon_species_id")
    ) %>%
  left_join(
    simple_species,
    by = c("species_id" = "id", "identifier"),
    suffix = c("_mon", "_species")
  ) %>%
  left_join(pokedex$pokemon_colors,
            by = c("color_id" = "id"),
            suffix = c("", "_color")) %>%
  select(-color_id) %>%
  rename("color" = "identifier_color") %>%
  left_join(pokedex$pokemon_shapes,
            by = c("shape_id" = "id"),
            suffix = c("", "_shape")) %>%
  select(-shape_id) %>%
  rename("shape" = "identifier_shape") %>%
  left_join(pokedex$pokemon_habitats,
            by = c("habitat_id" = "id"),
            suffix = c("", "_habitat")) %>%
  select(-habitat_id) %>%
  rename("habitat" = "identifier_habitat") %>%
  # convert integer value to metric decimal m and kg
  mutate_at(c("height", "weight"), ~ .x / 10) -> pokemon

usethis::use_data(pokemon, overwrite = TRUE)
