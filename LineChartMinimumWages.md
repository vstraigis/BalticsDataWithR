```{r}
countries <- c("Estonia", "Lithuania", "Latvia")
filtered_data <- data[data$Country %in% countries, ]

plot <- ggplot(filtered_data, aes(x = TIME, y = Value, color = Country)) +
  geom_line() +
  geom_point() +
  labs(x = "Metai", y = "Valandinė alga (USD)", title = "Valandinio užmokeščio pokytis") +
  scale_color_manual(values = c("blue", "green", "red"), labels = c("Estija", "Lietuva", "Latvija")) +
  theme_minimal()

plot
```

![MinimalWagesBaltics](img/MinimalHourly.jpg)  

---

```{r}
filtered_data <- data %>%
  filter(SERIES == "PPP") %>%
  select(COUNTRY, Time, Value) %>%
  rename(Country = COUNTRY, Year = Time, PPP = Value)

ggplot(filtered_data, aes(x = Year, y = PPP, color = Country)) +
  geom_point(size = 3) +
  labs(x = "Metai", y = "Alga, eur", title = "Minimali alga") +
  theme_minimal()
```

![MinimalWagesBaltics](img/Minimalwage.jpg)

---
    
```{r}
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
  geom_point(size=3) +
  geom_smooth(method = "lm", linetype = "dashed", se = FALSE) +
  labs(x = "Hourly Minimum Wage",
       y = "Deaths from suicide, alcohol, drugs",
       title = paste("Correlation: ", round(correlation, 2))) +
  scale_color_manual("Country", values = c(EST = "blue", LTU = "red", LVA = "green")) +
  theme_minimal() +
  theme(legend.position = "bottom") +
  facet_wrap(~Year, nrow = 3) 

```

![DeathsAndMinimumWage](img/DeathsAndMinimumWage.png)

---
```{r}
# Install and load the required packages
install.packages("ggplot2")
library(ggplot2)

# Load the data from CSV file
data <- read.csv("MinimumHoursOfWorkToEscapePoverty.csv")

# Filter the data for a specific country
estonia_data <- subset(data, Country == "Estonia")

# Create a line plot with points
ggplot(estonia_data, aes(x = Year, y = Value)) +
  geom_line() +
  geom_point() +
  labs(x = "Year", y = "Minimum Hours of Work", title = "Minimum Hours of Work to Escape Poverty in Estonia")

# Create a bar plot with multiple countries
ggplot(data, aes(x = Country, y = Value, fill = Country)) +
  geom_bar(stat = "identity") +
  labs(x = "Country", y = "Minimum Hours of Work", title = "Minimum Hours of Work to Escape Poverty by Country") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Create a box plot to compare distributions
ggplot(data, aes(x = Country, y = Value)) +
  geom_boxplot() +
  labs(x = "Country", y = "Minimum Hours of Work", title = "Distribution of Minimum Hours of Work to Escape Poverty by Country") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
  ```

![MinimumHoursOfWorkToEscapePoverty](img/MinimumHoursOfWorkToEscapePoverty.png)