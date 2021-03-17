#### SCRIPT DATA VIZ II
#### 
#### Poroteo LIVE
#### 
#### TuQmano 2 Nov 2020

library(tidyverse) # Easily Install and Load the 'Tidyverse', CRAN v1.3.0
library(googlesheets4) # Access Google Sheets using the Sheets API V4, CRAN v0.2.0
library(janitor) # Simple Tools for Examining and Cleaning Dirty Data, CRAN v2.0.1

gs4_deauth()

datos <- read_sheet(skip = 1, "https://docs.google.com/spreadsheets/d/1TUTag7Majqhn5noRLLMUJ6SFJ0Phwlo-Oc1T59uSZCE/edit")

datos <- datos %>% 
  clean_names()


skimr::skim(datos)


diputados <- datos %>%  
  filter(cargo == "Diputados Nacionales") %>% 
  mutate(decision = str_to_lower(aborto_legal), 
         decision = as.factor(decision)) 

# PLOTS ####


# Totales 
ggplot(diputados %>% 
         group_by(decision) %>% 
         summarise(n = n())) +
  geom_col(aes(x = n, 
               y = fct_reorder(decision, n)))

# Totales x bloque
ggplot(diputados %>% 
         group_by(decision, bloque) %>% 
         summarise(n = n())) +
  geom_col(aes(x = n, 
               y = fct_reorder(decision, n))) +
  facet_wrap(~ bloque)


# Totales por provincia
ggplot(diputados %>% 
         group_by(decision, distrito) %>% 
         summarise(n = n())) +
  geom_col(aes(x = n, 
               y = fct_reorder(decision, n))) +
  facet_wrap(~ distrito)




#### CLASE 8 ####
#### 
#### 
#### 
#### 
#### 


# Totales por provincia
library(polAr)
library(geofacet)
argentina <- get_grid("ARGENTINA")


### Corregir nombre de distritos

table(diputados$distrito)

# Uso stringi:: https://github.com/tidyverse/stringr/issues/149

dipus <- diputados %>% 
  mutate(nombre_provincia = str_to_upper(stringi::stri_trans_general(distrito, 
                                                                        "Latin-ASCII")))


ggplot(dipus %>% 
         group_by(decision, nombre_provincia) %>% 
         summarise(n = n())) +
  geom_col(aes(x = n, 
               y = fct_reorder(decision, n))) +
#  facet_wrap(~ distrito)
  facet_geo(~ nombre_provincia, grid = argentina)
  
