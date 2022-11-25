# Script name
# Author
# Date


# Libraries ---------------------------------------------------------------

library(tidyverse)
library(palmerpenguins)


# Data --------------------------------------------------------------------

# The mangled data
load("course_material/data/OISST_mangled.RData")
head(OISST2)

# The tidy data
sst_NOAA <- read_csv("course_material/data/sst_NOAA.csv")


# Example -----------------------------------------------------------------

head(OISST1)

ggplot(data = OISST1, aes(x = t, y = temp)) +
  geom_line(aes(colour = site)) +
  labs(x = NULL, y = "Temperature (\u00b0C)", colour = "Site") +
  theme_bw()


# Exercise 1 --------------------------------------------------------------

# Combine OISST4a and OISST4b into a new object
head(OISST4a,2)
head(OISST4b,2)

# Separate OISST4a index into site and date
OISST4a_tidy <- OISST4a %>% 
  separate(col = index, into = c("site", "t"), sep = " ")
head(OISST4a_tidy)

# OISST4b dates united to one column
OISST4b_tidy <- OISST4b %>% 
  unite(year, month, day, col = "t", sep = "-")
head(OISST4b_tidy)

# Combining OISST4 a and b

OISST4_tidy <- left_join(OISST4a_tidy, OISST4b_tidy)

OISST4_tidiest <- left_join(OISST4a_tidy, OISST4b_tidy, by = c("site", "t"))
head(OISST4_tidy)

# Exercise 2 --------------------------------------------------------------

# Ensure that the date formatting is correct on your new object
head(OISST4_tidiest)


# Exercise 3 --------------------------------------------------------------

# Split the date column on `sst_NOAA` and re-unite them
head(sst_NOAA, 2)


# BONUS -------------------------------------------------------------------

# Plot the temperatures of two time series against each other as a scatterplot
# Meaning temperature from time series 1 are the X axis, and time series 2 on the Y axis
# Hint: This requires filtering out one time series
# Then pivoting the temperatures wide into columns

