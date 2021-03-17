################################################
################################################

###  MetodosCiPol                 ##############
###  Clase 10: Minería de Texto   ##############
###  Juan Pablo Ruiz Nicolini     ##############
###  17 de noviembre de 2020      ##############            

##############################################
################################################

# Cargo librerias

library(tm) # Text Mining Package, CRAN v0.7-7
library(topicmodels) # Topic Models, CRAN v0.2-11
library(tidytext) # Text Mining using 'dplyr', 'ggplot2', and Other Tidy Tools, CRAN v0.2.5
library(polAr) # Argentina Political Analysis, CRAN v0.2.0
library(tidyverse) # Easily Install and Load the 'Tidyverse', CRAN v1.3.0



### EXPLORO DISCURSOS DISPONIBLES

show_available_speech()


### ME QUEDO CON LOS DE NK y CSM

nk_csm <- show_available_speech() %>% 
  filter(president %in% c("nestor_kirchner", "carlos_menem")) %>% 
  pull(year)


# DESCARGO LOS DISCURSOS 


anios <- enframe(x = nk_csm, # Armo data frame con años que quiero descargar discursos
        name = NULL,
        value = "year") 
  

# Recurrimos a {purrr} para descargar todos juntos

discursos <- map_df(.x = anios$year, 
                    .f = ~ get_speech(.)) # TIDY

#################################
# Vamos por el camino largo!!!
# ################################
discursos_crudos <- map_df(.x = anios$year,
                           .f = ~ get_speech(., raw = TRUE)) # RAW

# EXPLORAMOS DISCURSO COMPLETO
discursos_crudos$discurso[1]

##################################################
# LIMPIEMOS UNO PARA LLEVARLO A TIDY TEXT

tidy <- discursos_crudos %>% 
  slice(1) %>%  
  unnest_tokens(output = palabras,
                input = discurso) 

#exploremos: Discurso de CSM en 1990

tidy # 7690 palabras

tidy %>% 
  group_by(palabras) # 2299 palabras unicas

tidy %>% 
  group_by(palabras) %>% 
  count() #frecuencia de palabras

# VISUALMENTE
wordcloud2::wordcloud2(tidy %>% 
                         group_by(palabras) %>% 
                         count())


tidy %>% 
  group_by(palabras) %>% 
  count() %>% 
  arrange(desc(n))


### LIMPIEMOS DISCURSO

# Bolsa de palabras para limpiar

stopwords <- read_csv("docs/Clase10/data/stopwords_es.txt") %>% 
  rename(word = value)

stopwords


discurso_sin_stopwords <- tidy %>%
  rename(value = palabras) %>% 
  anti_join(stopwords, by =  "value")   # ANTI JOIN (exclusion)  3573 palabras sin stopwords 

# revisamos visualmente la versión limpia
wordcloud2::wordcloud2(discurso_sin_stopwords %>% 
                         group_by(value) %>% 
                         count())



###### N GRAMAS ###############

nk2004 <- discursos_crudos %>% 
  filter(anio == 2004)  
  

nk2004 %>% 
  unnest_tokens(input = discurso, 
                output = "tokens",
                token = "ngrams", 
                n = 3)


### TF - IDF

discursos_tf_idf <- discursos_crudos %>% 
  unnest_tokens(output = palabras,
                input = discurso) %>% 
  rename(word = palabras) %>% 
  anti_join(stopwords) %>% 
# filter(!word %in% stopwords::stopwords("es", "stopwords-iso")) %>% 
  count(anio, word) %>% 
  print() # NECESITAMOS MAS LIMPIEZA QUE LAS STOPWORDS / ELIMINAR NUMEROS! 

### EJERCICIO: BUSCAR FUNCION PARA ELIMINAR ESAS FILAS (buscar en {tm})


#####

discursos_tf_idf %>% 
  bind_tf_idf(word, anio, n) 








