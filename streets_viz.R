library(tidyverse)
library(ggplot2)
library(scales)

cleaned_data <- read.csv(file = "street_data_cleaning/processed_data.csv")
str(cleaned_data)


cleaned_data <- group_by(cleaned_data, gender)

gender_count_bars <- ggplot(data = cleaned_data, aes(x = gender)) +
  geom_bar() +
  theme_minimal()

gender_by_country_bars <- ggplot(data = cleaned_data, aes(x = country)) +
  geom_bar(aes(fill = gender), position = position_stack(reverse = TRUE))

gender_count_percent <- ggplot(cleaned_data) +
  stat_count(mapping = aes(x = gender, y = ..prop.. * 100, group = 1))

gender_percent_by_country <- ggplot(cleaned_data) +
  stat_count(mapping = aes(x = country, y = ..prop.. * 100, group = gender)) +
  facet_grid(~gender)
