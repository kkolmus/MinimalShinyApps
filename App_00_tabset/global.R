# 1. LIBS ----

library(shiny)
library(shinyWidgets)
library(shinythemes)
library(tidyr)
library(dplyr)
library(tibble)
library(ggplot2)

# 2. DATA ----

ds <- iris %>%
  tibble::rowid_to_column(var = "Id") %>%
  tidyr::pivot_longer(
    ! c(Species, Id),
    names_to = "Features",
    values_to = "Length")

features <- ds %>% dplyr::pull(Features) %>% unique()

# 3. FUNCTIONS AND MODULES ----

AppSupportingR <- list.files(
  path = c("./R", "./modules", "./tabs"),
  pattern = ".R",
  recursive = TRUE,
  full.names = TRUE)

for (i in AppSupportingR) {
  source(i)
}
