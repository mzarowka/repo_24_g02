# ggplot intro 31.01.2025

# Paczki
library(tidyverse)

# Dane hydrochemiczne
zab_hydrochemia <- read_csv("R/data/zab_data/zab_hydrochemistry-lake.csv") |>
  mutate(date = lubridate::ymd(date))

# Wykres: x = czas, y = wartosc Ca
ggplot(zab_hydrochemia, aes(date, ca)) +
  geom_line()

# Wykres: x = czas, y = wartosc Ca - serie pokolorwane - głębokość
ggplot(zab_hydrochemia, aes(date, ca, color = depth)) +
  geom_line()

# Wykres: x = czas, y = wartosc Ca - serie pokolorwane - głębokość jako wartosci dyskretne
ggplot(zab_hydrochemia, aes(date, ca, color = as.factor(depth))) +
  geom_line()

# Wykres: x = czas, y = wartosc Ca - serie pokolorwane - głębokość jako wartosci dyskretne
ggplot(zab_hydrochemia, aes(date, ca, color = as.factor(depth))) +
  geom_line() +
  facet_wrap(dplyr::vars(depth))

# Wykres: x = czas, y = wartosc Ca - serie pokolorwane - głębokość jako wartosci dyskretne
ggplot(zab_hydrochemia, aes(date, ca, color = as.factor(depth))) +
  geom_line() +
  facet_wrap(dplyr::vars(depth), ncol = 1)

# Wykres: x = czas, y = wartosc Ca - serie pokolorwane - głębokość jako wartosci dyskretne. Brak tła, linie osi itd.
ggplot(zab_hydrochemia, aes(date, ca, color = as.factor(depth))) +
  geom_line() +
  facet_wrap(dplyr::vars(depth), ncol = 1) +
  theme(panel.background = element_blank())

# Wykres: x = czas, y = wartosc Ca - serie pokolorwane - głębokość jako wartosci dyskretne. Brak tła, linie osi itd.
ggplot(zab_hydrochemia, aes(date, ca, color = as.factor(depth))) +
  geom_line() +
  scale_color_viridis_d() +
  facet_wrap(dplyr::vars(depth), ncol = 1) +
  theme(panel.background = element_blank()) +
  labs(x = "Data ratatata", y = "Ca (mg/L)", title = "Wykres fajny", subtitle = "nie do końca", color = "Głębokość (m)")

# Wczytaj dane zab_temperature_daily
zab_temp <- read_csv("R/data/zab_data/zab_temperature-daily.csv") |>
  mutate(day = lubridate::ymd(day))

# Wykres temperatury wody w czasie, temperatura na pierwszym metrze, punkty, linia, wygładzone
ggplot(zab_temp, aes(day, temp_01)) +
  geom_point() +
  geom_line() +
  geom_smooth()

ggplot(zab_temp, aes(day, temp_01)) +
  geom_point() +
  geom_line(color = "red")


# Wykres z seriami rozbitymi na panele, wszystkie głębokości
zab_temp |>
  pivot_longer(cols = -day, names_to = "glebokosc", values_to = "temperatura") |>
  ggplot(aes(day, temperatura)) +
  geom_line() +
  facet_wrap(vars(glebokosc))

zab_temp |>
  pivot_longer(cols = -day, names_to = "glebokosc", values_to = "temperatura") |>
  ggplot(aes(day, temperatura)) +
  geom_line() +
  facet_wrap(vars(glebokosc), ncol = 1, scales = "free")

# Wczytaj dane dotyczące pułapki sedymentacyjnej

# Wykres kolumnowy tempa akumulacji masy

# Tu umiałem ale nie słyszę co mówią studenci

# Boxplot

# Violinplot

# Histogram
