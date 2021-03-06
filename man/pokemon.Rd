% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{pokemon}
\alias{pokemon}
\title{Pokemon specific data, in a tidy format}
\format{A data frame with 807 rows and 24 variables:
\describe{
  \item{\code{id}}{double COLUMN_DESCRIPTION}
  \item{\code{identifier}}{character COLUMN_DESCRIPTION}
  \item{\code{species_id}}{double COLUMN_DESCRIPTION}
  \item{\code{height}}{double COLUMN_DESCRIPTION}
  \item{\code{weight}}{double COLUMN_DESCRIPTION}
  \item{\code{base_experience}}{double COLUMN_DESCRIPTION}
  \item{\code{is_default}}{double COLUMN_DESCRIPTION}
  \item{\code{hp}}{double COLUMN_DESCRIPTION}
  \item{\code{attack}}{double COLUMN_DESCRIPTION}
  \item{\code{defense}}{double COLUMN_DESCRIPTION}
  \item{\code{special_attack}}{double COLUMN_DESCRIPTION}
  \item{\code{special_defense}}{double COLUMN_DESCRIPTION}
  \item{\code{speed}}{double COLUMN_DESCRIPTION}
  \item{\code{type_1}}{character COLUMN_DESCRIPTION}
  \item{\code{type_2}}{character COLUMN_DESCRIPTION}
  \item{\code{flavour_text}}{list COLUMN_DESCRIPTION}
  \item{\code{name}}{character COLUMN_DESCRIPTION}
  \item{\code{genus}}{character COLUMN_DESCRIPTION}
  \item{\code{generation_id}}{double COLUMN_DESCRIPTION}
  \item{\code{evolves_from_species_id}}{double COLUMN_DESCRIPTION}
  \item{\code{evolution_chain_id}}{double COLUMN_DESCRIPTION}
  \item{\code{color}}{character COLUMN_DESCRIPTION}
  \item{\code{shape}}{character COLUMN_DESCRIPTION}
  \item{\code{habitat}}{character COLUMN_DESCRIPTION}
}}
\source{
\url{https://github.com/veekun/pokedex}
}
\usage{
pokemon
}
\description{
An extract from the pokedex of relevant data on specific pokemon. Each Pokemon is in it's own row. Some columns are nested information for that particular Pokemon
}
\keyword{datasets}
