# install readxl
#install.packages("readxl")

# load libraries
library(readxl)
library(tidyverse)

# check your working environment
getwd()
dir()
dir("data")

# load data
nfl_salary <- read_excel("data/nfl_salary.xlsx")

# inspect
summary(nfl_salary)
glimpse(nfl_salary)
View(nfl_salary)

# start with our dataframe nfl_salary and then
# group by year and then
# summarise the mean of Quarterback
nfl_salary %>%
  group_by(year) %>%
  summarise(qb_mean_salary = mean(Quarterback, na.rm = TRUE))

# start with our dataframe nfl_salary and then
# group by year and then
# summarise the mean of Quarterback and the mean of Cornerback
nfl_salary %>%
  group_by(year) %>%
  summarise(qb_mean_salary = mean(Quarterback, na.rm = TRUE), 
            cb_mean_salary = mean(Cornerback, na.rm = TRUE))

# for our data to be tidy we need three columns
# year, position, and salary
nfl_tidy <- nfl_salary %>%
  pivot_longer(cols = -year,
               names_to = "position",
               values_to = "salary")
View(nfl_tidy)

# count year and position (how many observations are there?)
nfl_tidy %>%
  count(year, position)

# count year and position for missing data
nfl_tidy %>%
  filter(is.na(salary)) %>%
  count(year, position)

# create a clean dataframe with no missing
nfl_clean <- nfl_tidy %>%
  filter(!is.na(salary))

View(nfl_clean)

# start with nfl_clean and then
# group by year and position and then
# summarise with the mean of salary
nfl_clean %>%
  group_by(year, position) %>%
  summarise(mean_salary = mean(salary)) %>%
  arrange(-mean_salary)

########### REVIEW ########### September 24 ######
# group_by()
# grouping different categories (variables)
nfl_clean %>%
  group_by(position)

# summarise()
# summarize data by mapping different function to different variables
# you can use function like mean() and n() and sum() inside summarise()
nfl_clean %>%
  group_by(position) %>%
  summarise(mean(salary))

# filter()
# filters observations/rows in our data
nfl_clean %>%
  filter(position != "Cornerback")

# arrange()
# it organizes your data by a column, alphanumeric order
# increasing order
nfl_clean %>%
  arrange(position)

nfl_clean %>%
  arrange(salary)

# invert the order
nfl_clean %>%
  arrange(-salary)

# count()
# it counts how many of each unique value in a column/variable
nfl_clean %>%
  count(position)

# pivot_longer
# it makes the data frame longer because it gathers columns names
# in a column called "name" and all the values in a second column
# called "value"
nfl_salary %>%
  pivot_longer(cols = Cornerback:'Wide Receiver')

# summarise mean salary per year and position
# start with nfl_clean
# group_by year and position
# summarise mean of salary
nfl_clean %>%
  group_by(year, position) %>%
  summarise(mean_salary_posyear = mean(salary))

# summarise sum salary per year and position
# start with nfl_clean and then
# group_by year and position
# summarise sum of salary
nfl_clean %>%
  group_by(year, position) %>%
  summarise(total_salary = sum(salary),
            player_count = n())

# summarise sum of salary per year and position
# create a new column with average salary
# by dividing total_salary by player_count
nfl_clean %>%
  group_by(year, position) %>%
  summarise(player_count = n(),
            total_salary = sum(salary)) %>%
  mutate(mean_salary = total_salary/player_count,
         total_spent_per_year = sum(total_salary))

# add to mutate()
# percentage of total_salary by total_spent_per_year
# divide total_salary by total_spent_per_year
nfl_summary <- nfl_clean %>%
  group_by(year, position) %>%
  summarise(player_count = n(),
            total_salary = sum(salary)) %>%
  mutate(mean_salary = total_salary/player_count,
         total_spent_per_year = sum(total_salary),
         percent = total_salary/total_spent_per_year)
View(nfl_summary)

# x axis will be year
# y axis will be mean_salary
# color will be position
nfl_summary %>%
  ggplot(aes(x = year, y = mean_salary, color = position)) +
  geom_point() +
  geom_line(aes(group = position)) +
  theme_bw()








