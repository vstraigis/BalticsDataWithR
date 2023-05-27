# Install packages if not already installed
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(dplyr)) install.packages("dplyr")

# Load packages
library(ggplot2)
library(dplyr)

# Read the dataset
well_being_data <- read.csv("WellBeing.csv")

# Filter the data for life expectancy
life_expectancy_data <- well_being_data %>%
  filter(VARIABLE == "5_1") %>%
  select(Country, TIME, Value)

# Create a fancy chart
ggplot(life_expectancy_data, aes(x = TIME, y = Value, group = Country, color = Country)) +
  theme_bw() +
  geom_line(size = 1) +
  labs(title = "Gyvenimo trukmės rodiklis gimus",
       x = "Metai",
       y = "Gyvenimo trukmė") +
  theme(legend.title = element_blank())