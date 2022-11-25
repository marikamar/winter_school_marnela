# Script name
# Author
# Date


# Libraries ---------------------------------------------------------------
<<<<<<< HEAD
# For downloading bathymetry data
library(tidyverse)
library(ggsn)
library(marmap)
=======

# The two packages require for 'marmap' to work
library(rgdal)
library(raster)
>>>>>>> fef91c6be5542af7996a1b3eb35b68ed6a259c11


# Data --------------------------------------------------------------------
bathy_WA <-  getNOAA.bathy(lon1 = 111, lon2 = 117, 
                           lat1 = -36, lat2 = -19, # NB: smaller value first, i.e. more negative
                           resolution = 4) # In degree minutes

# ???


# Example -----------------------------------------------------------------

# The basic map
ggplot() +
  borders(fill = "grey70", colour = "black") +
  coord_equal(xlim = c(-90, -70), ylim = c(20, 40))


# Copied from slides map stuff --------------------------------------------
ggplot() +
  borders(fill = "grey70", colour = "black") +
  coord_equal()

map_global_fix <- map_data('world') %>% 
  rename(lon = long) %>% 
  mutate(group = ifelse(lon > 180, group+2000, group), # Why +2000?
         lon = ifelse(lon > 180, lon-360, lon))

ggplot(data = map_global_fix, aes(x = lon, y = lat)) +
  geom_polygon(aes(group = group), colour = "black", fill = "grey60") +
  # The default coordinate system, with specific limits
  coord_cartesian(xlim = c(-180, 180), ylim = c(-90, 90), expand = FALSE)

# Exercise 1 --------------------------------------------------------------

# Choose a coastal region somewhere within 30°N/S of the equator
<<<<<<< HEAD

# Download bathymetry data and another data layer
# Download bathy data
bathy_WA <-  getNOAA.bathy(lon1 = 111, lon2 = 117, 
                           lat1 = -36, lat2 = -19, # NB: smaller value first, i.e. more negative
                           resolution = 4) # In degree minutes

# Convert to data.frame for use with ggplot2
bathy_WA_df <- fortify.bathy(bathy_WA) %>% 
  filter(z <= 0) # Remove altimetry data

# Save
save(bathy_WA_df, file = "../data/bathy_WA_df.RData")
#NOT WORKING!

# Plot them
=======
# Download bathymetry data and plot them
>>>>>>> fef91c6be5542af7996a1b3eb35b68ed6a259c11


# Exercise 2 --------------------------------------------------------------

# Chose a different region and get bathymetry
# Plot and combine the two figures


# Exercise 3 --------------------------------------------------------------

# Change the themes and minutia of the previous two plots and combine them


# BONUS -------------------------------------------------------------------

# Overlay data layers on a Google map image

