library(tidyverse)
library(ggplot2)

orig_data <- read.csv(file = "orig_data.csv")
str(orig_data)

cleaned_data <- subset(orig_data, select = -c(gisco_id,
                                              named_after_id, date_of_birth,
                                              date_of_death, picture_embed,
                                              image_credit, wikipedia))


cleaned_data <- subset(cleaned_data, person == 1 & !is.na(gender))
cleaned_data <- group_by(cleaned_data, gender)

gender_count_bars <- ggplot(data = cleaned_data, aes(x = gender)) +
  geom_bar() +
  theme_minimal()


gender_by_country_bars <- ggplot(data = cleaned_data, aes(x = country)) +
  geom_bar(aes(fill = gender), position = position_stack(reverse = TRUE))
