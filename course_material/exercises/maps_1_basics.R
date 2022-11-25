# Script name
# Author
# Date


# Libraries ---------------------------------------------------------------
library(tidyverse)
library(ggsn)
library(ggpubr)aa
library(palmerpenguins)

# Which libraries should be loaded?
library(maps)


# Data --------------------------------------------------------------------

# Call the global data to the environment
map_data_world <- map_data("world")


# Example -----------------------------------------------------------------

# The basic map
map_data_world %>% 
  filter(region == "Germany") %>% 
  ggplot(aes(x = long, y = lat)) +
  geom_polygon(aes(group = group))


# Exercise 1 --------------------------------------------------------------

# Create maps of four regions and combine
earth_1 <- ggplot() +
  borders(fill = "grey70", colour = "black") + # The global shape file
  coord_equal() # Equal sizing for lon/lat 
earth_1

green_1 <- ggplot() +
  borders(fill = "grey70", colour = "black") +
  coord_equal(xlim = c(-75, -10), ylim = c(58, 85)) # Force lon/lat extent
green_1

# shows possible areas
map_data('world') %>% 
  select(region) %>% 
  distinct() %>% 
  arrange(region)

map_data_green <- map_data('world') %>% 
  filter(region == "Greenland") # Why '==' and not '='?
head(map_data_green)

green_2 <- ggplot(data = map_data_green, aes(x = long, y = lat)) +
  geom_polygon(aes(group = group), # What is this doing?
               fill = "chartreuse4", colour = "black") # Note these are outside of aes() 
green_2

map_data_curacao <- map_data('world') %>% 
  filter(region == "Curacao") # Why '==' and not '='?
head(map_data_curacao)

curacao_1 <- ggplot(data = map_data_curacao, aes(x = long, y = lat)) +
  geom_polygon(aes(group = group), # What is this doing?
               fill = "cyan", colour = "black") # Note these are outside of aes() 
curacao_1

# does the combination
fourmaps_plot <- ggarrange(earth_1, green_1, green_2, curacao_1,
                          # Set number of rows and columns
                          ncol = 2, nrow = 2,
                          # Label each figure
                          labels = c("a) Earth", "b) Greenland", "c) Greenland", "d) Curacao"),
                          # Create common legend
                          common.legend = TRUE,
                          # Set legend position
                          legend = "bottom")
fourmaps_plot

# Use a mix of cropping and direct access 


# Exercise 2 --------------------------------------------------------------

# Create a map that benefits from a scale bar and add a North arrow
# Hint: use annotate("segment", ...) to accomplish this

northSymbols() # shows the possible symbols, 6 looks okay and 11 and 16

green_3 <- green_2 +
#  annotate("text", label = "Greenland", 
#           x = -40, y = 75.0, size = 7.0, fontface = "bold.italic") +
#  annotate("text", label = "North\nAtlantic\nOcean", 
#           x = -20, y = 64.0, size = 5.0,  angle = 330, colour = "navy") +
#  annotate("label", label = "Baffin\nBay", 
#           x = -62, y = 70, size = 5.0, fill = "springgreen") +
#  annotate("segment", 
#           x = -72, xend = -72, y = 80, yend = 83) +
  north(data = map_data_green, location = "topleft", scale = 0.1, symbol = 6)
green_3

green_4 <- green_3 +
  scalebar(data = map_data_green, location = "topright", # Set location of bar,
           dist = 500, dist_unit = "km", transform = TRUE, # Size of scale bar
           st.size = 4, height = 0.03, st.dist = 0.04) # Set particulars
green_4

# Exercise 3 --------------------------------------------------------------

# Create a meaningful inset map, Sarina instructed about subregions, but don't find them by myself
map_data_Svalbard <- map_data('world') %>% 
  filter(region == "Norway" & subregion == "Svalbard") # Why '==' and not '='?
head(map_data_Svalbard)

svalbard_plot_1 <- ggplot(map_data_Svalbard, aes(x = long, y = lat)) +
  geom_polygon(aes(group = group),
               fill = "red", colour = "grey")
svalbard_plot_1

# The actual inset then

Kongsfjorden_within <- svalbard_plot_1 + 
  geom_rect(aes(xmin = 11, xmax = 13, ymin = 78.8, ymax = 79.35),
            fill = NA, colour = "black") +
  theme_void() # What does this do?
Kongsfjorden_within

Kongsfjorden_plot <- ggplot() +
  borders(fill = "grey70", colour = "black") +
  coord_equal(xlim = c(11.2, 12.5), ylim = c(78.85, 79.35)) # Force lon/lat extent
Kongsfjorden_plot

svalbard_with_KFinset <- Kongsfjorden_within +
  annotation_custom(grob = ggplotGrob(Kongsfjorden_plot), # Convert the earth plot to a grob
                    xmin = 18, xmax = 33,
                    ymin = 74, ymax = 77) +
  annotate("segment", 
         x = 13, xend = 32.8, y = 79.35, yend = 76.3)
svalbard_with_KFinset

geom_line

# BONUS -------------------------------------------------------------------

# Plot maps using Google Maps

