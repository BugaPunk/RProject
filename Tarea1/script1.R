# Instalamos el paquete BHH2
if (!requireNamespace("BHH2", quietly = TRUE)) {
  install.packages("BHH2")
}

# Cargar la librería BHH2
library(BHH2)

# Cargar los datos de shoes.data
data("shoes.data")

# Ver las primeras filas de los datos
head("shoes.data")

# Obtener un resumen estadístico de los datos
summary("shoes.data")

# Ver la estructura de los datos
str("shoes.data")