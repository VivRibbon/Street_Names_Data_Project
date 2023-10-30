library(tidyverse)
library(ggplot2)
library(scales)
library(stringr)

# Sets some simple defaults for ggsave to reduce code duplication later.
ggsave <- function(..., bg = "white", path = "plots")
ggplot2::ggsave(..., bg = bg, path = path)

# Loads the cleaned data from the Clojure project and
# previews it to make sure it looks good
cleaned_data <- read.csv(file = "street_data_cleaning/processed_data.csv")
str(cleaned_data)

# Groups the cleaned data by gender for analysis
cleaned_data <- group_by(cleaned_data, gender)

birth_year_data <- cleaned_data %>% mutate(date_of_birth = str_extract(date_of_birth, "(\\d\\d\\d\\d)"))

birth_year_data <- filter(birth_year_data, !is.na(date_of_birth))

# Generate a set of bars, with both count and percent versions.
gender_count_bars <- ggplot(data = cleaned_data, aes(x = gender)) +
  geom_bar() +
  theme_minimal()

gender_by_country_bars <- ggplot(data = cleaned_data, aes(x = country)) +
  geom_bar(aes(fill = gender), position = position_stack(reverse = TRUE))

gender_by_country_percent_over <- ggplot(data = cleaned_data) +
  geom_bar(aes(x = country, y = (..count..)/
                 sum(..count..) * 100, fill = gender),
           position = position_stack(reverse = TRUE))

gender_count_percent <- ggplot(cleaned_data) +
  stat_count(mapping = aes(x = gender, y = ..prop.. * 100, group = 1))

gender_percent_by_country <- ggplot(cleaned_data) +
  stat_count(mapping = aes(x = country, y = ..prop.. * 100, group = gender)) +
  facet_wrap(~gender)

gender_by_country_percent_grid <- ggplot(data = cleaned_data) +
  geom_bar(aes(x = country, y = (..count..)/
                 sum(..count..) * 100, fill = gender),
           position = position_stack(reverse = TRUE)) +
  facet_wrap(vars(country, gender))

birth_year_box <- ggplot(birth_year_data, aes(x = gender, y = as.numeric(date_of_birth))) +
  stat_boxplot(geom = "errorbar") +
  geom_boxplot(outlier.shape = NA) +
  geom_boxplot(outlier.shape = NA, aes(fill = country)) +
  theme_minimal()

birth_year_box_1500 <- ggplot(birth_year_data, aes(x = gender, y = as.numeric(date_of_birth))) +
  stat_boxplot(geom = "errorbar") +
  geom_boxplot(outlier.shape = NA) +
  geom_boxplot(outlier.shape = NA, aes(fill = country)) +
  coord_cartesian(ylim = c(1500, 2023)) +
  theme_minimal()

birth_year_box_by_country <- ggplot(birth_year_data, aes(x = country, y = as.numeric(date_of_birth))) +
  stat_boxplot(geom = "errorbar") +
  geom_boxplot(outlier.shape = NA) +
  geom_boxplot(outlier.shape = NA, aes(fill = gender)) +
  theme_minimal()

birth_year_box_by_country_1500 <- ggplot(birth_year_data, aes(x = country, y = as.numeric(date_of_birth))) +
  stat_boxplot(geom = "errorbar") +
  geom_boxplot(outlier.shape = NA) +
  geom_boxplot(outlier.shape = NA, aes(fill = gender)) +
  coord_cartesian(ylim = c(1500, 2023)) +
  theme_minimal()

birth_histo <- ggplot(birth_year_data, aes(as.numeric(date_of_birth), fill = gender)) +
  geom_histogram(bins = 300) +
  theme_minimal()

birth_freq <- ggplot(birth_year_data, aes(as.numeric(date_of_birth), color = gender)) +
  geom_freqpoly(bins = 100) +
  theme_minimal()

# Save the plots to files.
ggsave("gender_count_bars.png", plot = gender_count_bars)
ggsave("gender_by_country_bars.png", plot = gender_by_country_bars)
ggsave("gender_count_percent.png", plot = gender_count_percent)
ggsave("gender_percent_by_country.png", plot = gender_percent_by_country)
ggsave("gender_count_percent.png", plot = gender_count_percent)
ggsave("gender_by_country_percent_over.png", plot = gender_by_country_percent_over)
ggsave("gender_by_country_percent_grid.png", plot = gender_by_country_percent_grid)
ggsave("birth_year_box.png", plot = birth_year_box)
ggsave("birth_year_box_1500.png", plot = birth_year_box_1500)
ggsave("birth_year_box_by_country.png", plot = birth_year_box_by_country)
ggsave("birth_year_box_by_country_1500.png", plot = birth_year_box_by_country_1500)
ggsave("birth_histo.png", plot = birth_histo)
ggsave("birth_freq.png", plot = birth_freq)
