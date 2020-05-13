library(tidyverse)
`%notin%` <- Negate(`%in%`)

# Clone down veekun most recent master branch https://github.com/veekun/pokedex/blob/master/doc/main-tables.rst
git2r::clone('https://github.com/veekun/pokedex', './data-raw/veekun')

# Copy selected files to data-raw
file.copy(from = './data-raw/veekun/pokedex/data/csv',
          to = './data-raw/csv',
          recursive = TRUE)

# Delete veekun
unlink('./data-raw/veekun', recursive = TRUE, force = TRUE)
