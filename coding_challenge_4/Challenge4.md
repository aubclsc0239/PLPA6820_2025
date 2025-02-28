[Link to Manuscript](https://doi.org/10.1094/PDIS-06-21-1253-RE)

## Load required packages

``` r
library (tidyverse)
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
library (ggpubr)
library (ggrepel)
library(ggplot2)
```

## Setting color palet

``` r
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
```

## Load the data in

``` r
mycotoxin.data <- read.csv("MycotoxinData.csv", na.strings = "na")                
str (mycotoxin.data)
```

    ## 'data.frame':    375 obs. of  6 variables:
    ##  $ Treatment     : chr  "Fg" "Fg" "Fg" "Fg" ...
    ##  $ Cultivar      : chr  "Wheaton" "Wheaton" "Wheaton" "Wheaton" ...
    ##  $ BioRep        : int  2 2 2 2 2 2 2 2 2 3 ...
    ##  $ MassperSeed_mg: num  10.29 12.8 2.85 6.5 10.18 ...
    ##  $ DON           : num  107.3 32.6 416 211.9 124 ...
    ##  $ X15ADON       : num  3 0.85 3.5 3.1 4.8 3.3 6.9 2.9 2.1 0.71 ...

## Make cultivar and treatment a factor

``` r
mycotoxin.data$Cultivar <- as.factor(mycotoxin.data$Cultivar)       
mycotoxin.data$Treatment <- as.factor(mycotoxin.data$Treatment)
```

## Plot DON against treatment

``` r
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
```

    ## Warning: Removed 8 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 8 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

![](Challenge4_files/figure-gfm/setup-1.png)<!-- -->

## Change the factor order level so that the treatment

``` r
mycotoxin.data$Treatment <- factor(mycotoxin.data$Treatment, levels = c ("NTC", "Fg", "Fg + 37", "Fg + 40", "Fg + 70"))
```

## Plot X15ADON against treatment

``` r
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
```

    ## Warning: Removed 10 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 10 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

![](Challenge4_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

## Plot Massperseed against treatment

``` r
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
```

    ## Warning: Removed 2 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 2 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

![](Challenge4_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

## Perfrom a t-test comparison of treatments

``` r
Plot1 <- don.treatment.1 + 
  geom_pwc(aes(group = Treatment), method = "t_test", label = "p.adj.format")

Plot2 <- don.treatment.2 + 
  geom_pwc(aes(group = Treatment), method = "t_test", label = "p.adj.format")

Plot3 <- don.treatment.3 + 
  geom_pwc(aes(group = Treatment), method = "t_test", label = "p.adj.format")
```

## Stick many the three figures together for a publication ready figure

``` r
Figure_2 <- ggarrange(
  Plot1, 
  Plot2,
  Plot3,
  nrow = 1,
  ncol = 3,
  labels = "auto",
  common.legend = TRUE
)
```

    ## Warning: Removed 8 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 8 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 8 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

    ## Warning: Removed 8 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 8 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 8 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

    ## Warning: Removed 10 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 10 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 10 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

    ## Warning: Removed 2 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 2 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 2 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

``` r
Figure_2
```

![](Challenge4_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->
