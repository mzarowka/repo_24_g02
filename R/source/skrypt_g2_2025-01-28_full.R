# 2025-01-28

# Załadowanie paczek
library(tidyverse)

# Wczytanie danych
data <- iris

# Dodaj id
data <- data |>
  dplyr::mutate(id = 1:dplyr::n())

# Zmien nazwy na małe
data <- data |>
  dplyr::rename_with(.cols = dplyr::everything(), \(i) tolower(i))

# Pivotowanie ####
# Długi format
data_long <- data |>
  tidyr::pivot_longer(
    -c(species, id),
    names_to = "variable",
    values_to = "value"
  )

# Szeroki format
data_wide <- data_long |>
  tidyr::pivot_wider(
    id_cols = c(id, species),
    names_from = variable,
    values_from = value
  )

# Po co to? Szybki ggplot2
# Kolorowanie według kolumny
data |>
  ggplot2::ggplot(ggplot2::aes(id, petal.length, color = species)) +
  ggplot2::geom_line()

# Rozbicie na panele
data |>
  ggplot2::ggplot(ggplot2::aes(id, petal.length, color = species)) +
  ggplot2::geom_line() +
  ggplot2::facet_wrap(dplyr::vars(species))

# Puste wartości ####
# Dodaj wartość NA w 49 i 68 wierszu, w 3 kolumnie, zapisz nową ramkę danych
data_na <- data

data_na[c(49, 68), 3] <- NA_real_

# Porzuć wiersze z wartościami NA
data_na <- data_na |>
  tidyr::drop_na()

# Joins - operacje na ramkach ####
# Wylistowanie dostępnych arkuszy w pliku excel
readxl::excel_sheets("D:/git/teaching/przetwarzanie/repo_24_g01/data_msu.xlsx")

data_1 <- readxl::read_excel(
  "D:/git/teaching/przetwarzanie/repo_24_g01/data_msu.xlsx",
  sheet = "loi"
)

data_2 <- readxl::read_excel(
  "D:/git/teaching/przetwarzanie/repo_24_g01/data_msu.xlsx",
  sheet = "elemental"
)

data_3 <- readxl::read_excel(
  "D:/git/teaching/przetwarzanie/repo_24_g01/data_msu.xlsx",
  sheet = "bsi"
)


# Łączenie ramek (mutating join)
# Left join
dane_left_1 <- dplyr::left_join(x = data_1, y = data_2)

dane_left_2 <- dplyr::left_join(x = data_1, y = data_3)

dane_left_3 <- dplyr::left_join(
  x = data_1,
  y = data_3,
  by = dplyr::join_by(sample.id == sample.id)
)

dane_left_4 <- dplyr::left_join(
  dplyr::select(data_1, -mass.mg),
  dplyr::rename(data_3, nazwa.id = sample.id),
  by = dplyr::join_by(sample.id == nazwa.id)
)

data_left_5 <- dplyr::left_join(
  data_1,
  data_2,
  by = dplyr::join_by(sample.id)
) |>
  dplyr::left_join(x = _, y = data_3, by = dplyr::join_by(sample.id))

# Łączenie do prawej ramki
data_right_1 <- dplyr::right_join(x = data_1, y = data_2)

data_right_2 <- dplyr::right_join(
  data_3,
  data_1,
  by = dplyr::join_by(sample.id)
) |>
  dplyr::right_join(data_2, by = dplyr::join_by(sample.id))

# Łączenie wszystkiego - inner
data_inner_1 <- dplyr::inner_join(x = data_1, y = data_2)

# Szalone nutki
data_szalone <- dplyr::inner_join(
  data_1,
  data_3,
  by = dplyr::join_by(sample.id)
) |>
  dplyr::right_join(data_right_1)

# Łączenie wszystkiego - full join
data_full_1 <- dplyr::full_join(data_1, data_2)

# Semi join
data_semi_1 <- dplyr::semi_join(data_1, data_2)

# Anti join
data_anti_1 <- dplyr::anti_join(data_3, data_1)
