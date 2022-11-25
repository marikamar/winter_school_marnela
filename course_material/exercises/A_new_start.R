# Starting again from the beginning "A new start" 23.11.2022

# Load libraries
library(tidyverse)
library(lubridate)

# Load data
sst_NOAA <- read_csv("course_material/data/sst_NOAA.csv")

# the data has columns site t temp
sst_monthly <- sst_NOAA %>% 
  mutate(month = month(t, label = TRUE)) %>% 
  group_by(site, month) %>% 
  summarise(temp = round(mean(temp, na.rm = TRUE), 3))

# and now a line plot
ggplot(data = sst_monthly, aes(x = month, y = temp)) +
  geom_point(aes(colour = site)) +
  geom_line(aes(colour = site, group = site)) +
  labs(x = NULL, y = "Temperature (°C)")

ggplot(data = sst_monthly, aes(x = month, y = temp)) +
  geom_point(aes(colour = site)) +
  geom_line(aes(colour = site, group = site)) +
  labs(x = "", y = "Temperature (°C)") +
  facet_wrap(~site, ncol = 1) # Create panels
