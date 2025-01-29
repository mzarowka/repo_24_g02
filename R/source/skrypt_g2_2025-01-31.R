# Powtórka; grupa 2, 31.01.2025

# Załaduj paczki {tidyverse}, {readxl}

# Stwórz jednowymiarowy wektor o pięciu elementach liczbowych

# Wybierz czwartą i trzecią (w tej kolejności) pozycję w utworzonym wektorze i zapisz jako nowy wektor

# Wczytaj dane z iris dataset

# Wybierz drugą kolumnę i wszystkie wiersze

# Wybierz czwarty i trzydziesty wiersz oraz wszystkie kolumny - klasyczne indeksowanie

# Wybierz wiersze 4, 8, 22 i kolumny Petal.Length oraz Sepal.Width - klasyczne indeksowanie

# Wybierz kolumnę Species korzystając z operatora $

# Uwtórz nową kolumnę "Petal.Iloraz" w ramce danych, tak aby była ilorazem Petal.Length i Petal.Width

# Wczytaj dane z adresu sieciowego, zwróć uwagę na separator
# https://support.staffbase.com/hc/en-us/article_attachments/360009197031/username.csv

# Wczytaj dane z pliku csv na dysku

# Wczytaj dane z pliku excel na dysku, wyraźnie wskaż arkusz

# {dplyr} i {tidyr}

# Wczytaj dane dotyczące pingwinów

# Zmień nazwę species na gatunek

# Zmień wszystkie nazwy tak aby były pisane wielką literą

# Wybierz kolumny od bill_length_mm do body_mass_g

# dane12 <- pingwiny |> select(bill_length_mm:body_mass_g)

# Wybierz kolumny kończące się na "mm"

# Wybierz kolumny zawierające "th"

# Wybierz kolumny niebędące species

# Wybierz wiersze zawierające gatunek Adelie

# Wybierz wiersze z wysypy Torgersena dotyczące samic pingwinów

# Uwtórz nową kolumnę bill_ratio jako iloraz bill_length_mm do bill_depth_mm

# Utwórz kolumnę id z numerem obserwacji (tip: 1:n())

# Zlogarytmuj w miejscu kolumnę body_mass_g

# Oblicz w miejscu pierwiastek ze wszystkich kolumn numerycznych

# Zgrupuj ramkę ranych na podstawie zmiennej gatunek i wykonaj operację summarise (średnia) dla kolumn bill_length_mm i body_mass_g

# Wykonaj operację summarise (mediana) dla kolumn bill_length_mm i body_mass_g, wskaż zmienną grupującą jako argument .by

# Zmień format ramki na dłuższy, wykorzystaj kolumny bill_length_mm i bill_depth_mm

# Zmień format ramki na szerszy, tak aby każda zmienna była wyrażona dla każdej wyspy

# Korzystając z danych geochemicznych połącz ze sobą ramki loi oraz bsi na podstawie zmiennej sample.id - dołącz do lewej

# Korzystając z danych geochemicznych połącz ze sobą ramki elemental oraz bsi na podstawie zmiennej sample.id - dołącz do prawej

# Korzystając z danych geochemicznych połącz ze sobą wszystkie trzy ramki w sposób całkowity
