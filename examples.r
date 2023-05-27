# Load necessary libraries
library(dplyr)
library(ggplot2)
library(readr)

# Read data
hours_data <- read_csv("MinimumHoursOfWorkToEscapePoverty.csv")
wage_data <- read_csv("MinimumWagesBalticsPPP.csv")

# Filter data for single-person households
single_person_hours <- hours_data %>%
  filter(FAMILY == "SINGLE")

# Calculate the average hours of work to escape poverty by year and location
avg_hours_by_year <- single_person_hours %>%
  group_by(TIME, LOCATION) %>%
  summarise(avg_hours = mean(Value)) %>%
  ungroup()

# Filter annual data on minimum wages PPP
annual_wages <- wage_data %>%
  filter(PERIOD == "A", SERIES == "PPP") %>%
  select(TIME, LOCATION = COUNTRY, Value)

# Merge datasets
merged_data <- inner_join(avg_hours_by_year, annual_wages, by = c("LOCATION", "TIME"))

ggplot(merged_data, aes(x = Value, y = avg_hours, color = LOCATION)) +
  geom_point() +
  labs(title = "Correlation between Minimum Hours to Escape Poverty and Minimum Wages PPP (by Year)",
       x = "Annual Minimum Wages PPP (USD)",
       y = "Average Hours of Work to Escape Poverty") +
  scale_color_discrete(name = "Baltic States", labels = c("Estonia", "Latvia", "Lithuania")) +
  facet_wrap(~TIME) +     # Add this line to create separate plots for each year
  theme_minimal()

  // ------------------------------------------------------------------------------

# Load needed libraries
library(tidyverse)

# Read data files
minimum_wages <- read.csv("MinimumWagesBalticsPPP.csv")
well_being <- read.csv("WellBeing.csv")

# Filter well_being data for Deaths from suicide, alcohol, drugs
deaths_suicide_alcohol_drugs <- well_being %>%
  filter(VARIABLE == "5_3", TIME >= 2003) %>%
  select(Country = LOCATION, Year = TIME, Deaths = Value)

# Filter minimum_wages Hourly and Year
hourly_minimum_wages <- minimum_wages %>%
  filter(PERIOD == "H", TIME >= 2003) %>%
  select(Country = COUNTRY, Year = TIME, HourlyMinimumWage = Value)

# Merge datasets
merged_data <- merge(deaths_suicide_alcohol_drugs, hourly_minimum_wages, by = c("Country", "Year"))

# Calculate correlations
correlation <- cor(merged_data$HourlyMinimumWage, merged_data$Deaths)

# Visualize
ggplot(merged_data, aes(x = HourlyMinimumWage, y = Deaths, col = Country)) +
  geom_point(size=5) +
  geom_smooth(method = "lm", linetype = "dashed", se = FALSE) +
  labs(x = "Hourly Minimum Wage",
       y = "Deaths from suicide, alcohol, drugs",
       title = paste("Correlation: ", round(correlation, 2))) +
  scale_color_manual("Country", values = c(EST = "blue", LTU = "red", LVA = "green")) +
  theme_minimal() +
  theme(legend.position = "bottom")