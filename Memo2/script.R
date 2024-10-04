Patacamaya <- read.csv("~/RProject/Memo2/Patacamaya.data")
summary(Patacamaya)

# Calcular diferencias de temperatura
Patacamaya$Diff.M.Agua <- Patacamaya$Ambiental - rowMeans(Patacamaya[, c("M.Agua.1", "M.Agua.2", "M.Agua.3")], na.rm = TRUE)
Patacamaya$Diff.Paja <- Patacamaya$Ambiental - rowMeans(Patacamaya[, c("Paja.1", "Paja.2", "Paja.3")], na.rm = TRUE)
Patacamaya$Diff.T.Tunel <- Patacamaya$Ambiental - rowMeans(Patacamaya[, c("T.Tunel.1", "T.Tunel.2", "T.Tunel.3")], na.rm = TRUE)
Patacamaya$Diff.Walipini <- Patacamaya$Ambiental - rowMeans(Patacamaya[, c("Walipini.1", "Walipini.2", "Walipini.3")], na.rm = TRUE)

# Calcular promedios de diferencias
promedios_diferencias <- data.frame(
    Invernadero = c("M.Agua", "Paja", "T.Tunel", "Walipini"),
    Promedio_Diferencia = c(mean(Patacamaya$Diff.M.Agua, na.rm = TRUE),
                            mean(Patacamaya$Diff.Paja, na.rm = TRUE),
                            mean(Patacamaya$Diff.T.Tunel, na.rm = TRUE),
                            mean(Patacamaya$Diff.Walipini, na.rm = TRUE))
)

# Mostrar resultados
print(promedios_diferencias)

mejor_invernadero <- promedios_diferencias[which.min(promedios_diferencias$Promedio_Diferencia),]
print(mejor_invernadero)

# Contar días con heladas y calcular promedios
heladas <- Patacamaya[Patacamaya$Ambiental < 0, ]
promedios_heladas <- data.frame(
    Invernadero = c("M.Agua", "Paja", "T.Tunel", "Walipini"),
    Promedio_Temp_Bajo_Cero = c(mean(heladas$M.Agua.1[heladas$M.Agua.1 < 0], na.rm = TRUE),
                                mean(heladas$Paja.1[heladas$Paja.1 < 0], na.rm = TRUE),
                                mean(heladas$T.Tunel.1[heladas$T.Tunel.1 < 0], na.rm = TRUE),
                                mean(heladas$Walipini.1[heladas$Walipini.1 < 0], na.rm = TRUE))
)

print(promedios_heladas)

ggplot(promedios_diferencias, aes(x = Invernadero, y = Promedio_Diferencia)) +
    geom_point(size = 3, color = "blue") +  # Puntos en azul
    geom_line(aes(group = 1), color = "red") +  # Línea roja conectando puntos
    labs(title = "Comparación del Aislamiento Térmico de Invernaderos",
         x = "Invernadero",
         y = "Promedio de Diferencia de Temperatura (°C)") +
    theme_minimal() +
    geom_text(aes(label=round(Promedio_Diferencia, 2)), vjust=-0.5)