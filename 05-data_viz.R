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

# plot danceability by year
spotify_data %>%
  ggplot(aes(x = release_year,
             y = danceability)) +
  geom_point(alpha = 0.5)

# start with spotify_data and then
# group_by release_year, subgenre, and genre and the
# summarize the mean of track_popularity
spotify_summarized <- spotify_data %>%
  group_by(release_year, playlist_genre, playlist_subgenre) %>%
  summarise(mean_popularity = mean(track_popularity))

# scatterplot of mean_popularity by release_year
spotify_summarized %>%
  ggplot(aes(x = release_year, y = mean_popularity)) +
  geom_point()

# scatterplot of mean_popularity (y) by release_year (x)
# across genre (color)
spotify_summarized %>%
  ggplot(aes(x = release_year,
             y = mean_popularity,
             color = playlist_genre)) +
  geom_point()

# bar plot of mean_popularity (y) by release_year (x)
# across genre (fill)
spotify_summarized %>%
  ggplot(aes(x = release_year,
             y = mean_popularity,
             fill = playlist_genre)) +
  geom_col(position = "dodge") +
  facet_wrap(~playlist_subgenre)

# start with original (raw) spotify data
# group by playlist_genre
# summarize mean of track_popularity
spotify_data %>%
  group_by(playlist_genre) %>%
  summarise(mean_popularity = mean(track_popularity)) %>%
  ggplot(aes(x = fct_reorder(playlist_genre, -mean_popularity),
             y = mean_popularity)) +
  geom_col() +
  xlab("Genre") +
  ylab("Mean Popularity") +
  ggtitle("Mean Popularity of songs across genre") +
  theme_minimal()

# add playlist_subgenre to the chart above
# map playlist_subgenre to x
# map playlist_genre to fill
spotify_data %>%
  group_by(playlist_genre, playlist_subgenre) %>%
  summarise(mean_popularity = mean(track_popularity)) %>%
  ggplot(aes(x = fct_reorder(playlist_subgenre, mean_popularity),
             y = mean_popularity,
             fill = playlist_genre)) +
  geom_col() +
  coord_flip()

################## OCTOBER 6, 2020 #######################
# what are the artists represented in this data?
spotify_data %>%
  select(track_artist) %>%
  unique() %>%
  View()

# Artists: The Beatles, The Cranberries, and Queen
spotify_filtered <- spotify_data %>%
  filter(track_artist == "The Beatles" |
           track_artist == "The Cranberries" |
           track_artist == "Queen")

# check my new data frame
spotify_filtered %>%
  count(track_artist)

# check by artist and decade
spotify_filtered %>%
  count(track_artist, decade)

################### summarization ##############
# summarize mean track_popularity by track_artist and decade
spotify_filtered %>%
  group_by(track_artist, decade) %>%
  summarise(mean_pop = mean(track_popularity))

# plot summarization -- line plot
spotify_filtered %>%
  group_by(track_artist, decade) %>%
  summarise(mean_pop = mean(track_popularity)) %>%
  ggplot(aes(x = decade,
             y = mean_pop,
             color = track_artist)) +
  geom_point() +
  geom_line()

# plot summarization -- bar plot
spotify_filtered %>%
  group_by(track_artist, decade) %>%
  summarise(mean_pop = mean(track_popularity)) %>%
  ggplot(aes(x = decade,
             y = mean_pop,
             fill = track_artist)) +
  geom_col(position = "dodge")
  
# plot summarization -- bar plot, faceted by artist
spotify_filtered %>%
  group_by(track_artist, decade) %>%
  summarise(mean_pop = mean(track_popularity)) %>%
  ggplot(aes(x = decade,
             y = mean_pop,
             fill = track_artist)) +
  geom_col(position = "dodge") +
  facet_wrap(~track_artist)


# summarization: add standard deviation to summarise()
# using sd()
spotify_filtered %>%
  group_by(track_artist, decade) %>%
  summarise(mean_pop = mean(track_popularity),
            sd_pop = sd(track_popularity),
            song_count = n())


