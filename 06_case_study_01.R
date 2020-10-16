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

################ October 15 ##################
dir("data")
noc_regions <- read_csv("data/olympic_history_noc_regions.csv")

# join two data frames (olympic_events adn noc_regions) together
olympic_combined <- left_join(olympic_events, noc_regions)

# start with olympic_combined data frame and then
# filter to keep only Summer for Season
# filter to keep only Medals that are not NA
# count medals per region
olympic_combined %>%
  filter(Season == "Summer") %>%
  filter(!is.na(Medal)) %>%
  count(region, Medal) %>%
  arrange(-n)

# top 5 regions with the most medal count
top_five <- olympic_combined %>%
  filter(Season == "Summer") %>%
  filter(!is.na(Medal)) %>%
  count(region) %>%
  arrange(-n) %>%
  top_n(5)

# list top 5 regions with the most medals
top_five$region

# create a new data frame based on my original data frame  
# filter region that is in the top_five
olympic_filtered <- olympic_combined %>%
  filter(region %in% top_five$region)

# check region in my new data frame
olympic_filtered %>%
  count(region)

# plot height across Year for Summer olympics (Season == "Summer")
# starting with olympic_filtered
olympic_filtered %>%
  filter(Season == "Summer") %>%
  ggplot(aes(x = Year, y = Height)) +
  geom_point()

# plot the mean of height across Year for Summer Olympics 
# starting with olympic_filtered
olympic_filtered %>%
  filter(Season == "Summer") %>%
  group_by(Year) %>%
  summarise(mean_height = mean(Height, na.rm = TRUE)) %>%
  ggplot(aes(x = Year, y = mean_height)) +
  geom_point() +
  geom_line()

# add region as color to the plot above
olympic_filtered %>%
  filter(Season == "Summer") %>%
  group_by(Year, region) %>%
  summarise(mean_height = mean(Height, na.rm = TRUE)) %>%
  ggplot(aes(x = Year, y = mean_height, color = region)) +
  geom_point() +
  geom_line() +
  facet_wrap(~region)

# plot mean weight instead of height
olympic_filtered %>%
  filter(Season == "Summer") %>%
  group_by(Year, region) %>%
  summarise(mean_weight = mean(Weight, na.rm = TRUE)) %>%
  ggplot(aes(x = Year, y = mean_weight, color = region)) +
  geom_point() +
  geom_line() +
  facet_wrap(~region)

# medal count per region per sex
# start with olympic_filtered data and then
# count medals (that are not NA) per region and sex
olympic_filtered %>%
  filter(Season == "Summer") %>%
  filter(!is.na(Medal)) %>%
  count(region, Sex) %>%
  ggplot(aes(x = Sex, y = n, color = region)) +
  geom_point() +
  geom_line(aes(group = region))



