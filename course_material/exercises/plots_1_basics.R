# Script name
# Author
# Date


# Libraries ---------------------------------------------------------------

library(tidyverse)
library(palmerpenguins)
library(ggridges)

# :: after the library name shows what it contains while typing it
#palmerpenguins::

# Data --------------------------------------------------------------------

# Load the dataset into the local environment
penguins <- penguins


# Example -----------------------------------------------------------------

# The basic plot
ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = species))


# Exercise 1 --------------------------------------------------------------

# Create a basic plot with different x and y axes
ggplot(data = penguins,
       aes(x = bill_depth_mm, y = flipper_length_mm)) +
  geom_point(aes(colour = species))


# Exercise 2 --------------------------------------------------------------

# Change the aes() arguments
ggplot(data = penguins,
       aes(x = body_mass_g, y = flipper_length_mm)) +
  geom_point(aes(size = species, shape = island))


# Exercise 3 --------------------------------------------------------------

# Change the labels
ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = species)) +
  labs(x = "Body mass (g)", 
       y = "Bill length (mm)", colour = "Species") +
  # Change legend position
  theme(legend.position = "bottom")


# BONUS -------------------------------------------------------------------

# Create a ridgeplot
ggplot(data = penguins,
       aes(x = body_mass_g, y = species)) +
  geom_density_ridges() +
#  theme_ridges() + #This works too 
  theme_ridges(font_size = 16) + 
  theme(legend.position = "none")


