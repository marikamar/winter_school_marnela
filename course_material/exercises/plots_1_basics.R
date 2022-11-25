# Script name
# Author
# Date


# Libraries ---------------------------------------------------------------

library(tidyverse)
library(palmerpenguins)
library(ggridges)


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
       aes(x = bill_depth_mm, y = flipper_length_mm)) +
  geom_point(aes(size = bill_length_mm, shape = island))


# Exercise 3 --------------------------------------------------------------

# Change the labels
ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = species)) +
  labs(x = "Body mass (g)", y = "Bill length (mm)", colour = "Species") +
  # Change legend position
  theme(legend.position = "bottom")


# BONUS -------------------------------------------------------------------

# Create a ridgeplot
ggplot(data = penguins,
       aes(x = body_mass_g, y = species)) +
  geom_density_ridges() +
  theme_ridges() + 
  theme(legend.position = "none")


