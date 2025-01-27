# Paczki do pracy
library(tidyverse)

# Załadowanie danych
data <- iris

# Policz średnią szerokość petal, cały zestaw danych
srednia <- mean(data[, 4])

# Policz medianę i odchylenie standardowe, druga kolumna i wiersze 10 do 15
mediana <- median(data[10:15, 2])

odchylenie <- sd(data[10:15, 2])

# Policz srednia dla gatunku versicolor, zmienna Petal.Length
srednia.pl.versicolor <- mean(data[51:100, 3])

# Policz srednia dla gatunku virginica, zmienna pierwsza
srednia.pl.virginica <- mean(data[data$Species == "virginica", 1])

# Podsumowania danych
podsumowanie <- summary(data)
podsumowanie

# Utworzenie kolumny na podstawie... sumy
suma.dwa.i.trzy <- data$Sepal.Width + data[, 3]

# Utworzenie kolumny na podstawie... sumy - jako nowa zmienna w ramce data
data$nasza.suma <- data$Sepal.Width + data$Petal.Length

# Suma trzech kolumn dzielona przez kolumnę czwartą
data$dziwne.cos <- (data$Sepal.Length + data$Sepal.Width + data$Petal.Length) / data$Petal.Width

# Średnia kolumny 1 i 2 jako nowa kolumna (zmienna)
data$srednia.jeden.dwa <- mean(c(data$Sepal.Length, data$Sepal.Width))

# Subset (wybór) ramki danych
data_mniejsza <- data[, 1:5]

# Subset ramki, wiersze i kolumny, wiersze 40 i 50 do 60, kolumny 2 i 3
data_mniejsza.2 <- data[c(40, 50:60), c(2, 3)]

# Tidyverse, paczka dplyr i funkcja select ####
# Wybór z funkcją select - wykorzystanie nazwy
# Kolumna Sepal.Width
data.3 <- dplyr::select(data, Sepal.Width)

# Negatywne wybory
data.4 <- dplyr::select(data, -Species)

data.5 <- dplyr::select(data, -c(nasza.suma, srednia.jeden.dwa, dziwne.cos))

# Zmiana pozycji
data.6 <- dplyr::select(data.5, Species, Petal.Length, Sepal.Length, Sepal.Width, Petal.Width)

# Wybór na podstawie początku nazwy
data.7 <- dplyr::select(data, dplyr::starts_with("petal"))

# Wybór na podstawie końca nazwy
data.8 <- dplyr::select(data, dplyr::ends_with("length"))

# Wybór na podstawie dowolnego dopasowania
data.9 <- dplyr::select(data, dplyr::contains("l.L"))

# Wybór zakresu
data.10 <- dplyr::select(data, Sepal.Length:Petal.Length)

# Wybór wierszy, tidyverse i filter ####
data.11 <- dplyr::filter(data, Petal.Length > 2 & Species == "virginica")
