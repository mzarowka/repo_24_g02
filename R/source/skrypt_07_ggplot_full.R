# ggplot intro 31.01.2025

# Paczki
library(tidyverse)

# Dane hydrochemiczne
zab_hydrochemia <- readr::read_csv("R/data/zab_data/zab_hydrochemistry-lake.csv") |>
  dplyr::mutate(date = lubridate::ymd(date))

# Wykres: x = czas, y = wartosc Ca
ggplot2::ggplot(zab_hydrochemia, ggplot2::aes(date, ca)) +
  ggplot2::geom_line()

# Wykres: x = czas, y = wartosc Ca - serie pokolorwane - głębokość
ggplot2::ggplot(zab_hydrochemia, ggplot2::aes(date, ca, color = depth)) +
  ggplot2::geom_line()

# Wykres: x = czas, y = wartosc Ca - serie pokolorwane - głębokość jako wartosci dyskretne
ggplot2::ggplot(zab_hydrochemia, ggplot2::aes(date, ca, color = factor(depth))) +
  ggplot2::geom_line()

# Wykres: x = czas, y = wartosc Ca - serie pokolorwane - głębokość jako wartosci dyskretne
ggplot2::ggplot(zab_hydrochemia, ggplot2::aes(date, ca, color = factor(depth))) +
  ggplot2::geom_line() +
  ggplot2::facet_wrap(dplyr::vars(depth))

# Wykres: x = czas, y = wartosc Ca - serie pokolorwane - głębokość jako wartosci dyskretne
ggplot2::ggplot(zab_hydrochemia, ggplot2::aes(date, ca, color = factor(depth))) +
  ggplot2::geom_line() +
  ggplot2::facet_wrap(dplyr::vars(depth), ncol = 1)

# Wykres: x = czas, y = wartosc Ca - serie pokolorwane - głębokość jako wartosci dyskretne. Brak tła, linie osi itd.
ggplot2::ggplot(zab_hydrochemia, ggplot2::aes(date, ca, color = factor(depth))) +
  ggplot2::geom_line() +
  ggplot2::facet_wrap(dplyr::vars(depth), ncol = 1) +
  ggplot2::theme_dark()

# Wykres: x = czas, y = wartosc Ca - serie pokolorwane - głębokość jako wartosci dyskretne. Brak tła, linie osi itd.
ggplot2::ggplot(zab_hydrochemia, ggplot2::aes(date, ca, color = factor(depth))) +
  ggplot2::geom_line() +
  ggplot2::facet_wrap(dplyr::vars(depth), ncol = 1) +
  ggplot2::theme(panel.background = ggplot2::element_blank())

ggplot2::ggplot(zab_hydrochemia, ggplot2::aes(date, ca, color = factor(depth))) +
  ggplot2::geom_line() +
  ggplot2::facet_wrap(dplyr::vars(depth), ncol = 1) +
  ggplot2::scale_color_viridis_d() +
  ggplot2::labs(x = "Data", y = "Ca (mg/L)", color = "Głębokość (m)") +
  ggplot2::theme(panel.background = ggplot2::element_blank(), legend.position = "bottom", strip.background = ggplot2::element_blank())

# Wczytaj dane zab_temperature_daily
zab_temp <- readr::read_csv("R/data/zab_data/zab_temperature-daily.csv") |>
  dplyr::mutate(day = lubridate::ymd(day))

# Wykres temperatury wody w czasie, temperatura na pierwszym metrze, punkty, linia, wygładzone
ggplot2::ggplot(zab_temp, ggplot2::aes(day, temp_01)) +
  ggplot2::geom_point() +
  ggplot2::geom_line(color = "red") +
  ggplot2::geom_smooth()

ggplot2::ggplot(zab_temp, ggplot2::aes(day, temp_01)) +
  ggplot2::geom_point() +
  ggplot2::geom_line(color = "red") +
  ggplot2::geom_smooth() +
  ggplot2::labs(x = "Data", y = "Temperatura (C)", title = "Temperatura wody", subtitle = "Na głebokości 1 m")

# Wykres z seriami rozbitymi na panele, wszystkie głębokości
zab_temp |>
  tidyr::pivot_longer(cols = dplyr::starts_with("temp_"), names_to = "glebokosc", values_to = "temperatura") |>
  ggplot2::ggplot(ggplot2::aes(day, temperatura)) +
  ggplot2::geom_line() +
  ggplot2::facet_wrap(dplyr::vars(glebokosc), ncol = 1, scales = "free")

# Wczytaj dane dotyczące pułapki sedymentacyjnej
zab_trap <- readr::read_csv("R/data/zab_data/zab_sediment-trap_hypolimnion.csv") |> dplyr::mutate(date = lubridate::ymd(date))

# Wykres kolumnowy tempa akumulacji masy
zab_trap |>
  ggplot2::ggplot(ggplot2::aes(date, mar)) +
  ggplot2::geom_col()

# Tu umiałem ale nie słyszę co mówią studenci
zab_trap |>
  ggplot2::ggplot() +
  ggplot2::geom_rect(ggplot2::aes(xmin = dplyr::lag(date), xmax = date, ymin = 0, ymax = mar, fill = as.factor(lubridate::year(date))))

# Boxplot
ggplot2::ggplot(zab_hydrochemia) + ggplot2::geom_boxplot(ggplot2::aes(as.factor(depth), ca))

# Violinplot
ggplot2::ggplot(zab_hydrochemia) + ggplot2::geom_violin(ggplot2::aes(as.factor(depth), ca))

# Histogram
ggplot2::ggplot(zab_hydrochemia) + ggplot2::geom_histogram(ggplot2::aes(ca))
ggplot2::ggplot(zab_hydrochemia) + ggplot2::geom_histogram(ggplot2::aes(ca, fill = factor(depth)))

