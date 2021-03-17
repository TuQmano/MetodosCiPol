#######
#######  workflow para descarga de datos - Clase 5 #MetodosCiPol 2020


library(rtweet) # Collecting Twitter Data, CRAN v0.7.0
library(tidyverse) # Easily Install and Load the 'Tidyverse', CRAN v1.3.0
library(skimr) # Compact and Flexible Summaries of Data, CRAN v2.1.2

# DESCARGO DATOSD DESDE LA API DE Twitter
latinr <- search_tweets(q = "#LatinR2020", n = 2000)

# EXPLORO LA BASE DE DATOS DESCARGADA / Paquete {skimr}
skim(latinr)


# Calculamos cuentas que mas interactividad dieron al hashtag
latinr %>% 
  group_by(screen_name) %>% 
  select(screen_name, favorite_count, retweet_count) %>% 
  summarise(across(where(is.integer), sum)) %>%
  mutate(interacciones = favorite_count + retweet_count) %>% 
  arrange(desc(interacciones)) %>% 
  ungroup() %>% 
  mutate(participacion = round(interacciones/sum(interacciones)*100, 1 ), 
         acumulado = cumsum(participacion)) %>% 
  print(n = 30)

         

latinr %>% 
  select(screen_name, created_at) %>% 
  mutate(mes = lubridate::month(created_at), 
         dia = lubridate::day(created_at)) %>% 
  arrange(created_at) 


