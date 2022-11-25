# Script name
# Author
# Date


# Libraries ---------------------------------------------------------------

library(tidyverse)
library(ggpubr)
library(RColorBrewer)
library(palmerpenguins)
library(GGally)


# Data --------------------------------------------------------------------

# Load the dataset into the local environment
penguins <- penguins


# Example -----------------------------------------------------------------

# Discrete viridis colour palette
ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = as.factor(year))) +
  scale_colour_viridis_d(option = "A")

# Compare species
ggplot(data = penguins, aes(x = species, y = bill_length_mm)) +
  geom_boxplot(aes(fill = species), show.legend = F) +
  stat_compare_means(method = "anova")


# Exercise 1 --------------------------------------------------------------

# Create your own continuous and discrete colour palettes

#continous
ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = bill_depth_mm)) +
  scale_colour_gradientn(colours = c("#21313E","#20575F","#268073",
                                     "#53A976","#98CF6F","#EFEE69"))

ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = bill_depth_mm)) +
  scale_colour_gradientn(colours = c("#CD3B70","#A5589A","#6870A9",
                                     "#2B7C9B","#23807E","#497F60"))

#discrete
ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = as.factor(sex))) +
  # How to use custom palette
  scale_colour_manual(values = c("#d16a0c", "#df3ad2"),
                      # How to change the legend text
                      labels = c("female", "male", "unknown")) + 
  # How to change the legend title
  labs(colour = "Sex")
#["#d16a0c",
#  "#6e7bdd",
#  "#4a8c72",
#  "#651fba",
#  "#df3ad2"]

# Create and combine two figures, each using a different palette
contpenguin <-ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = bill_depth_mm)) +
  scale_colour_gradientn(colours = c("#CD3B70","#A5589A","#6870A9",
                                     "#2B7C9B","#23807E","#497F60"))
contpenguin

#discrete
discretepenguin <- ggplot(data = penguins,
       aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = as.factor(sex))) +
  # How to use custom palette
  scale_colour_manual(values = c("#d16a0c", "#df3ad2"),
                      # How to change the legend text
                      labels = c("female", "male", "unknown")) + 
  # How to change the legend title
  labs(colour = "Sex")
discretepenguin

penguin_plot2 <- ggarrange(contpenguin, discretepenguin,
                          # Set number of rows and columns
                          ncol = 2, nrow = 1,
                          # Label each figure
                          labels = c("a)", "b)"),
                          # Create common legend
                          common.legend = TRUE,
                          # Set legend position
                          legend = "bottom")
penguin_plot2

# Exercise 2 --------------------------------------------------------------

# Create two versions of the same figure and combine
# Use a viridis colour palette against a default palette in a way that 
# allows features in the data to be more pronounced
virpenguin <-ggplot(data = penguins,
                     aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = bill_depth_mm)) +
  # Viridis colour palette
  scale_colour_viridis_c(option = "B")
virpenguin

standardpenguin <-ggplot(data = penguins,
                     aes(x = body_mass_g, y = bill_length_mm)) +
  geom_point(aes(colour = bill_depth_mm))
standardpenguin

# Combined
penguin_plot2 <- ggarrange(virpenguin, standardpenguin)
penguin_plot2
                           
# Exercise 3 --------------------------------------------------------------

# Plot and combine t-test and ANOVA stats using sst_NOAA
# See this site for more info on plotting stats:
# http://www.sthda.com/english/articles/24-ggpubr-publication-ready-plots/76-add-p-values-and-significance-levels-to-ggplots/
sst_NOAA_standard <- read_csv2("course_material/data/sst_NOAA_standard.csv")
sst_NOAA_R <- read_delim("course_material/data/sst_NOAA_R.csv", delim = ";")
sst_NOAA <- read_csv("course_material/data/sst_NOAA.csv")

# shows the first 6 lines
head(sst_NOAA)
# shows the last 2 lines
tail(sst_NOAA, 2)

# quick summaries
glimpse(sst_NOAA)
summary(sst_NOAA)

# t-test
compare_means(bill_length_mm~species, data = penguins, method = "t.test")

# ANOVA
compare_means(bill_length_mm~species, data = penguins, method = "anova")

ggplot(data = penguins, aes(x = species, y = bill_length_mm)) +
  geom_boxplot(aes(fill = species), show.legend = F) +
  stat_compare_means(method = "anova")

ggplot(data = penguins, aes(x = species, y = bill_length_mm)) +
  geom_boxplot(aes(fill = species), show.legend = F) +
  stat_compare_means(method = "anova", 
                     aes(label = paste0("p ", ..p.format..)), 
                     label.x = 2) +
  theme_bw()

# Multiple means
# First create a list of comparisons to feed into our figure
penguins_levels <- levels(penguins$species)
my_comparisons <- list(c(penguins_levels[1], penguins_levels[2]), 
                       c(penguins_levels[2], penguins_levels[3]),
                       c(penguins_levels[1], penguins_levels[3]))

# Then we stack it all together
ggplot(data = penguins, aes(x = species, y = bill_length_mm)) +
  geom_boxplot(aes(fill  = species), colour = "grey40", show.legend = F) +
  stat_compare_means(method = "anova", colour = "grey50",
                     label.x = 1.8, label.y = 32) +
  # Add pairwise comparisons p-value
  stat_compare_means(comparisons = my_comparisons,
                     label.y = c(62, 64, 66)) +
  # Perform t-tests between each group and the overall mean
  stat_compare_means(label = "p.signif", 
                     method = "t.test",
                     ref.group = ".all.") + 
  # Add horizontal line at base mean
  geom_hline(yintercept = mean(penguins$bill_length_mm, na.rm = T), 
             linetype = 2) + 
  labs(y = "Bill length (mm)", x = NULL) +
  theme_bw()

# BONUS -------------------------------------------------------------------

# Create a correlogram


ggpairs(sst_NOAA) 


