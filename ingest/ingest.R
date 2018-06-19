
library(tidyverse)
library(readxl)

# South sudan is NA for members_oecd_g77, is part of G77
# Chile is part of both OECD and G77
# Holy See lacks information, not really a country for sensible purposes

income_remap <- c(
    "Low income"="low", "Lower middle income"="lower_mid", 
    "Upper middle income"="upper_mid", "High income"="high")


geo <- read_xlsx("geography.xlsx", "List of countries") %>%
    filter(name != "Holy See") %>%
    mutate(
        oecd = !is.na(members_oecd_g77) & (members_oecd_g77 == "oecd" | name == "Chile"),
        g77 = is.na(members_oecd_g77) | members_oecd_g77 == "g77"
    ) %>%
    select(name, region=four_regions, oecd, g77, lat=Latitude, long=Longitude, 
        income2017=`World bank income group 2017`) %>%
    mutate(income2017 = income_remap[income2017])


write_csv(geo, "../r-intro-2-files/geo.csv")


# Exclude countries not in geo
# Exclude projections (data is from 2017)
pop <- read_xlsx("population.xlsx", "Data countries etc by year") %>%
    select(-geo) %>%
    filter(
        name %in% geo$name, 
        year <= 2017)


# Exclude projections
# Exclude countries not in geo (there were 9)
gdp <- read_xlsx("gdp.xlsx", "countries_and_territories") %>%
    select(-indicator.name, -geo, -indicator) %>%
    rename(name=geo.name) %>%
    gather(key=year, value=gdp_percap, -name) %>%
    mutate(year=as.integer(year)) %>%
    filter(
        year <= 2017,
        !is.na(gdp_percap),
        name %in% geo$name)


# Exclude projections
# Exclude countries not in geo (there were 79, eg USSR)
lex <- read_xlsx("lex.xlsx", "countries_and_territories") %>%
    select(-indicator.name, -geo, -indicator) %>%
    rename(name=geo.name) %>%
    gather(key=year, value=life_exp, -name) %>%
    mutate(year=as.integer(year)) %>%
    filter(
        year <= 2017,
        !is.na(life_exp),
        name %in% geo$name)


# Yearly produced ugly ggplot, filter down to per-decade
combined <- pop %>%
    full_join(gdp, by=c("name","year")) %>%
    full_join(lex, by=c("name","year")) %>%
    #mutate(year=as.integer(year), population=as.integer(population)) %>%
    filter(year %% 10 == 0) %>%
    arrange(year)

combined %>%
mutate(
    year=sprintf("%d",year),
    population=sprintf("%.1f",population),
    gdp_percap=sprintf("%.1f",gdp_percap)) %>%
write_csv("../r-intro-2-files/gap-minder.csv")


co2 <- read_xlsx("co2_percap.xlsx", "Data")
colnames(co2) <- c("name", colnames(co2)[-1] %>% as.integer %>% as.character)

write_csv(co2, "../r-intro-2-files/co2_percap.csv")




