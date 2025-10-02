# lab6


## **Exercise 1: Whale observation (40 min)**

Tidy up the messy `whales` dataset.

``` r
library(tidyverse)
library(knitr)

whales <- read_csv("https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/main/datasets/whales.csv")

whales |>
  head () |>
  kable ()
```

| observer | blue | humpback | southern_right | sei | fin | killer_whale | bowhead | grey |
|---:|:---|:---|:---|:---|:---|:---|:---|:---|
| 1 | 1/20/15, death, , Indian | NA | NA | 8/9/11, injury, , indian | NA | NA | NA | NA |
| 2 | NA | 8/12/15, death, 50, atlantic | NA | NA | 8/2/13, death, 76, arctic | NA | 6/24/13, injury, 30, artic | NA |
| 3 | NA | NA | 7/14/13, injury, 47, pacific | NA | NA | NA | NA | NA |
| 4 | NA | 3/4/12, death, 56, pacific | NA | NA | NA | NA | NA | 5/24/16, death, , pacific |
| 5 | NA | NA | NA | 6/14/12, injury, 52, indian | NA | NA | NA | NA |
| 6 | 5/2/16, , 80, pacific | NA | NA | NA | NA | NA | NA | NA |

#### **Question 1. Create a new data frame that has one row per observer, per species and one single variable of all the information collected. Name this data frame `whales_long`.**

``` r
whales_long <- whales |>
  pivot_longer (-1, names_to="species", values_to="all_the_info")

whales_long |>
  head () |>
  kable ()
```

| observer | species        | all_the_info             |
|---------:|:---------------|:-------------------------|
|        1 | blue           | 1/20/15, death, , Indian |
|        1 | humpback       | NA                       |
|        1 | southern_right | NA                       |
|        1 | sei            | 8/9/11, injury, , indian |
|        1 | fin            | NA                       |
|        1 | killer_whale   | NA                       |

#### **Question 2. Starting from `whales_long`, create another data frame that includes only events for which there is information. Name this data frame `whales_clean`.**

*Hint: `is.na()` might be helpful.*

``` r
whales_clean <- whales_long |>
  filter (!is.na(all_the_info))

whales_clean |>
  head () |>
  kable ()
```

| observer | species        | all_the_info                 |
|---------:|:---------------|:-----------------------------|
|        1 | blue           | 1/20/15, death, , Indian     |
|        1 | sei            | 8/9/11, injury, , indian     |
|        2 | humpback       | 8/12/15, death, 50, atlantic |
|        2 | fin            | 8/2/13, death, 76, arctic    |
|        2 | bowhead        | 6/24/13, injury, 30, artic   |
|        3 | southern_right | 7/14/13, injury, 47, pacific |

#### **Question 3. Starting from `whales_clean`, create another data frame with one variable per type of information, one piece of information per cell. Some cells might be empty. Name this data frame `whales_split`.**

Your new data frame should have six variables: observer, species, date,
outcome, size, ocean.

``` r
whales_split <- whales_clean |>
  separate (all_the_info, c("date", "outcome", "size", "ocean"), ",")
  
whales_split |>
  head () |>
  kable ()
```

| observer | species        | date    | outcome | size | ocean    |
|---------:|:---------------|:--------|:--------|:-----|:---------|
|        1 | blue           | 1/20/15 | death   |      | Indian   |
|        1 | sei            | 8/9/11  | injury  |      | indian   |
|        2 | humpback       | 8/12/15 | death   | 50   | atlantic |
|        2 | fin            | 8/2/13  | death   | 76   | arctic   |
|        2 | bowhead        | 6/24/13 | injury  | 30   | artic    |
|        3 | southern_right | 7/14/13 | injury  | 47   | pacific  |

#### **Question 4. Starting from `whales_split`, create another data frame in which all columns are parsed as instructed below. Name this data frame `whales_parsed`.**

The columns should parsed to the following types  
\* `observer`: double  
\* `species`: character  
\* `date`: date  
\* `outcome`: character  
\* `size`: integer  
\* `ocean`: character

``` r
whales_parsed <- whales_split |>
  type_convert (col_types=cols(date=col_date(format="%m/%d/%y"), size=col_integer()))

whales_parsed |>
  head () |>
  kable ()
```

| observer | species        | date       | outcome | size | ocean    |
|---------:|:---------------|:-----------|:--------|-----:|:---------|
|        1 | blue           | 2015-01-20 | death   |   NA | Indian   |
|        1 | sei            | 2011-08-09 | injury  |   NA | indian   |
|        2 | humpback       | 2015-08-12 | death   |   50 | atlantic |
|        2 | fin            | 2013-08-02 | death   |   76 | arctic   |
|        2 | bowhead        | 2013-06-24 | injury  |   30 | artic    |
|        3 | southern_right | 2013-07-14 | injury  |   47 | pacific  |

#### **Question 5. Using `whales_parsed`, print a summary table with: 1) number ship strikes by species, 2) average whale size by species, omitting NA values in the calculation.**

``` r
whales_parsed |>
  group_by (species) |>
  summarise(number_ship_strikes_by_species = n(), average_whale_size_by_species = mean(size, na.rm=TRUE)) |>
  kable ()
```

| species | number_ship_strikes_by_species | average_whale_size_by_species |
|:---|---:|---:|
| blue | 5 | 67.50000 |
| bowhead | 5 | 43.75000 |
| fin | 4 | 78.50000 |
| grey | 7 | 36.83333 |
| humpback | 7 | 44.33333 |
| killer_whale | 2 | 15.00000 |
| sei | 5 | 54.75000 |
| southern_right | 7 | 47.00000 |

#### 

## **Exercise 2: Baby names (50 min)**

Use data tidying, transformation, and visualization to answer the
following questions about baby names:

``` r
library(babynames)

babynames |>
  head () |>
  kable ()
```

| year | sex | name      |    n |      prop |
|-----:|:----|:----------|-----:|----------:|
| 1880 | F   | Mary      | 7065 | 0.0723836 |
| 1880 | F   | Anna      | 2604 | 0.0266790 |
| 1880 | F   | Emma      | 2003 | 0.0205215 |
| 1880 | F   | Elizabeth | 1939 | 0.0198658 |
| 1880 | F   | Minnie    | 1746 | 0.0178884 |
| 1880 | F   | Margaret  | 1578 | 0.0161672 |
