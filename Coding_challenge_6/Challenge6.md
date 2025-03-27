## Question 1

Regarding reproducibility, what is the main point of writing your own
functions and iterations?

## Question 2.

In your own words, describe how to write a function and a for loop in R
and how they work. Give me specifics like syntax, where to write code,
and how the results are returned.

## Question 3.

Read in the Cities.csv file from Canvas using a relative file path.

``` r
cities <- read.csv("Cities.csv")
```

## Question 4.

Write a function to calculate the distance between two pairs of
coordinates based on the Haversine formula (see below). The input into
the function should be lat1, lon1, lat2, and lon2. The function should
return the object distance_km. All the code below needs to go into the
function.

``` r
dist.coord <- function(lat1, lon1, lat2, lon2){
  rad.lat1 <- lat1 * pi/180 # convert to radians
  rad.lon1 <- lon1 * pi/180 # convert to radians
  rad.lat2 <- lat2 * pi/180 # convert to radians
  rad.lon2 <- lon2 * pi/180 # convert to radians
  
  # Haversine formula
  delta_lat <- rad.lat2 - rad.lat1
  delta_lon <- rad.lon2 - rad.lon1
  a <- sin(delta_lat / 2)^2 + cos(rad.lat1) * cos(rad.lat2) * sin(delta_lon / 2)^2
  c <- 2 * asin(sqrt(a)) 
  
  # Earth's radius in kilometers
  earth_radius <- 6378137
  
  # Calculate the distance
  distance_km <- (earth_radius * c)/1000

  return(distance_km)
}
```

## Question 5

Using your function, compute the distance between Auburn, AL and New
York City a. Subset/filter the Cities.csv data to include only the
latitude and longitude values you need and input as input to your
function. b. The output of your function should be 1367.854 km

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
# subset city
Auburn <- cities %>% filter(city == "Auburn")
New_York <- cities %>% filter(city == "New York")

# Extract the lat/lon values
lat1 <- Auburn$lat
lon1 <- Auburn$long
lat2 <- New_York$lat
lon2 <- New_York$long

# run function
dist.coord(lat1, lon1, lat2, lon2)
```

    ## [1] 1367.854

## Question 6

Now, use your function within a for loop to calculate the distance
between all other cities in the data. The output of the first 9
iterations is shown below.

``` r
# I created an empty data frame to store results, also stated variable type
distance_df <- data.frame(
  city1 = character(),
  city2 = character(),
  Distance_km = numeric(),
  stringsAsFactors = FALSE
)

# Loop through each city and compute distance from Auburn 
for (i in 1:nrow(cities)) {
  lat2 <- cities$lat[i]
  lon2 <- cities$long[i]
  city1 <- cities$city[i]
  
  dist_km <- dist.coord(lat1, lon1, lat2, lon2) # run the function
  
  # Append a new row for each city, city2 and distances
  distance_df <- rbind(
    distance_df,
    data.frame(City1 = city1, City2 = "Auburn", Distance_km = dist_km)
  )
}

# View first 6 results
head(distance_df, 6)
```

    ##         City1  City2 Distance_km
    ## 1    New York Auburn   1367.8540
    ## 2 Los Angeles Auburn   3051.8382
    ## 3     Chicago Auburn   1045.5213
    ## 4       Miami Auburn    916.4138
    ## 5     Houston Auburn    993.0298
    ## 6      Dallas Auburn   1056.0217

[link to
Github_Challenge6](https://github.com/aubclsc0239/PLPA6820_2025/tree/main/Coding_challenge_6)
