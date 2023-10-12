library(tidyverse)
library(ggplot2)

cleaned_data <- read.csv(file = "street_data_cleaning/processed_data.csv")
str(cleaned_data)


cleaned_data <- group_by(cleaned_data, gender)

gender_count_bars <- ggplot(data = cleaned_data, aes(x = gender)) +
  geom_bar() +
  theme_minimal()

gender_by_country_bars <- ggplot(data = cleaned_data, aes(x = country)) +
  geom_bar(aes(fill = gender), position = position_stack(reverse = TRUE))
