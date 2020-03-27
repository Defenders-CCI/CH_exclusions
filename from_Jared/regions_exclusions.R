setwd("C:/Users/jhocking/Downloads/")
data <- read.csv("exclusions.csv")

#Question 1: Are CH exclusions, in particular for economic reasons, correlated with the use of "conflict" tags in recovery priority numbers?

exclusions <- c(5,22) 
no_exclusions=c(8,31) 
conflict= c('Conflict tag', 'No conflict tag') 
contable <- rbind(exclusions,no_exclusions)
colnames(contable) <- conflict
contable
chisq.test(contable)


#Question 2: Are there regional patterns to CH exclusions? 
library(multcomp)
region=read.csv("regions.csv")
str(regions)
regions$region <- as.factor(regions$region)
str(regions)
regions <- read.csv("regions_2.csv")
field_mod <- glm(exclusions ~ region, data=regions, family=binomial(link="logit"))
summary(field_mod)
glht(field_mod, linfct = mcp(region = c("2 - 8 = 0"))) 
dummy <- paste("region",regions$region, sep="")
dummy
regions$region <- as.factor(dummy)
head(regions)
field_mod <- glm(exclusions ~ region -1 , data=regions, family=binomial(link="logit"))
summary(field_mod)
summary(glht(field_mod, linfct = mcp(region = c("region1 - region2 = 0", "region1 - region4 = 0", "region1 - region6 = 0",  "region1 - region7 = 0", "region1 - region8 = 0", 
                                                "region2 - region4 = 0", "region2 - region6 = 0", "region2 - region7 = 0", "region2 - region8 = 0", "region4 - region6 = 0", "region4 - region8 = 0", "region1 - region7 = 0", "region7 - region8 = 0")))) 
exp(.47)
summary(glht(field_mod, linfct = mcp(region = c("region2 - region1 = 0"))))
glht(field_mod, linfct = mcp(region = c("region2 - region4 = 0"))) 
exp(1.946) 
glht(field_mod, linfct = mcp(region = c("region4 - region6 = 0"))) 
exp(14.62)
glht(field_mod, linfct = mcp(region = c("region4 - region7 = 0"))) 
exp(-18.51)
summary(glht(field_mod, linfct = mcp(region = c("region4 - region8 = 0")))) 
exp(-1.476)
#This estimate is the difference in the log odds between two regions 

?chisq.test