getwd() # print the current working directory

# Create a vector named 'z' with the values 1 to 200
z <- c(1:200)
z
# Print the mean and standard deviation of z on the console
mean(z) # mean
sd(z) # standard deviation

# Create a logical vector named zlog that is 'TRUE' for z values greater than 30 and 'FALSE' otherwise.
zlog <- z > 30
zlog # print zlog

# Make a dataframe with z and zlog as columns. Name the dataframe zdf
zdf <- data.frame(z = z, zlog = zlog)
zdf # print zdf

# Change the column names in your new dataframe to equal “zvec” and “zlogic”
colnames(zdf) <- c("zvec", "zlogic")

# Make a new column in your dataframe equal to zvec squared (i.e., z2). Call the new column zsquared. 
zdf$zsquared <- zdf$zvec^2
zdf

# Subset the dataframe with and without the subset() function to only include values of zsquared greater than 10 and less than 100
zdf_subset1 <- subset(zdf, zsquared > 10 & zsquared < 100) # with subset function

zdf_subset2 <- zdf[zdf$zsquared > 10 & zdf$zsquared < 100,] # without subset function

# Subset the zdf dataframe to only include the values on row 26
zdf_row_26 <- zdf[26, ]

# Subset the zdf dataframe to only include the values in the column zsquared in the 180th row.
zdf_col_180 <- zdf$zsquared[180]

# Annotate your code, commit the changes, and push it to your GitHub

## Download the Tips.csv file from Canvas. Use the read.csv() function to read the data into R so that the missing values are properly coded. **Note the missing values are reported in the data as a period (i.e., “.”). How do you know the data were read correctly? 
tip <- read.csv("/Users/abdulmalikoladipupo/Downloads/TipsR.csv", na.strings = "." )
