# Powtórka; grupa 2, 31.01.2025

# Załaduj paczki {tidyverse}, {readxl}
library(tidyverse)
library(readxl)

# Stwórz jednowymiarowy wektor o pięciu elementach liczbowych
wektor <- c(5, 8, 11, 9, 6)

# Wybierz czwartą i trzecią (w tej kolejności) pozycję w utworzonym wektorze i zapisz jako nowy wektor
wektor[c(4, 3)]

# Wczytaj dane z iris dataset
data <- iris

# Wybierz drugą kolumnę i wszystkie wiersze
data[, 2]

# Wybierz czwarty i trzydziesty wiersz oraz wszystkie kolumny - klasyczne indeksowanie
data[c(4, 30), ]

# Wybierz wiersze 4, 8, 22 i kolumny Petal.Length oraz Sepal.Width - klasyczne indeksowanie
data[c(4, 8, 22), c("Petal.Length", "Sepal.Width")]

# Wybierz kolumnę Species korzystając z operatora $
data$Species

# Uwtórz nową kolumnę "Petal.Iloraz" w ramce danych, tak aby była ilorazem Petal.Length i Petal.Width
data$Petal.Iloraz <- data$Petal.Length * data$Petal.Width

# Wczytaj dane z adresu sieciowego, zwróć uwagę na separator
# https://support.staffbase.com/hc/en-us/article_attachments/360009197031/username.csv
data_web <- readr::read_csv2("https://support.staffbase.com/hc/en-us/article_attachments/360009197031/username.csv")

# lub
data_web2 <- readr::read_delim("https://support.staffbase.com/hc/en-us/article_attachments/360009197031/username.csv", delim = ";")

# Wczytaj dane z pliku csv na dysku
dane_csv <- readr::read_csv("R/data/annual-enterprise-survey-2023-financial-year-provisional.csv")

# Wczytaj dane z pliku excel na dysku, wyraźnie wskaż arkusz
dane_xl <- readxl::read_excel("R/data/data_msu.xlsx", sheet = "loi")

# {dplyr} i {tidyr}

# Wczytaj dane dotyczące pingwinów
pingwiny <- palmerpenguins::penguins

# Zmień nazwę species na gatunek
pingwiny <- pingwiny |> dplyr::rename(gatunek = species)

# Zmień wszystkie nazwy tak aby były pisane wielką literą
pingwiny_d <- pingwiny |> dplyr::rename_with(.cols = dplyr::everything(), \(nazwy) toupper(nazwy))


# Wybierz kolumny od bill_length_mm do body_mass_g
pingwiny |> dplyr::select(bill_length_mm:body_mass_g)

# Wybierz kolumny kończące się na "mm"
pingwiny |> dplyr::select(dplyr::ends_with("mm"))

# Wybierz kolumny zawierające "th"
pingwiny |> dplyr::select(dplyr::contains("th"))

# Wybierz kolumny niebędące species
pingwiny |> dplyr::select(-gatunek)

# lub
pingwiny |> dplyr::select(!gatunek)

# Wybierz wiersze zawierające gatunek Adelie
pingwiny |> dplyr::filter(gatunek == "Adelie")

# lub
pingwiny |> dplyr::filter(gatunek %in% "Adelie")

# Wybierz wiersze z wysypy Torgersena dotyczące samic pingwinów
pingwiny |> dplyr::filter(sex == "female" & island == "Torgersen")


# Uwtórz nową kolumnę bill_ratio jako iloraz bill_length_mm do bill_depth_mm
pingwiny <- pingwiny |>
  dplyr::mutate(bill_ratio = bill_length_mm / bill_depth_mm)

# Utwórz kolumnę id z numerem obserwacji (tip: 1:dplyr::n())
pingwiny <- pingwiny |>
  dplyr::mutate(id = 1:dplyr::n())

# Zlogarytmuj w miejscu kolumnę body_mass_g
pingwiny |>
  dplyr::mutate(body_mass_g = log(body_mass_g))

# Oblicz w miejscu pierwiastek ze wszystkich kolumn numerycznych
pingwiny |> dplyr::mutate(dplyr::across(dplyr::where(\(col) is.numeric(col)), \(col) sqrt(col)))

# Zgrupuj ramkę ranych na podstawie zmiennej gatunek i wykonaj operację dplyr::summarise (średnia) dla kolumn bill_length_mm i body_mass_g
pingwiny |>
  dplyr::group_by(gatunek) |>
  dplyr::summarise(dplyr::across(c(bill_length_mm, body_mass_g), \(col) mean(col, na.rm = TRUE))) |>
  dplyr::ungroup()


# Wykonaj operację dplyr::summarise (mediana) dla kolumn bill_length_mm i body_mass_g, wskaż zmienną grupującą jako argument .by
pingwiny |>
  dplyr::summarise(dplyr::across(c(bill_length_mm, body_mass_g), \(col) stats::median(col, na.rm = TRUE)), .by = gatunek)

# Zmień format ramki na dłuższy, wykorzystaj kolumny bill_length_mm i bill_depth_mm
pingwiny |>
  tidyr::pivot_longer(c(bill_length_mm, bill_depth_mm), names_to = "dziob", values_to = "value")

# Zmień format ramki na szerszy, tak aby każda zmienna była wyrażona dla każdej wyspy
pingwiny |>
  tidyr::pivot_wider(names_from = island, values_from = -id)

# Korzystając z danych geochemicznych połącz ze sobą ramki loi oraz bsi na podstawie zmiennej sample.id - dołącz do lewej
data_1 <- readxl::read_excel("R/data/data_msu.xlsx", sheet = "loi")

data_2 <- readxl::read_excel("R/data/data_msu.xlsx", sheet = "elemental")

data_3 <- readxl::read_excel("R/data/data_msu.xlsx", sheet = "bsi")

data_1.3 <- dplyr::left_join(data_1, data_3, dplyr::join_by(sample.id))

# Korzystając z danych geochemicznych połącz ze sobą ramki elemental oraz bsi na podstawie zmiennej sample.id - dołącz do prawej
data_2.3 <- dplyr::right_join(data_2, data_3, dplyr::join_by(sample.id))


# Korzystając z danych geochemicznych połącz ze sobą wszystkie trzy ramki w sposób całkowity
data_1.2.3 <- dplyr::full_join(data_1, data_2, dplyr::join_by(sample.id)) |>
  dplyr::full_join(data_3, dplyr::join_by(sample.id))
