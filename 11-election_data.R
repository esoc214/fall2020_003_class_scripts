# load libraries
library(tidyverse)
library(ggthemes)

# check work environment
dir()
dir("data")

# read data in
election_data <- read_csv("data/president_county_candidate.csv")

# inspect data
glimpse(election_data)

# Question #1: How many popular votes total for each candidate? ####
# start with election data and then, group by candidate and then
# sum total_votes (check in at 2:30pm)
election_data %>%
  group_by(candidate) %>%
  summarise(popular_votes = sum(total_votes)) %>%
  arrange(-popular_votes)

# plot popular vote count (sum of total_votes)
election_data %>%
  group_by(candidate) %>%
  summarise(popular_votes = sum(total_votes)) %>%
  filter(popular_votes > 10000) %>%
  ggplot(aes(y = reorder(candidate, popular_votes),
             x = popular_votes)) +
  geom_col() +
  geom_label(aes(label = popular_votes)) +
  labs(x = "Total Number of Popular Votes",
       y = "",
       title = "Total Number of Popular Votes for Presidential Elections (2020)",
       subtitle = "Displaying only candidates with 10k votes or more") +
  theme_tufte() +
  theme(panel.grid = element_blank(),
        axis.text.x = element_blank())

## Question #2: How many electoral votes for each candidate? ####
# 1) Calculate the winner for each state
winner_per_state <- election_data %>%
  group_by(state, candidate) %>%
  summarise(popular_votes = sum(total_votes)) %>%
  group_by(state) %>%
  top_n(1)

# read in data for electoral votes per state
electoral_vote_data <- read_csv("https://raw.githubusercontent.com/esoc214/fall2020_002_class_scripts/main/data/electoral_votes_per_state.csv")

# add electoral_vote_data to winner_per_state using left_join
winner_per_state <- left_join(winner_per_state,
                              electoral_vote_data)

# create a new data frame with total number of votes per state
total_per_state <- election_data %>%
  group_by(state) %>%
  summarise(total = sum(total_votes))

# add total per state to winner_per_state
winner_per_state <- left_join(winner_per_state, 
                                total_per_state)

winner_per_state <- winner_per_state %>%
  mutate(percent_votes = popular_votes/total)

# save this to disk
write_csv(winner_per_state, "data/presidential_elections_2020.csv")



