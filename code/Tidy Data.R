library(tidyverse)
table4a
table4a %>%
  gather('1999':'2000', key = "year", value = "cases")

table4b
table4b %>%
  gather('1999':'2000', key = "year", value = "population")

tidy4a <- table4a %>%
  gather('1999':'2000', key = "year", value = "cases")
tidy4b <- table4b %>%
  gather('1999':'2000', key = "year", value = "population")
left_join(tidy4a,tidy4b)

