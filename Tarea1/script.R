shoes <- read.table("C:\\Users\\WINDOWS\\Documents\\R\\Tarea1\\shoes.data", 
                    header = TRUE, 
                    sep = ",")

if (!requireNamespace("tidyr", quietly = TRUE)) install.packages("tidyr")
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")
library(tidyr)
library(ggplot2)

shoes_long <- pivot_longer(shoes, 
                           cols = c(matA, matB), 
                           names_to = "material", 
                           values_to = "wear")


ggplot(shoes_long, aes(x = material, y = wear)) +
  geom_boxplot() +
  labs(title = "Desgaste del zapato por material",
       x = "Material",
       y = "Desgaste")

wear_by_material <- aggregate(wear ~ material, data = shoes_long, FUN = mean)
print(wear_by_material)

most_wear <- wear_by_material$material[which.max(wear_by_material$wear)]
print(paste("El material que más se desgasta es:", most_wear))