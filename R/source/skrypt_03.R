# 14.01.2025
# Paczki
library(tidyverse)

data <- iris

#
# NazwaPierwsza
# nazwaPierwsza
# snake_case
# zapis.z.kropka

# Zła nazwa
data$`nazwa niezgodna ze skladnia` <- 1

# Zmiana nazw kolumn z rename
data <- dplyr::rename(data,
                      sepal_length = Sepal.Length)

# Zmian kilku kolumn z funkcją
data <- dplyr::rename_with(data, .cols = everything(), \(i) tolower(i))

funkcja_maurycego <- function(argument1, argument2) {
  argument1 + argument2
}

# uzycie funkcji
funkcja_maurycego(argument1 = 1, argument2 = 2)

# zmiana na duze litery
# Zmian kilku kolumn z funkcją
data <- dplyr::rename_with(.data = data, .cols = dplyr::everything(), \(nazwy) toupper(nazwy))

# Doklejenie fragmentu tekstu
znaki <- c("japko", "pomarancze", "mango")

znaki_2 <- paste(znaki, " lubie")
znaki_2

# Doklejenie fragmentu tekstu do nazwy kolumny
data <- dplyr::rename_with(data, .cols = dplyr::starts_with("sepal"), \(nazwy) paste(nazwy, ".ug"))

# Summary
summary(data)

# Print data
data

# Struktura i typ
str(data)

# Grupowanie danych
data_grupowane <- dplyr::group_by(data, SPECIES)
str(data_grupowane)

# Policzenie podsumowania - srednia
data_srednie <- dplyr::summarise(
  data_grupowane,
  dplyr::across(dplyr::ends_with("ug"), \(kolumna) mean(kolumna)))

# Policzenie podsumowania - median i min
data_mediana.minimum <- dplyr::summarise(
  data,
  mediana = dplyr::across(
    PETAL.LENGTH:PETAL.WIDTH, \(kolumna) median(kolumna)),
  minimum = dplyr::across(
    PETAL.LENGTH:PETAL.WIDTH, \(kolumna) min(kolumna)),
  .by = SPECIES)

# data <- dzialanie-1
# data <- dzialania-2
# data <- dzialanie-3

# data_1 <- dzialanie(data)
# data_2 <- dzialanie(data_1)
# data_3 <- dzialanie(data_2)

wektor_liczbowy <- c(1, 2, 3, 4, 5)

wektor_liczbowy <- mean(wektor_liczbowy)

wektor_liczbowy_2 <- mean(c(1, 2, 3, 4, 5))

wektor_liczbowy_3 <- c(1, 2, 3, 4, 5) |>
  # Liczenie sredniej
  mean() |>
  # Liczenie pierwiastka
  sqrt()

# sqrt(mean(c(1, 2, 3, 4, 5)))
