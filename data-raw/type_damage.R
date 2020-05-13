pokedex$type_efficacy %>%
  left_join(
    pokedex$types %>% select(-generation_id,-damage_class_id),
    by = c("damage_type_id" = "id")
  ) %>%
  left_join(
    pokedex$types %>% select(-generation_id,-damage_class_id),
    by = c("target_type_id" = "id"),
    suffix = c("_damage", "_target")
  ) %>%
  select(identifier_damage, identifier_target, damage_factor) %>%
  mutate(damage_factor = damage_factor/100) -> type_damage

usethis::use_data(type_damage, overwrite = TRUE)
