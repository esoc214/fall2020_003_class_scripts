# install tidyverse
#install.packages("tidyverse")

# load tidyverse
library(tidyverse)

# load data into our environment
# check current working directory
getwd()

# list the contents of your working directory
dir()

# list the contents of "data" folder
dir("data")

# load data
groundhog_predictions <- read_csv("data/groundhog_day.csv")
View(groundhog_predictions)

# inspect dataframe using summary()
summary(groundhog_predictions)
glimpse(groundhog_predictions)

#### The Pipe ####
# %>% means "and then"
# ctrl+shift and press "m"
# summary(groundhog_predictions)
groundhog_predictions %>%
  summary()

### get column names
groundhog_predictions %>%
  colnames()

### What are the unique prediction values
# tidyverse way:
groundhog_predictions %>% 
  select(Punxsutawney_Phil) %>%
  unique()

# the three lines above are the same as (base R):
unique(groundhog_predictions$Punxsutawney_Phil)

# count occurrences by category
groundhog_predictions %>%
  count(Punxsutawney_Phil)

# select column
groundhog_predictions %>%
  select(Punxsutawney_Phil)

# count a different way
groundhog_predictions %>%
  group_by(Punxsutawney_Phil) %>%
  summarise(total = n())

############### SEPTEMBER 17 ################
# count prediction values using count()
groundhog_predictions %>%
  count(Punxsutawney_Phil)

# count prediction values using group_by() and count()
groundhog_predictions %>%
  group_by(Punxsutawney_Phil) %>%
  count()

# count prediction values using group_by() and summarise()
groundhog_predictions %>%
  group_by(Punxsutawney_Phil) %>%
  summarise(total = n())

# we can use mean() with numeric variable 
# you can add any function inside summarise()
# how do we get means of 
# - February_Average_Temperature
# - March_Average_Temperature
# using summarise()
groundhog_predictions %>%
  group_by(Punxsutawney_Phil) %>%
  summarise(feb_temp = mean(February_Average_Temperature), 
            mar_temp = mean(March_Average_Temperature))

# getting means, without changing column names
groundhog_predictions %>%
  summarise(mean(February_Average_Temperature),
            mean(March_Average_Temperature))

# getting means, but change column names
groundhog_predictions %>% 
  group_by(Punxsutawney_Phil) %>% 
  summarise(feb_temp = mean(February_Average_Temperature), 
            march_temp = mean(March_Average_Temperature))

# filter data using filter()
summary_predictions <- groundhog_predictions %>%
  filter(Punxsutawney_Phil == "Full Shadow" |
           Punxsutawney_Phil == "No Shadow") %>%
  group_by(Punxsutawney_Phil) %>%
  summarise(feb_temp = mean(February_Average_Temperature),
            mar_temp = mean(March_Average_Temperature))
summary_predictions

# select columns in our dataframe using select()
selected_predictions <- groundhog_predictions %>%
  select("prediction" = Punxsutawney_Phil,
         "feb_temp" = February_Average_Temperature,
         "march_temp" = March_Average_Temperature)

# pivot data frame
predictions_longer <- selected_predictions %>%
  pivot_longer(cols = c(feb_temp, march_temp))

View(predictions_longer)

## demonstration of chart
predictions_longer %>%
  ggplot(aes(x = name, y = value)) +
  geom_jitter(aes(color = prediction))


