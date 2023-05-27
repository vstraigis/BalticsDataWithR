# Install ggplot2 package
install.packages("ggplot2")

# Load library
library(ggplot2)

# Load data
WellBeing <- read.csv("WellBeing.csv")

# Filter data for homicides and employment rates
homicides_data <- WellBeing[WellBeing$VARIABLE == "10_1", ]
employment_data <- WellBeing[WellBeing$VARIABLE == "2_1", ]

# Merge homicides and employment data
merged_data <- merge(homicides_data, employment_data, by = c("LOCATION", "TIME"))

# Rename Value columns
colnames(merged_data)[colnames(merged_data) == "Value.x"] <- "Homicides"
colnames(merged_data)[colnames(merged_data) == "Value.y"] <- "Employment_rate"

# Create scatter plot with ggplot2
plot <- ggplot(merged_data, aes(x = Employment_rate, y = Homicides, color = LOCATION)) +
  geom_point(size=3) +
  geom_smooth(method = "lm", se = FALSE, linetype = "solid") +
  labs(title = "Koreliacija tarp darbo lygio ir žmogžudysčių",
       x = "Darbo lygis",
       y = "Žmogžudystės") +
  theme_minimal()

# Display plot
print(plot)