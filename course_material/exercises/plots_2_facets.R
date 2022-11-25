# Script name
# Author
# Date


# Libraries ---------------------------------------------------------------

library(tidyverse)
library(ggpubr)
library(palmerpenguins)
library(gridExtra)


# Data --------------------------------------------------------------------

# Load the dataset into the local environment
penguins <- penguins


# Example -----------------------------------------------------------------

# Basic faceted plot
lm_1 <- ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm, colour = species)) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap(~species)
lm_1

# Basic combined plot
ggarrange(lm_1, lm_1)


# Exercise 1 --------------------------------------------------------------

# Create a new plot type and facet by gender
lm_2 <- ggplot(data = penguins,
               aes(x = body_mass_g, y = bill_length_mm, colour = sex)) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap(~species)
lm_2

# Exercise 2 --------------------------------------------------------------

# Create a new plot type and facet by two categories
lm_3 <- ggplot(data = penguins,
               aes(x = body_mass_g, y = flipper_length_mm, colour = sex)) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap(~species)
lm_3


# histogram ---------------------------------------------------------------

histogram_1 <- ggplot(data = penguins, 
                      # NB: There is no y-axis value for histograms
                      aes(x = body_mass_g)) + 
  geom_histogram(aes(fill = species), position = "stack", binwidth = 250) +
  # NB: We use 'fill' here rather than 'colour'
  labs(x = "Body mass (g)", fill = "Species")
histogram_1


# Boxplot -----------------------------------------------------------------

box_1 <- ggplot(data = penguins, 
                # Why 'as.factor()'?
                aes(x = as.factor(year),
                    y = body_mass_g)) + 
  geom_boxplot(aes(fill = species)) +
  labs(x = "Year", y = "Body mass (g)", fill = "Species") 
box_1

# Exercise 3 --------------------------------------------------------------

# Combine all of the plots you've created so far
#penguin_plot <- ggarrange(lm_1, lm_2, lm_3)
penguin_plot <- ggarrange(lm_1, lm_1, histogram_1, box_1,
                    # Set number of rows and columns
                    ncol = 2, nrow = 2,
                    # Label each figure
                    labels = c("a)", "b)", "c)", "d)"),
                    # Create common legend
                    common.legend = TRUE,
                    # Set legend position
                    legend = "bottom")
penguin_plot


# Save them as a high-res file larger than 2 MB
ggsave(plot = penguin_plot, filename = "penguins_3_in_one_plot.png")

# Change dimensions
ggsave(plot = penguin_plot, filename = "penguins_3_in_one_plot.png", 
       width = 20, height = 14)
 
# Change DPI
ggsave(plot = penguin_plot, filename = "penguins_3_in_one_plot.png", dpi = 2000)


# BONUS -------------------------------------------------------------------

# Use a different package to combine plots

penguin_plot_nice <- grid.arrange(lm_1, lm_2, lm_3, nrow=3)

# Save them as a high-res file larger than 2 MB
ggsave(plot = penguin_plot_nice, filename = "penguins_3_in_one_plot_nicer.png")

# Change dimensions
ggsave(plot = penguin_plot_nice, filename = "penguins_3_in_one_plot_nicer.png", 
       width = 20, height = 14)

# Change DPI
ggsave(plot = penguin_plot_nice, filename = "penguins_3_in_one_plot_nicer.png", dpi = 2000)

