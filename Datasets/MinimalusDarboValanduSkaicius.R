install.packages("ggplot2")
library(ggplot2)

data <- read.csv("MinimumHoursOfWorkToEscapePoverty.csv")


# For the third plot
ggplot(data, aes(x = Country, y = Value, fill = Country)) +
  geom_boxplot() +
  labs(x = "Šalis", y = "Minimalus darbo valandų kiekis", title = "Minimalus darbo valandų kiekis, kad pakilti virš skurdo ribos") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))