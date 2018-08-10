library(readxl)
input_file <-"data/Hawthorne Tilikum Steel daily bike counts 073118.xlsx"

library(dplyr) 
  #each sheet is bridge, tally func in dplyr package give us the row information
bridge_1 <-"Hawthorne"
Hawthorne <-read_excel(input_file, 
                         sheet = bridge_1, 
                         skip = 1)
tally(Hawthorne)

  #show data(table) in two form: 
    #data.frame(Hawthorne) 
    #Hawthorne

bridge_2 <-"Tilikum"
Tilikum <-read_excel(input_file, 
                       sheet = bridge_2, 
                       skip = 1)
tally(Tilikum)

bridge_3 <-"Steel"
Steel <-read_excel(input_file, 
                     sheet = bridge_3, 
                     skip = 1)
tally(Steel)

library(lubridate)
  #change the columns name:
names(Steel) <- c("date", "lower", "westbound", "eastbound", "total", "name")
names(Tilikum) <- c("date", "westbound", "eastbound", "total", "name")
  #use the column names of Tilikum for Hawthorne
names(Hawthorne) <- names(Tilikum)

  #combine all three data frame for all three bridges
bikecounts <- bind_rows(Hawthorne, 
                        Tilikum, 
                        Steel %>% select(-lower)) # exclude the `lower` col in Steel data frame

  #average daily bike counts by bridge
bikecounts %>% 
  group_by(name) %>% 
  summarize(avg_daily_counts=mean(total, na.rm=TRUE))

  #average monthly bike counts by bridge
bikecounts %>% 
  #first create ym column as a unique month identifier
  group_by(name, ym=floor_date(date, "month")) %>%
  summarize(total_monthly_counts=sum(total), counts=n()) %>% 
  #then average by month over years for each bridge
  group_by(name, month(ym)) %>% 
  summarize(avg_monthly_counts=mean(total_monthly_counts))

  #Plot
ggplot(data = Hawthorne) + geom_point(mapping = aes(x = date, y = total))
ggplot(data = Hawthorne) + geom_point(mapping = aes(x = date, y = wb))
ggplot(data = Hawthorne) + geom_point(mapping = aes(x = date, y = eb))
