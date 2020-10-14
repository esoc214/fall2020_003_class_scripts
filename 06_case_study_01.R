# load library
library(tidyverse)

# check your working environment 
getwd()
dir("data")

# read data in
olympic_events <- read_csv("data/olympic_history_athlete_events.csv")

# inspect
glimpse(olympic_events)
View(olympic_events)

# Has athlete height and weight changed over time overall?
# Height and Weight across different Years
# use the following functions:
# count()
# group_by() + summarise()
# plot the summary above
# map mean_height to y, and Year to x
olympic_events %>%
  filter(Season == "Summer") %>%
  group_by(Year) %>%
  summarise(mean_height = mean(Height, na.rm = TRUE)) %>%
  ggplot(aes(y = mean_height,
             x = Year)) +
  geom_point() +
  geom_line()

# recreate the chart above by plot mean Weight across Year
olympic_events %>%
  filter(Season == "Summer") %>%
  group_by(Year) %>%
  summarize(mean_weight = mean(Weight, na.rm = TRUE)) %>%
  ggplot(aes(y = mean_weight, x = Year)) +
  geom_point() +
  geom_line() +
  geom_label(aes(label = format(mean_weight, digits = 0)))

# difference between one equal sign and two equal signs
# one equal
number_five = 5
4 = 5 # error

# two equal signs (comparison)
4 == 5

# SECOND QUESTION: Has height and weight changed over time for the 
# top 5 countries with the most medals?

# count number of medals per Team
olympic_events %>%
  filter(!is.na(Medal)) %>%
  count(Team, Medal) %>%
  arrange(-n)

