top_5_countries <- gapminder |>
  filter(year == 2015) |>
  arrange(population) |>
  select(country) |>
  head (5) |>
  pull()

gapminder |>
  filter(year == 2015) |>
  arrange(population) |>
  select(country) |>
  head (5)

gapminder |>
  filter(country %in% top_5_countries) |>
  ggplot() +
  geom_line(mapping=aes(x=year, y = population, color = country))

gapminder |>
  filter(year==2015, country %in% c("Turkey", "Poland", "South Korea", "Russia", "Vietnam", "South Africa")) |>
  select (country, infant_mortality) |>
  arrange (infant_mortality)

gapminder |>
  filter(year==2000) |>
  select(fertility, gdp, population) |>
  ggplot() +
  geom_point(mapping=aes(y=fertility, x=gdp/population))

gapminder |>
  filter(year==2000) |>
  select(fertility, gdp, population, continent) |>
  ggplot() +
  geom_point(mapping=aes(y=fertility, x=gdp/population, color = continent)) +
  facet_wrap(~continent)




#Which day has had the highest total death count globally reported in this dataset?
  
  
coronavirus |>
  filter (type == "death") |>
  group_by(date) |>
  summarize(total_deaths = sum(cases)) |>
  arrange (-total_deaths) |>
  ggplot() +
  geom_line(mapping=aes(x=date, y=total_deaths))

coronavirus |>
  filter (type == "death", date != "2023-01-04") |>
  group_by(date) |>
  summarize(total_deaths = sum(cases)) |>
  arrange (-total_deaths) |>
  ggplot() +
  geom_line(mapping=aes(x=date, y=total_deaths))









#Which day has had the highest total death count globally reported in this dataset?
coronavirus |>
  filter (type == "death") |>
  group_by(date) |>
  summarize(total_deaths = sum(cases)) |>
  arrange (-total_deaths) |>
  ggplot() +
  geom_line(mapping=aes(x=date, y=total_deaths))

#without 2023-01-04
coronavirus |>
  filter (type == "death", date != "2023-01-04") |>
  group_by(date) |>
  summarize(total_deaths = sum(cases)) |>
  arrange (-total_deaths) |>
  ggplot() +
  geom_line(mapping=aes(x=date, y=total_deaths))

#Which country had the highest count of confirmed cases in January of this year? [Hint: to address this question the functions month() and year() from the package lubridate might be helpful]. What about in March?
coronavirus |>
  mutate(month = month(date), year = year(date)) |> 
  filter(type == "confirmed", month == 1, year == 2021) |>
  group_by(country) |>
  summarize(total_deaths = sum(cases)) |>
  arrange (-total_deaths) |>
  head(5) |>
  ggplot() +
  geom_col(mapping=aes(x=country, y=total_deaths))




