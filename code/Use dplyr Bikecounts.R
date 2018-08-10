library(tidyverse)
library(readxl)
library(dplyr)

input_file <- "data/Hawthorne Tilikum Steel daily bike counts 073118.xlsx"
bridge_name <- "Hawthorne"

# define a funtion that load bike counts data
load_data <- function(input_file, bridge_name) {
  bikecounts <- read_excel(input_file,
                           sheet = bridge_name,
                           skip = 1)
  bikecounts$name <- bridge_name
  bikecounts
}

Tilikum <- load_data(input_file, "Tilikum")
Hawthorne <- load_data(input_file, "Hawthorne")
names(Hawthorne) <- names(Tilikum)

Hawthorne
#add day of the week columns in the table
Hawthorne$day <- weekdays(as.Date(Hawthorne$date))
Hawthorne

Table1 <- Hawthorne %>%
  filter(is.na(westbound) | is.na(eastbound)) %>%
  Table1 %>% group_by(day) %>%
  tally
Table1
