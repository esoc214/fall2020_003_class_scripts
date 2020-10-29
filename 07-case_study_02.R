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

############## OCTOBER 27 #############
# get decade from year
# 1986 to 1980
# 1873 to 1870
(1986 %/% 10) * 10
1986 - (1986 %% 10)

# mutate my data frame to add a column for decade
global_temp_cont <- global_temp_cont %>%
  mutate(decade = (year %/% 10) * 10)

# start with global_temp_cont data frame and then
# summarise mean of average_temperature by continent and decade
# plot it
global_temp_cont %>%
  group_by(continent, decade) %>%
  summarise(mean_temp = mean(average_temperature, na.rm = TRUE)) %>%
  ggplot(aes(x = decade, y = mean_temp, color = continent)) +
  geom_point() +
  geom_line() +
  geom_label(aes(label = round(mean_temp, digits = 0)))

# start with global_temp_cont data frame and then
# filter for continent == "Europe"
# summarise mean of average_temperature by decade and then
# plot it
global_temp_cont %>%
  filter(continent == "Europe") %>%
  group_by(decade) %>%
  summarise(mean_temp = mean(average_temperature, na.rm = TRUE)) %>%
  ggplot(aes(x = decade, y = mean_temp)) +
  geom_point()

# do year instead of decade
global_temp_cont %>%
  filter(continent == "Europe") %>%
  group_by(year) %>%
  summarise(mean_temp = mean(average_temperature, na.rm = TRUE)) %>%
  ggplot(aes(x = year, y = mean_temp)) +
  geom_point()

# do dt
global_temp_cont %>%
  filter(continent == "Europe") %>%
  group_by(dt) %>%
  summarise(mean_temp = mean(average_temperature, na.rm = TRUE)) %>%
  ggplot(aes(x = dt, y = mean_temp)) +
  geom_point()

