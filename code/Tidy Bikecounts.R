library(tidyverse)
library(readxl)
library(lubridate)
library(ggfortify)

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

Hawthorne <- load_data(input_file, "Hawthorne")
Tilikum <- load_data(input_file, "Tilikum")
Steel <- load_data(input_file, "Steel")

# combine all three data frame for all three bridges
bikecounts <- bind_rows(Hawthorne, 
                        Tilikum, 
                        Steel) # exclude the `lower` col in Steel data frame

bikecounts
#add day of the week columns in the table
bikecounts$day <- weekdays(as_date(bikecounts$date)) %>% 
  bind_rows(tilikum, hawthorne) %>% 
  mutate(date=as_date(date))
bikecounts

bikecounts_day <- bikecounts %>% 
  mutate(week=floor_date(date, "week"),
         month=floor_date(date, "month"),
         year=year(date))
bikecounts_day

bc <- bikecounts_day %>%
  select(name, total, date, week, month, year)
bc

Week <- bc %>% 
  group_by(name, week) %>%
  summarise(total=sum(total))

Month <- bc %>% 
  group_by(name, month) %>%
  summarise(total=sum(total))

#scatter plots
ggplot(bc) + 
  geom_point(mapping = aes(x = name, y = total, color = name))
ggplot(Week) + 
  geom_point(mapping = aes(x = week, y = total, color = name))
#bar plots
ggplot(bc) + 
  geom_bar(mapping = aes(x = name, y = total, color = name), stat = "identity")
ggplot(Week) + 
  geom_bar(mapping = aes(x = week, y = total, fill = week), stat = "identity")
#line plots
ggplot(Month) +
  geom_line(aes(x=month, y=total, color=day))

ggplot(bc, mapping = aes(x = date, y = total, color = name)) + 
  #geom_point() +
  geom_smooth()

library(ggfortify)
data(Month)
bc_ts <- ts(Month$total, start=2012, frequency = 365)
autoplot(stl(bc_ts, s.window = 'periodic'), ts.colour = 'blue', ts.linetype = 'dashed')
