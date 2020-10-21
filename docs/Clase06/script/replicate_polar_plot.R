
library(polAr)
library(tidyverse)

get_election_data("arg", "presi", "gral", 2019) %>% 
  plot_results( national = T)



ggplot(data = tucuman_dip_gral_2017 %>% 
         get_names(), aes(x = round(votos/sum(votos)*100,1), 
                          y = fct_reorder(nombre_lista, votos))) +
  geom_col(aes(fill = nombre_lista)) +
  geom_text(aes(label = nombre_lista), hjust = "inward") +
  labs(title = "TUCUMAN - 2017", 
       subtitle = "Elección General - Diputado Nacional", 
       caption = "Fuente: polAr - Política Argentina usando R", 
       y = "", 
       x = "") +
  ggthemes::theme_fivethirtyeight() +
  theme(axis.text.y =  element_blank(), 
        axis.ticks.y = element_blank(), 
        legend.position = "none") 

