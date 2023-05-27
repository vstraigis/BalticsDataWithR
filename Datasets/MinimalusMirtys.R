library(tidyverse)

minimum_wages <- read.csv("MinimumWagesBalticsPPP.csv")
well_being <- read.csv("WellBeing.csv")

deaths_suicide_alcohol_drugs <- well_being %>%
  filter(VARIABLE == "5_3", TIME >= 2003) %>%
  select(Country = LOCATION, Year = TIME, Deaths = Value)

hourly_minimum_wages <- minimum_wages %>%
  filter(PERIOD == "H", TIME >= 2003) %>%
  select(Country = COUNTRY, Year = TIME, HourlyMinimumWage = Value)

merged_data <- merge(deaths_suicide_alcohol_drugs, hourly_minimum_wages, by = c("Country", "Year"))

correlation <- cor(merged_data$HourlyMinimumWage, merged_data$Deaths)

ggplot(merged_data, aes(x = HourlyMinimumWage, y = Deaths, col = Country)) +
  geom_point(size=3) +
  geom_smooth(method = "lm", linetype = "dashed", se = FALSE) +
  labs(x = "Minimalus valandinis atlyginimas",
       y = "Mirtys nuo alkoholio, narkotikų ir savižudybės",
       title = paste("Koreliacija: ", round(correlation, 2))) +
  scale_color_manual("Šalis", values = c(EST = "blue", LTU = "red", LVA = "green")) +
  theme_minimal() +
  theme(legend.position = "bottom") +
  facet_wrap(~Year, nrow = 3) 