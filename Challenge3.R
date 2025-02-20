library (tidyverse)
library (ggpubr)
library (ggrepel)

# load the color palet
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

#1
# Using ggplot, create a boxplot of DON by Treatment so that the plot looks like the image below.

# load the data in
mycotoxin.data <- read.csv("/Users/abdulmalikoladipupo/Downloads/PLPA6280/PLPA6820_2025/MycotoxinData.csv", na.strings = "na")                
str (mycotoxin.data)

# make cultivar and treatment a factor
mycotoxin.data$Cultivar <- as.factor(mycotoxin.data$Cultivar)       
mycotoxin.data$Treatment <- as.factor(mycotoxin.data$Treatment)

# Plot DON against treatment 
don.treatment.1 <- ggplot (mycotoxin.data, aes(x = Treatment, y = DON, fill = Cultivar)) +
  geom_boxplot(position = "dodge") +
  #geom_point(position = position_jitterdodge(0.6)) +
  geom_jitter(pch = 21, position = position_jitterdodge(), color = "black") +
  xlab("") +
  ylab("DON(ppm)") +
  scale_fill_manual(values = c(cbbPalette[[3]], cbbPalette[[4]])) +
  theme_classic() + 
  facet_wrap(~Cultivar, scales = "free")
don.treatment.1

# Q2
# Change the factor order level so that the treatment “NTC” is first, followed by “Fg”, “Fg + 37”, “Fg + 40”, and “Fg + 70. 

mycotoxin.data$Treatment <- factor(mycotoxin.data$Treatment, levels = c ("NTC", "Fg", "Fg + 37", "Fg + 40", "Fg + 70"))

# Q3
# Change the y-variable to plot X15ADON and MassperSeed_mg. 
# The y-axis label should now be “15ADON” and “Seed Mass (mg)”. 
# Save plots made in questions 1 and 3 into three separate R objects.

# Plot X15ADON against treatment 
don.treatment.2 <- ggplot (mycotoxin.data, aes(x = Treatment, y = X15ADON, fill = Cultivar)) +
  geom_boxplot(position = "dodge") +
  #geom_point(position = position_jitterdodge(0.6)) +
  geom_jitter(pch = 21, position = position_jitterdodge(), color = "black") +
  xlab("") +
  ylab("15ADON") +
  scale_fill_manual(values = c(cbbPalette[[3]], cbbPalette[[4]])) +
  theme_classic() + 
  facet_wrap(~Cultivar, scales = "free")
don.treatment.2

# Plot Massperseed against treatment 
don.treatment.3 <- ggplot (mycotoxin.data, aes(x = Treatment, y = MassperSeed_mg, fill = Cultivar)) +
  geom_boxplot(position = "dodge") +
  #geom_point(position = position_jitterdodge(0.6)) +
  geom_jitter(pch = 21, position = position_jitterdodge(), color = "black") +
  xlab("") +
  ylab("Seed Mass (mg)") +
  scale_fill_manual(values = c(cbbPalette[[3]], cbbPalette[[4]])) +
  theme_classic() + 
  facet_wrap(~Cultivar, scales = "free")
don.treatment.3


# Q4
# Use ggarrange function to combine all three figures into one with three columns and one row. 
# Set the labels for the subplots as A, B and C. Set the option common.legend = T within ggarage function. 
# What did the common.legend option do?
# HINT: I didn’t specifically cover this in the tutorial, but you can go to the help page for the ggarange function to figure out what the common.legend option does and how to control it. 

# Stick many figures together for a publication ready figure
Figure_1 <- ggarrange(
  don.treatment.1, 
  don.treatment.2,
  don.treatment.3,
  nrow = 1,
  ncol = 3,
  labels = "auto",
  common.legend = TRUE
)
Figure_1

# the common legend placed a single legend for all the plot o the saved figure

# Use geom_pwc() to add t.test pairwise comparisons to the three plots made above. 
# Save each plot as a new R object, and combine them again with ggarange as you did in question 4. 

# perfrom a t-test comparison of treatments
Plot1 <- don.treatment.1 + 
  geom_pwc(aes(group = Treatment), method = "t_test", label = "p.adj.format")

Plot2 <- don.treatment.2 + 
  geom_pwc(aes(group = Treatment), method = "t_test", label = "p.adj.format")

Plot3 <- don.treatment.3 + 
  geom_pwc(aes(group = Treatment), method = "t_test", label = "p.adj.format")
Plot3

# save new objects into a pulication ready figure
Figure_2 <- ggarrange(
  Plot1, 
  Plot2,
  Plot3,
  nrow = 1,
  ncol = 3,
  labels = "auto",
  common.legend = TRUE
)
Figure_2





