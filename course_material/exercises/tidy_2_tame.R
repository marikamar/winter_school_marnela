# Script name
# Author
# Date


# Libraries ---------------------------------------------------------------

library(tidyverse)
library(lubridate)


# Data --------------------------------------------------------------------

# SST data
sst_NOAA <- read_csv("course_material/data/sst_NOAA.csv")


# Example -----------------------------------------------------------------

# All five functions at once
sst_NOAA %>% 
  arrange(site, temp) %>% 
  select(t, temp) %>% 
  filter(temp >= 23) %>% 
  mutate(year = year(t)) %>% 
  summarise(mean_year = mean(year))


# Exercise 1 --------------------------------------------------------------

# Filter a dataset to have only data for WA from 2005-2010
# Plot as a line plot
sst_NOAA_2005_2010_WA <- sst_NOAA %>%
  filter(site == "WA", year(t) >= 2005 & year(t) <= 2010)
write_csv(sst_NOAA_2005_2010_WA, "course_material/data/sst_NOAA_2005_2010_WA.csv")

ggplot(data = sst_NOAA_2005_2010_WA,
       aes(x = t, y = temp, color = "red"))
#colnames(sst_NOAA_2005_2010)

maa <- c(1, 2, 3) %>%
  filter(data == 2) %>%
  summarise()
ls()

# Exercise 2 --------------------------------------------------------------

# Create an informative table of the 10 highest monthly temperature in the Med


# Exercise 3 --------------------------------------------------------------

# Plot the the annual mean temperatures of WA as a bar plot


# BONUS -------------------------------------------------------------------

# Find the mean temperature for 2002 in Med and 2005 in WA in the same code chunk

