# load libraries
library(janitor)
library(lubridate)
library(tidyverse)

# read data in
global_temperatures <- read_csv("https://raw.githubusercontent.com/esoc214/fall2020_002_class_scripts/main/data/GlobalLandTemperaturesByCountry.csv")

# inspect our data
View(global_temperatures)

# clean column names
global_temperatures <- global_temperatures %>%
  clean_names()

# explore date variable
class(global_temperatures$dt)
year(global_temperatures$dt)
month(global_temperatures$dt, label = TRUE, abbr = FALSE)
week(global_temperatures$dt)

# mutate data frame to add year, month, week based on dt column
global_temperatures <- global_temperatures %>%
  mutate(year = year(dt),
         month = month(dt),
         week = week(dt))

# install and load countrycode
library(countrycode)

global_temperatures <- global_temperatures %>%
  mutate(continent = countrycode(sourcevar = country,
                                 origin = "country.name",
                                 destination = "continent"))

# why do some countries have no continent
global_temperatures %>%
  filter(is.na(continent)) %>%
  distinct(country)

# create a new data frame with country that have a continent
global_temp_cont <- global_temperatures %>%
  filter(!is.na(continent))

# start with our final dataframe (global_temp_cont)
# group by year and continent and then
# summarise the mean of average_temperature
# draw a line plot with x mapped to year, y mapped to mean
# of average_temperature and color mapped to continent
global_temp_cont %>%
  group_by(year, continent) %>%
  summarise(mean_temp = mean(average_temperature,
                             na.rm = TRUE)) %>%
  ggplot(aes(x = year,
             y = mean_temp,
             color = continent)) +
  geom_point() +
  geom_line()



