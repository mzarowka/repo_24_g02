# Powtórka; grupa 2, 31.01.2025

# Załaduj paczki {tidyverse}, {readxl}
library(tidyverse)
library(readxl)

# Stwórz jednowymiarowy wektor o pięciu elementach liczbowych
wektor <- c(1, 2, 3, 4, 5)

# Wybierz czwartą i trzecią (w tej kolejności) pozycję w utworzonym wektorze i zapisz jako nowy wektor
wektor[c(3, 4)]

# Wczytaj dane z iris dataset
data <- (iris)

# Wybierz drugą kolumnę i wszystkie wiersze
data[, 2]

# Wybierz czwarty i trzydziesty wiersz oraz wszystkie kolumny - klasyczne indeksowanie
data[c(4, 30), ]

# Wybierz wiersze 4, 8, 22 i kolumny Petal.Length oraz Sepal.Width - klasyczne indeksowanie
data[c(4, 8, 22), c("Petal.Length", "Sepal.Width")]

# Wybierz kolumnę Species korzystając z operatora $
data$Species

# Uwtórz nową kolumnę "Petal.Iloraz" w ramce danych, tak aby była ilorazem Petal.Length i Petal.Width
data$Petal.Iloraz <- data$Petal.Length / data$Petal.Width

# Wczytaj dane z adresu sieciowego, zwróć uwagę na separator
# https://support.staffbase.com/hc/en-us/article_attachments/360009197031/username.csv
data_1 <- read_csv2("https://support.staffbase.com/hc/en-us/article_attachments/360009197031/username.csv")

data_2 <- read_delim("https://support.staffbase.com/hc/en-us/article_attachments/360009197031/username.csv", delim = ";")

# Wczytaj dane z pliku csv na dysku
data_3 <- read_csv("R/data/annual-enterprise-survey-2023-financial-year-provisional.csv")

# Wczytaj dane z pliku excel na dysku, wyraźnie wskaż arkusz
data_4 <- read_excel("R/data/data_msu.xlsx", sheet = 1)

# {dplyr} i {tidyr}

# Wczytaj dane dotyczące pingwinów
pingwinki <- palmerpenguins::penguins

# Zmień nazwę species na gatunek
pingwinki <- rename(pingwinki, gatunek = species)

# Zmień wszystkie nazwy tak aby były pisane wielką literą
rename_with(pingwinki, .cols = everything(), \(nazwy) toupper(nazwy))

# Wybierz kolumny od bill_length_mm do body_mass_g
select(pingwinki, c(bill_length_mm:body_mass_g))

# Wybierz kolumny kończące się na "mm"
select(pingwinki, ends_with("mm"))

# Wybierz kolumny zawierające "th"
select(pingwinki, contains("th"))

# Wybierz kolumny niebędące species
select(pingwinki, -gatunek)

select(pingwinki, !gatunek)

# Wybierz wiersze zawierające gatunek Adelie
filter(pingwinki, gatunek == "Adelie")

# Wybierz wiersze zawierające gatunek Adelie i Gentoo
filter(pingwinki, gatunek %in% c("Adelie", "Gentoo"))

# Wybierz wiersze z wysypy Torgersena dotyczące samic pingwinów
filter(pingwinki, island == "Torgersen" & sex == "female")

# Uwtórz nową kolumnę bill_ratio jako iloraz bill_length_mm do bill_depth_mm
pingwinki <- mutate(pingwinki, bill_ratio = bill_length_mm / bill_depth_mm)

# Utwórz kolumnę id z numerem obserwacji (tip: 1:n())
pingwinki <- mutate(pingwinki, id = 1:n())

# Zlogarytmuj w miejscu kolumnę body_mass_g
pingwinki <- mutate(pingwinki, body_mass_g = log(body_mass_g))

# Oblicz w miejscu pierwiastek ze wszystkich kolumn numerycznych
mutate(pingwinki, across(where(\(nazwa) is.numeric(nazwa)), \(kolumna) sqrt(kolumna)))

# Zgrupuj ramkę ranych na podstawie zmiennej gatunek i wykonaj operację summarise (średnia) dla kolumn bill_length_mm i body_mass_g
group_by(pingwinki, gatunek) |>
  summarise(across(c(bill_length_mm, body_mass_g), \(x) mean(x, na.rm = TRUE)))

# Wykonaj operację summarise (mediana) dla kolumn bill_length_mm i body_mass_g, wskaż zmienną grupującą jako argument .by
summarise(pingwinki, across(c(bill_length_mm, body_mass_g), \(i) median(i, na.rm = TRUE)), .by = island)

# Zmień format ramki na dłuższy, wykorzystaj kolumny bill_length_mm i bill_depth_mm
pivot_longer(pingwinki, c(bill_length_mm, bill_depth_mm), names_to = "nazwa", values_to = "wartosci")

# Zmień format ramki na szerszy, tak aby każda zmienna była wyrażona dla każdej wyspy
pivot_wider(pingwinki, names_from = island, values_from = -id)

# Wczytaj trzy arkusze od Żarczyńskiego
data_5 <- read_excel("R/data/data_msu.xlsx", sheet = "loi")
data_6 <- read_excel("R/data/data_msu.xlsx", sheet = "elemental")
data_7 <- read_excel("R/data/data_msu.xlsx", sheet = "bsi")

# Korzystając z danych geochemicznych połącz ze sobą ramki loi oraz bsi na podstawie zmiennej sample.id - dołącz do lewej
left_join(data_5, data_7, join_by(sample.id == sample.id))

# Korzystając z danych geochemicznych połącz ze sobą ramki elemental oraz bsi na podstawie zmiennej sample.id - dołącz do prawej
right_join(data_6, data_7, join_by(sample.id))

# Korzystając z danych geochemicznych połącz ze sobą wszystkie trzy ramki w sposób całkowity
full_join(data_5, data_6, join_by(sample.id)) |>
  full_join(data_7, join_by(sample.id))


full_join((full_join(data_5, data_6, join_by(sample.id))), data_7, join_by(sample.id))
