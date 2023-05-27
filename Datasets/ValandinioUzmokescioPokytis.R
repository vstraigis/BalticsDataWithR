library(ggplot2)
data <- read.csv("MinimumWagesBalticsPPP.csv")
countries <- c("Estonia", "Lithuania", "Latvia")
filtered_data <- data[data$Country %in% countries & data$Pay.period == "Hourly", ]  # added filtering for hourly wages

plot <- ggplot(filtered_data, aes(x = TIME, y = Value, color = Country)) +
  geom_point() +
  geom_line() +
  labs(x = "Metai", y = "Valandinė alga (USD)", title = "Valandinio užmokeščio pokytis") +
  scale_color_manual(values = c("blue", "green", "red"), labels = c("Estija", "Lietuva", "Latvija")) +
  theme_minimal()

plot