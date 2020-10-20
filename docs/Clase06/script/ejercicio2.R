require(readr)  # for read_csv()
require(dplyr)  # for mutate()
require(tidyr)  # for unnest()
require(purrr)  # for map()


files <- dir(pattern = "*.csv", path="docs/Clase05/datos/00.PRESIDENCIAL/", full.names = T) %>% 
  tibble::enframe(name = NULL)

data <- files %>%
  mutate(datos = map(.x = value, .f = read_csv), 
         long = map2(.x = value, .y = datos, 
                     .f = ~ pivot_longer(data = .y, 
                                         names_to = "listas", values_to = "votos", 
                                         cols = c(dplyr::matches("\\d$"), blancos, nulos)))
         ) 



bind_rows(data$long) 
