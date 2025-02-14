####


#### Q2 ####
# Make a boxplot using ggplot with DON as the y variable, treatment as the x variable, and color mapped to the wheat cultivar. 
# Show the code you use to load the libraries you need to read in the data and make the plot. 
# Change the y label to “DON (ppm)” and make the x label blank.

# read in the data ensuring data are matches to appropiate classes
toxin_data <- read.csv("/Users/abdulmalikoladipupo/Downloads/PLPA6280/PLPA6820_2025/MycotoxinData.csv", 
                       header = TRUE, na.strings = "na",
                       colClasses =  c("character","character", "numeric", "numeric", "numeric"))

str(toxin_data)

# load ggPlot2
library ("ggplot2")

# make box plot
myPlot_box <- ggplot(toxin_data, aes(x = Treatment, y = DON, color = Cultivar)) +
  geom_boxplot() +
  ylab("DON(ppm)") + # change y-axis naming
  xlab("")

#Q3.	
# 2 pts. Now convert this data into a bar chart with standard-error error bars using the stat_summary() command.
# make my plot

myPlot_bar <- ggplot(toxin_data, aes(x = Treatment, y = DON, color = Cultivar)) +
  stat_summary(fun=mean,geom="bar", position = "dodge") +
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge") + 
  ylab("DON(ppm)") +
  xlab("")


#Q4.
# Add points to the foreground of the boxplot and bar chart you made in question 3 that show the distribution of points over the boxplots. 
# Set the shape = 21 and the outline color black (hint: use jitter_dodge). 

#
myPlot_box <- ggplot(toxin_data, aes(x = Treatment, y = DON, color = Cultivar)) +
  ylab("DON(ppm)") +
  xlab("") +
  geom_boxplot() +
  geom_point(aes(fill = Cultivar), 
             position=position_jitterdodge(dodge.width=0.9, jitter.width = 0.2),
             shape = 21, # set shape
             color = "black") # point outline color
  
myPlot_bar <- ggplot(toxin_data, aes(x = Treatment, y = DON, color = Cultivar)) +
  stat_summary(fun=mean,geom="bar", position = "dodge") +
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge") + 
  ylab("DON(ppm)") +
  xlab("") +
  geom_point(aes(fill = Cultivar), 
             position=position_jitterdodge(dodge.width=1.0),
             shape = 21, # set shape
             color = "black") # point outline color

#Q5
# Change the fill color of the points and boxplots to match some colors in the following colorblind pallet. 

cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7") # set color pallet

myPlot_box <- ggplot(toxin_data, aes(x = Treatment, y = DON, fill = Cultivar)) +
  geom_boxplot() +
  ylab("DON(ppm)") +
  xlab("") +
  geom_point(aes(fill = Cultivar), 
             position=position_jitterdodge(dodge.width=0.9),
             shape = 21, 
             color = "black") +
  scale_color_manual(values = cbbPalette)


myPlot_bar <- ggplot(toxin_data, aes(x = Treatment, y = DON, fill = Cultivar)) +
  stat_summary(fun=mean,geom="bar", position = "dodge", color = "black") +
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge") + 
  ylab("DON(ppm)") +
  xlab("") +
  geom_point(aes(fill = Cultivar), 
             position=position_jitterdodge(dodge.width=1.0),
             shape = 21, 
             color = "black") +
  scale_color_manual(values = cbbPalette)


# Q6
# Add a facet to the plots based on cultivar.

# box plot
myPlot_box <- ggplot(toxin_data, aes(x = Treatment, y = DON, fill = Cultivar)) +
  geom_boxplot() +
  ylab("DON(ppm)") +
  xlab("") +
  geom_point(aes(fill = Cultivar), 
             position=position_jitterdodge(dodge.width=0.9),
             shape = 21, 
             color = "black") +
  scale_color_manual(values = cbbPalette) +
  facet_wrap(~Cultivar) # split data into different Cultivar

# bar plot
myPlot_bar <- ggplot(toxin_data, aes(x = Treatment, y = DON, fill = Cultivar)) +
  stat_summary(fun=mean,geom="bar", position = "dodge", color = "black") +
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge") + 
  ylab("DON(ppm)") +
  xlab("") +
  geom_point(aes(fill = Cultivar), 
             position=position_jitterdodge(dodge.width=1.0),
             shape = 21, 
             color = "black") +
  scale_color_manual(values = cbbPalette) +
  facet_wrap(~Cultivar)

# Q7
# Add transparency to the points so you can still see the boxplot or bar in the background.
myPlot_box <- ggplot(toxin_data, aes(x = Treatment, y = DON, fill = Cultivar)) +
  geom_boxplot() +
  ylab("DON(ppm)") +
  xlab("") +
  geom_point(aes(fill = Cultivar), 
             position=position_jitterdodge(dodge.width=0.9),
             shape = 21,
             alpha = 0.4, # increase point transparency
             color = "black") +
  scale_color_manual(values = cbbPalette) +
  facet_wrap(~Cultivar)


myPlot_bar <- ggplot(toxin_data, aes(x = Treatment, y = DON, fill = Cultivar)) +
  stat_summary(fun=mean,geom="bar", position = "dodge", color = "black") +
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge") + 
  ylab("DON(ppm)") +
  xlab("") +
  geom_point(aes(fill = Cultivar), 
             position=position_jitterdodge(dodge.width=1.0),
             shape = 21,
             alpha = 0.4,
             color = "black") +
  scale_color_manual(values = cbbPalette) +
  facet_wrap(~Cultivar)


#Q8.	
#Explore one other way to represent the same data https://ggplot2.tidyverse.org/reference/ . 
#Plot them and show the code here. Which one would you choose to represent your data and why? 

# create a line plot
myPlot_bar <- ggplot(toxin_data, aes(x = Treatment, y = DON, group = Cultivar, color = Cultivar)) +
  stat_summary(fun=mean,geom="line") +
  stat_summary(fun.data = mean_se, geom = "errorbar") + 
  ylab("DON(ppm)") +
  xlab("")

#Q9
#Annotate your code and push it to github. Now, find a partner if you don’t already have one and have that person “fork” the repository containing the code you just pushed to github. 
#Describe what just happened when you “forked” the repository.  
# Please include the links (URLs) below to answer this question. 















