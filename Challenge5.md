## Question 1 & 2

Download two .csv files from Canvas called DiversityData.csv and
Metadata.csv, and read them into R using relative file paths.

``` r
diversity <- read.csv("DiversityData.csv", na.strings = "na") # read data into r
metadata <- read.csv("Metadata.csv", na.strings = "na") # read data into r

str(diversity)
```

    ## 'data.frame':    70 obs. of  5 variables:
    ##  $ Code      : chr  "S01_13" "S02_16" "S03_19" "S04_22" ...
    ##  $ shannon   : num  6.62 6.61 6.66 6.66 6.61 ...
    ##  $ invsimpson: num  211 207 213 205 200 ...
    ##  $ simpson   : num  0.995 0.995 0.995 0.995 0.995 ...
    ##  $ richness  : int  3319 3079 3935 3922 3196 3481 3250 3170 3657 3177 ...

``` r
str(metadata)
```

    ## 'data.frame':    70 obs. of  5 variables:
    ##  $ Code         : chr  "S01_13" "S02_16" "S03_19" "S04_22" ...
    ##  $ Crop         : chr  "Soil" "Soil" "Soil" "Soil" ...
    ##  $ Time_Point   : int  0 0 0 0 0 0 6 6 6 6 ...
    ##  $ Replicate    : int  1 2 3 4 5 6 1 2 3 4 ...
    ##  $ Water_Imbibed: num  NA NA NA NA NA NA NA NA NA NA ...

## Quenstion 2

Join the two dataframes together by the common column ‘Code’. Name the
resulting dataframe alpha.

``` r
library(tidyverse)
```

    ## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.1.4     ✔ readr     2.1.5
    ## ✔ forcats   1.0.0     ✔ stringr   1.5.1
    ## ✔ ggplot2   3.5.1     ✔ tibble    3.2.1
    ## ✔ lubridate 1.9.4     ✔ tidyr     1.3.1
    ## ✔ purrr     1.0.4     
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
head(diversity)
```

    ##     Code  shannon invsimpson   simpson richness
    ## 1 S01_13 6.624921   210.7279 0.9952545     3319
    ## 2 S02_16 6.612413   206.8666 0.9951660     3079
    ## 3 S03_19 6.660853   213.0184 0.9953056     3935
    ## 4 S04_22 6.660671   204.6908 0.9951146     3922
    ## 5 S05_25 6.610965   200.2552 0.9950064     3196
    ## 6 S06_28 6.650812   199.3211 0.9949830     3481

``` r
head(metadata)
```

    ##     Code Crop Time_Point Replicate Water_Imbibed
    ## 1 S01_13 Soil          0         1            NA
    ## 2 S02_16 Soil          0         2            NA
    ## 3 S03_19 Soil          0         3            NA
    ## 4 S04_22 Soil          0         4            NA
    ## 5 S05_25 Soil          0         5            NA
    ## 6 S06_28 Soil          0         6            NA

``` r
alpha <- (left_join(diversity, metadata, by = "Code")) # joining both data 
head(alpha)
```

    ##     Code  shannon invsimpson   simpson richness Crop Time_Point Replicate
    ## 1 S01_13 6.624921   210.7279 0.9952545     3319 Soil          0         1
    ## 2 S02_16 6.612413   206.8666 0.9951660     3079 Soil          0         2
    ## 3 S03_19 6.660853   213.0184 0.9953056     3935 Soil          0         3
    ## 4 S04_22 6.660671   204.6908 0.9951146     3922 Soil          0         4
    ## 5 S05_25 6.610965   200.2552 0.9950064     3196 Soil          0         5
    ## 6 S06_28 6.650812   199.3211 0.9949830     3481 Soil          0         6
    ##   Water_Imbibed
    ## 1            NA
    ## 2            NA
    ## 3            NA
    ## 4            NA
    ## 5            NA
    ## 6            NA

## Question 3

Calculate Pielou’s evenness index: Pielou’s evenness is an ecological
parameter calculated by the Shannon diversity index (column Shannon)
divided by the log of the richness column. a. Using mutate, create a new
column to calculate Pielou’s evenness index. b. Name the resulting
dataframe alpha_even.

``` r
# Create a new column called evenness

alpha_even <- mutate(alpha, evenness = shannon / log(richness)) # calculating evenness index
head(alpha_even)
```

    ##     Code  shannon invsimpson   simpson richness Crop Time_Point Replicate
    ## 1 S01_13 6.624921   210.7279 0.9952545     3319 Soil          0         1
    ## 2 S02_16 6.612413   206.8666 0.9951660     3079 Soil          0         2
    ## 3 S03_19 6.660853   213.0184 0.9953056     3935 Soil          0         3
    ## 4 S04_22 6.660671   204.6908 0.9951146     3922 Soil          0         4
    ## 5 S05_25 6.610965   200.2552 0.9950064     3196 Soil          0         5
    ## 6 S06_28 6.650812   199.3211 0.9949830     3481 Soil          0         6
    ##   Water_Imbibed  evenness
    ## 1            NA 0.8171431
    ## 2            NA 0.8232216
    ## 3            NA 0.8046776
    ## 4            NA 0.8049774
    ## 5            NA 0.8192376
    ## 6            NA 0.8155427

## Question 4

Using tidyverse language of functions and the pipe, use the summarise
function and tell me the mean and standard error evenness grouped by
crop over time.

1.  Start with the alpha_even dataframe
2.  Group the data: group the data by Crop and Time_Point.
3.  Summarize the data: Calculate the mean, count, standard deviation,
    and standard error for the even variable within each group.
4.  Name the resulting dataframe alpha_average

``` r
alpha_average <- alpha_even %>%
  group_by(Crop, Time_Point) %>% # grouping data by Crop and Time_Point
  summarise(Mean.even = mean(evenness), # calculating the mean richness, stdeviation, and standard error
            n = n(), # count
            sd.dv = sd(evenness)) %>% # standard deviation
  mutate(stnd.err = sd.dv/sqrt(n)) # standard error
```

    ## `summarise()` has grouped output by 'Crop'. You can override using the
    ## `.groups` argument.

## Question 5

Calculate the difference between the soybean column, the soil column,
and the difference between the cotton column and the soil column a.
Start with the alpha_average dataframe b. Select relevant columns:
select the columns Time_Point, Crop, and mean.even. c. Reshape the data:
Use the pivot_wider function to transform the data from long to wide
format, creating new columns for each Crop with values from mean.even.
d. Calculate differences: Create new columns named diff.cotton.even and
diff.soybean.even by calculating the difference between Soil and Cotton,
and Soil and Soybean, respectively. e. Name the resulting dataframe
alpha_average2

``` r
alpha_average2 <- alpha_average %>%
  select(Time_Point, Crop, Mean.even) %>%
  pivot_wider(names_from = Crop, values_from = Mean.even) %>% # transform data to wide format
  mutate(diff.cotton.even = Soil - Cotton) %>% # find differences in soil and cotton
  mutate(diff.soybean.even = Soil - Soybean) # find differences in soil and soybean
```

## Question 6

Connecting it to plots a. Start with the alpha_average2 dataframe b.
Select relevant columns: select the columns Time_Point,
diff.cotton.even, and diff.soybean.even. c. Reshape the data: Use the
pivot_longer function to transform the data from wide to long format,
creating a new column named diff that contains the values from
diff.cotton.even and diff.soybean.even. i. This might be challenging, so
I’ll give you a break. The code is below.

pivot_longer(c(diff.cotton.even, diff.soybean.even), names_to = “diff”)

4.  Create the plot: Use ggplot and geom_line() with ‘Time_Point’ on the
    x-axis, the column ‘values’ on the y-axis, and different colors for
    each ‘diff’ category. The column named ‘values’ come from the
    pivot_longer. The resulting plot should look like the one to the
    right.

``` r
alpha_average2 %>%
  select(Time_Point, diff.cotton.even, diff.soybean.even) %>% # select the needed variable
  pivot_longer(c(diff.cotton.even, diff.soybean.even), names_to = "diff") %>% # transform to long format
  ggplot(aes(x = Time_Point, y = value, color = diff)) +
  geom_line() +
  theme_classic() +
  xlab("Time (hrs)") +
  ylab("Difference from Soil in Pielou's evenness")
```

![](Challenge5_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

## Question 7

Commit and push a gfm .md file to GitHub inside a directory called
Coding Challenge 5. Provide me a link to your github written as a
clickable link in your .pdf or .docx
