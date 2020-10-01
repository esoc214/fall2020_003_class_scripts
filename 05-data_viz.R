# load libraries
library(tidyverse)

# check working environment
getwd()
dir("data")

# read data in
spotify_data <- read_csv("data/spotify_songs.csv")

# inspect data
glimpse(spotify_data)
View(spotify_data)

########### HISTOGRAM ###################
### ONE NUMERIC CONTINUOUS VARIABLE #####
# plot histogram of track_popularity
spotify_data %>%
  ggplot(aes(x = track_popularity)) +
  geom_histogram()

# plot histogram of energy
spotify_data %>%
  ggplot(aes(x = energy)) +
  geom_histogram()

############# SCATTERPLOT ###############
### TWO NUMERIC VARIABLES ###############
# plot release_year by track_popularity
spotify_data %>%
  ggplot(aes(x = release_year,
             y = track_popularity)) +
  geom_point(alpha = 0.5)

# plot release_year by track popularity
# across different playlist_genre
spotify_data %>%
  ggplot(aes(x = release_year,
             y = track_popularity,
             color = playlist_genre)) +
  geom_point(alpha = 0.5)

# plot release_year by track_popularity
# across different playlist_genre
# use both color and facet for genre
spotify_data %>%
  ggplot(aes(x = release_year,
             y = track_popularity,
             color = playlist_genre)) +
  geom_point(alpha = 0.5) +
  facet_wrap(~playlist_genre)

# plot danceability and by loudness
spotify_data %>%
  ggplot(aes(x = loudness,
             y = danceability)) +
  geom_point(alpha = 0.5) 

# plot danceability by decade
spotify_data %>%
  ggplot(aes(x = release_year,
             y = danceability)) +
  geom_point(alpha = 0.5)











