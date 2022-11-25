# Script name
# Author
# Date

#library(remotes)
#
#remotes::install_github("MikkoVihtakari/ggOceanMapsData")
#remotes::install_github("MikkoVihtakari/ggOceanMaps")

# Libraries ---------------------------------------------------------------
library(tidyverse)
library(ggOceanMaps)
library(ggOceanMapsData)

# ???


# Data --------------------------------------------------------------------

# SST from github R course copied to own laptop
#load("../data/OISST_2022.RData")
load("course_material/data/OISST_2022.RData")

# Example -----------------------------------------------------------------

# An Arctic plot
basemap(limits = c(-160, -80, 60, 85), rotate = TRUE)


# Exercise 1 --------------------------------------------------------------

# Directly access the shape of a region near a pole and plot with polar projection
ggplot() +
  borders(fill = "grey70", colour = "black") +
  coord_polar()

# Directly access the shape of a region near a pole
# Plot with coord_map(projection = "ortho")

# Fixed base map, two blocks below from slides. Forgot to do before
map_global_fix <- map_data('world') %>% 
  rename(lon = long) %>% 
  mutate(group = ifelse(lon > 180, group+2000, group), # Why +2000?
         lon = ifelse(lon > 180, lon-360, lon))

ggplot(data = map_global_fix, aes(x = lon, y = lat)) +
  geom_polygon(aes(group = group)) +
  # Equal sizing for lon/lat 
  coord_equal()

# Filter map data and plot it in one code chunk
map_global_fix %>% 
  filter(lon > 9, lon < 28, lat > 76, lat < 81) %>% 
  ggplot(aes(x = lon, y = lat)) +
  geom_polygon(aes(group = group)) +
  # Filtering the OISST_2022 data directly in geom_tile()
  geom_tile(data = filter(OISST_2022,
                          lon > 9, lon < 28, lat > 76, lat < 81), 
            aes(fill = temp)) +
  coord_map(projection = "ortho", orientation = c(90, 0, 0))

# Exercise 2 --------------------------------------------------------------

# Add bathymetry to this plot


# Exercise 3 --------------------------------------------------------------

# Use ggoceanmaps to create a similar plot
basemap(limits = 60)
basemap(limits = c(100, 160, -20, 30), bathymetry = TRUE)
basemap(limits = 75, glaciers = TRUE, bathymetry = TRUE)
basemap(limits = c(-160, -80, 60, 85), rotate = TRUE)

# will just use Mikko's package

#glaciers on Svalbard
basemap("Svalbard", glaciers = TRUE)

# Kongsfjorden from Mikko, copied 
KF_1 <- basemap(limits = c(10.9, 12.65, 78.83, 79.12), 
        bathymetry = TRUE, shapefiles = "Svalbard",
        legends = FALSE, glaciers = TRUE)
KF_1

# Kongsfjorden modified to include Krossfjorden
KF_Kross_1 = basemap(limits = c(10.9, 12.65, 78.85, 79.34), 
        bathymetry = TRUE, shapefiles = "Svalbard",
        legends = FALSE, glaciers = TRUE)
KF_Kross_1

# Isfjorden
Isfjorden_1 = basemap(limits = c(12.5, 17.8, 77.93, 78.85), 
        bathymetry = TRUE, shapefiles = "Svalbard",
        legends = FALSE, glaciers = TRUE)
Isfjorden_1

# Baltic Sea
Baltic_1 = basemap(limits = c(12.5, 30, 57, 65),
                   bathymetry = TRUE, shapefiles = "GEBCO", 
                   legends = FALSE)
Baltic_1

#shapefile_list("all")

# points to the maps
dt <- data.frame(lon = c(seq(-180, 0, 30), seq(30, 180, 30)), lat = -70)

basemap(limits = -60, glaciers = TRUE) + 
  geom_spatial_point(data = dt, aes(x = lon, y = lat), color = "red")

# points to the maps using ggplot transformed
basemap(limits = -60, glaciers = TRUE) + 
  geom_point(data = transform_coord(dt), aes(x = lon, y = lat), color = "red")

# Try adding OISST data to Kongsfjorden KF_1

#NOT WORKING
#data_madeup <- load("course_material/data/testset.txt")
#
#SST_KF <- KF_1 + 
#  geom_spatial_point(data = one_dot, aes(x = long, y = lat))


one_dot <- data.frame(lat = 79, long = 11)

KF_2 <- basemap(limits = c(10.9, 12.65, 78.83, 79.12), 
                bathymetry = TRUE, shapefiles = "Svalbard",
                legends = FALSE, glaciers = TRUE) +
  geom_spatial_point(data = one_dot, aes(x = long, y = lat), color = "red")
  
KF_2
# BONUS -------------------------------------------------------------------

# Create a workflow for creating a polar plot for any region
# Add a red bounding box to highlight a region
# And different coloured points to show study sites

