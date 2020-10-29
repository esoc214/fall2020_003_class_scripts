# load libraries
library(tidyverse)
library(rvest)

# getting data from a html page
url <- "https://en.wikipedia.org/wiki/University_of_Arizona"

# to read in the html page
uarizona_wiki_page <- read_html(url)

# parse html page for table
uarizona_wiki_page %>%
  html_nodes("table")

# parse html for wikitable class
ua_wiki_tables <- uarizona_wiki_page %>%
  html_nodes(".wikitable")

# check first table in wiki_tables
ua_wiki_tables[[1]] %>%
  html_table(fill = TRUE)

# check the second table
ua_wiki_tables[[2]] %>%
  html_table(fill = TRUE)

# check the third table
fall_freshman_stats <- ua_wiki_tables[[3]] %>%
  html_table(fill = TRUE)

# assign a name to first column
colnames(fall_freshman_stats)[1] <- "type"

# pivot year columns to gather them into one column/variable called "year"
fall_fresh_longer <- fall_freshman_stats %>%
  pivot_longer(cols = "2017":"2013",
               names_to = "year")

# filter to keep value that is NOT NA
fall_fresh_clean <- fall_fresh_longer %>%
  filter(!is.na(value))

# inspect the data
glimpse(fall_fresh_clean)

# plot the data as is
# start with fall_fresh_clean and then
# filter to keep type only Applicants, Admits, Enrolled
# plot the data, mapping x to year, y to value, and color type
fall_fresh_clean %>%
  filter(type %in% c("Applicants", "Admits", "Enrolled")) %>%
  ggplot(aes(x = year,
            y = value,
            color = type)) +
  geom_point() +
  geom_line(aes(group = type))

# fix the value column to be numeric (instead of character)
# using parse_number()
fall_fresh_clean <- fall_fresh_clean %>%
  mutate(value = parse_number(value))

# inspect data
glimpse(fall_fresh_clean)

# plot it again with data frame fixed
fall_fresh_clean %>%
  filter(type %in% c("Applicants", "Admits", "Enrolled")) %>%
  ggplot(aes(x = year,
             y = value,
             color = fct_reorder(type, value, .desc = TRUE))) +
  geom_point() +
  geom_line(aes(group = type)) +
  labs(y = "student count",
       color = "")



