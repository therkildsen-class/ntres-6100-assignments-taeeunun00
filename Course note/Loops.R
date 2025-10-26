library(tidyverse)
library(gapminder)

est <- read_csv('https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/countries_estimated.csv')
gapminder_set <- gapminder |>
  left_join(est)

cntry <- "Belgium"
country_list <- c("Albania", "Canada", "Spain")

dir.create("figures")
dir.create("figures/europe")

country_list <- unique(gapminder$country)

gap_europe <- gapminder |>
  filter(continent == "Europe") |>
  mutate(gdp_tot = gdp_per_cap * pop)

country_list <- unique(gap_europe$country)

length(country_list)

for (cntry in country_list) {

print(str_c("Plotting ", cntry))
  
gap_to_plot <- gap_europe |>
  filter(country == cntry)
  
my_plot <- ggplot(data = gap_to_plot, mapping = aes(x = year, y = gdp_tot)) +
  geom_point() +
  labs(title = str_c(cntry, "GDP", sep = " "),
       subtitle=ifelse(any(gap_to_plot$estimated == "no"), "Estimates data", "Reported data"))
  
if (any(gap_to_plot$estimated=="yes")) {
  
  print(str_c(cntry, "data are estimated"))
  
  my_plot <- my_plot +
    labs(subtitle="Estimated data")
} else if (any(gap_to_plot$estimated=="no")) {
  
  print(str_c(cntry, "data are reported"))
  
  my_plot <- my_plot +
    labs(subtitle="Reported data")
  
} 
  
  ggsave(filename = str_c("figures/europe/", cntry, "_gdp_tot.png", sep = ""), plot = my_plot)
  
}


