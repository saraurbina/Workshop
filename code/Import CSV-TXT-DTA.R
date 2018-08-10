library(tidyverse)

NCDC1 <- read_csv("data/NCDC-CDO-USC00356750.csv", na = ".") #shows NA cell as ""
as_tibble(NCDC1)
#data.frame(NCDC1)

NCDC2 <- read_tsv("data/NCDC-CDO-USC00356750.txt")
as_tibble(NCDC2)
#data.frame(NCDC2)

library(reader)
#import txt by using read_table 
NCDC3 <- read_table("data/NCDC-CDO-USC00356750.txt", comment = "-")
NCDC3
  #or use this method
cols_df <-read_table("data/NCDC-CDO-USC00356750.txt", n_max=3)
(data_df <-read_table("data/NCDC-CDO-USC00356750.txt", 
                     comment="-", skip=2, col_names = FALSE))
names(data_df) <-names(cols_df)

library(haven)
#import .dta file to R
read_dta("data/iris.dta")

cols_df <-read_table("data/iris.dta")
(data_df <-read_table("data/iris.dta",comment="-", skip=2, col_names = FALSE))
names(data_df) <- names(cols_df)
read_fwf()

