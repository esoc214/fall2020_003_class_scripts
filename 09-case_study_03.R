# load libraries
library(tidyverse)

# read data in
beer_awards <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-10-20/beer_awards.csv")

# think about what questions you can ask
# what plots could you draw?
# summary of task: question + how to answer the question with code

################################################################################
# Question #1: which beer category got the most medals?
# Sub-question: does that change across different medals?

# How medals per category, arrange highest count first
beer_awards %>%
  count(category) %>%
  arrange(-n)

# Answer: Classic Irish-Style Dry Stout got the most medals across all years (62)

# create a list with top 10 categories (that got the most medals)
top_10_beers <- beer_awards %>%
  count(category) %>%
  top_n(10) %>%
  pull(category)

top_10_beers

# change medal variable so it's ordered: Gold, Silver, Bronze
beer_awards <- beer_awards %>%
  mutate(medal = factor(medal,
                        levels = c("Gold",
                                   "Silver",
                                   "Bronze")))

# plot medal count per category
beer_awards %>%
  filter(category %in% top_10_beers) %>%
  count(medal, category) %>%
  ggplot(aes(y = reorder(category, n),
             x = n,
             fill = medal)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c("#ffdd93",
                               "#cdc9c3",
                               "#cd7f32")) +
  theme_bw() +
  labs(x = "award count",
       y = "beer category") +
  ggtitle("Medal count for the top 10 awarded beer categories")


################################################################################
# Question #2: which state has the most amount of gold, silver, and bronze metals
# Sub-questions: in what categories?

# fix case of state codes
beer_awards <- beer_awards %>%
  mutate(state = toupper(state))

# count of medals (gold, silver, bronze) by state
beer_awards %>%
  count(state, medal) %>%
  arrange(-n)

# Answer: California has the most amount of Gold, Silver, and Bronze medals.

# filter data to keep state == "CA"
# count medal and category
# arrange by n (highest n first)
beer_awards %>%
  filter(state == "CA") %>%
  count(medal, category) %>%
  arrange(-n)



