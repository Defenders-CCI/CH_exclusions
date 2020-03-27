library(janitor)
library(rio)
library(tidyverse)

dat <- import("data-raw/ESA_CH_designations.csv")
dat <- clean_names(dat)
export(dat, "data/CH_designations_2019-05-23.xlsx")
saveRDS(dat, "data/CH_designations_2019-05-23.rds")

HI <- filter(dat, state_abbreviation == "HI") %>%
  distinct(scientific_name, .keep_all = TRUE) %>%
  select(-state_abbreviation) %>%
  add_column(geo = "HI")
US <- filter(dat, state_abbreviation != "HI") %>%
  distinct(scientific_name, .keep_all = TRUE) %>%
  select(-state_abbreviation) %>% 
  add_column(geo = "US")

HI_select <- sample_n(HI, 39)
US_select <- sample_n(US, 45)
select_spp <- rbind(HI_select, US_select)

export(select_spp, "results/CH_exclusions.xlsx")
