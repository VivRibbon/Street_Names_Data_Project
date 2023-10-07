library(tidyverse)

orig_data <- read.csv(file = "orig_data.csv")
str(orig_data)

cleaned_data <- orig_data %>%
