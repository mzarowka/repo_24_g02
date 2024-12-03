# Skrypt dzien pierwszy

# Zaladuj biblioteki/paczki
library(tidyverse)

# Dane z internetu
dane_internet <- readr::read_csv("https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv")

# Dane z dysku - sciezka bezwzgledna
dane_dysk_01 <- readr::read_csv("C:/GitHub/teaching/repo_24_g02/R/data/annual-enterprise-survey-2023-financial-year-provisional.csv")

# Dane z dysku - sciezka wzgledna
dane_dysk_02 <- readr::read_csv("R/data/annual-enterprise-survey-2023-financial-year-provisional.csv")

# Zmiana kolumny tekst na liczbę
dane_dysk_02$Value <- as.numeric(dane_dysk_02$Value)

# Parsowanie tekstu na liczbę
dane_dysk_01$Value <- readr::parse_number(dane_dysk_01$Value)

# Sprawdzenie wiersa 748
dane_internet[748, "Value"]
