
data <- read.csv("WellBeing.csv")


indicator <- "Employment rate"
filtered_data <- subset(data, Indicator == indicator)


library(ggplot2)

ggplot(filtered_data, aes(x = TIME, y = Value, fill = Country)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Metai", y = indicator, title = "Darbo lygis Baltijos šalyse") +
  theme_minimal() +
  coord_cartesian(ylim = c(60, max(filtered_data$Value)))