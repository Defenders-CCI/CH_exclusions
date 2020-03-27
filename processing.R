library(plyr)
library(dplyr)
library(tidyr)

#dat <- readRDS("data/CH_exclusions_data.rds")[1:84,]
# Updated data from Andrew
dat <- read.csv(file = 'data-raw/CH_exclusions_revised.csv', header=TRUE,
                stringsAsFactors = FALSE)
lis <- read.csv('data/listing_data_2019-12-16.csv', header = TRUE)
#lis <- import("data/listing_data_2019-12-16.csv")
names(lis) <- c("common_name", "scientific_name", "sp_url", "status", "entity",
                "esa_listing_date", "reg_desc", "reg_name", "reg_url", "taxon",
                "ch", "ch_date")
lis$ch <- ifelse(lis$ch == "", "None", as.character(lis$ch))

d2 <- left_join(dat, lis, by="scientific_name")%>% 
  select(-c("common_name.y", "status.y", "esa_listing_date.y"))
names(d2)[1:5] <- c("common", "scientific", "url", "status", "listing_date")
d2$esa_listing_date <- as.Date(d2$listing_date, format = "%m-%d-%Y")

saveRDS(d2, file = 'vignette/data/d2.rds')
saveRDS(lis, file = 'vignette/data/lis.rds')
