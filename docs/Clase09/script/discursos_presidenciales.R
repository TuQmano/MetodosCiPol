#### DISCURSOS PRESIDENCIALES
#### Por Diego Koslowski
#### https://github.com/DiegoKoz/discursos_presidenciales/blob/master/get_data.R



library(rvest)
library(xml2)
library(tidyverse)
library(glue)
#### funciones #####

get_text <- function(link){
  tryCatch({
    
    pagina <- read_html(link)
    
    texto <- pagina %>% html_nodes('.jm-allpage-in') %>% 
      html_text(.)
    titulo <- pagina %>% html_nodes('strong') %>%
      html_text(.)
    
    df <- tibble(texto=texto, titulo=titulo)
    
    Sys.sleep(1)
    df
    
  },error = function(err) {glue::glue("error_in_link: {link}")})
}

get_new_links <- function(link){
  tryCatch({
    
    base <- link
    nodes <- read_html(link) %>% 
      rvest::html_nodes("a")  
    
    df <- data.frame(link= html_attr(nodes, "href"), titulo = html_text(nodes)) %>% 
      filter(str_detect(link,"informacion/discursos/\\d"),
             link!="") %>% 
      na.omit(.) %>%
      mutate(link = gsub("#.*","",link),
             link= xml2::url_absolute(link, base= base)) %>% 
      distinct(link,.keep_all = TRUE )
    df
  },error = function(err) {glue::glue("error_in_link: {link}")})
}


link <- 'https://www.casarosada.gob.ar/informacion/discursos'

paginas <- c(link, glue('{link}?start={seq(40,600, 40)}'))

paginas_df <- tibble(paginas=paginas) %>% 
  mutate(new_links= map(paginas, get_new_links))

paginas_df <- paginas_df %>% unnest()

## guardo los links

paginas_df %>% 
  write_csv(path = 'links.csv')


paginas_df <- paginas_df %>% 
  mutate(cuerpo = map(link, get_text))


#elimino los fallidos
corpus <- paginas_df %>% 
  mutate(tipo = unlist(map(cuerpo,typeof))) %>% 
  filter(!tipo =='character')

corpus %>% 
  write_rds('download_data.rds')

corpus <- read_rds('data/download_data.rds')

corpus <- corpus %>% 
  mutate(fecha = str_extract(titulo,'(?<=\t[[:blank:]]{2,10})[[:upper:]].*201\\d(?=[[:blank:]]{2,10})'),
         fecha_normalizada = str_extract(fecha, '\\d.*201\\d'),
         fecha_normalizada = str_replace(fecha_normalizada, 'Enero', '01'),
         fecha_normalizada = str_replace(fecha_normalizada, 'Febrero', '02'),
         fecha_normalizada = str_replace(fecha_normalizada, 'Marzo', '03'),
         fecha_normalizada = str_replace(fecha_normalizada, 'Abril', '04'),
         fecha_normalizada = str_replace(fecha_normalizada, 'Mayo', '05'),
         fecha_normalizada = str_replace(fecha_normalizada, 'Junio', '06'),
         fecha_normalizada = str_replace(fecha_normalizada, 'Julio', '07'),
         fecha_normalizada = str_replace(fecha_normalizada, 'Agosto', '08'),
         fecha_normalizada = str_replace(fecha_normalizada, 'Septiembre', '09'),
         fecha_normalizada = str_replace(fecha_normalizada, 'Octubre', '10'),
         fecha_normalizada = str_replace(fecha_normalizada, 'Noviembre', '11'),
         fecha_normalizada = str_replace(fecha_normalizada, 'Diciembre', '12'),
         fecha_normalizada = str_replace_all(fecha_normalizada, 'del?', '-'),
         fecha_normalizada = str_remove_all(fecha_normalizada, ' '),
         fecha_normalizada = lubridate::dmy(fecha_normalizada)) %>% 
  select(link,fecha=fecha_normalizada, cuerpo) %>% 
  unnest()

# hay registros duplicados porque pusieron doble titulo
corpus <- corpus %>% 
  distinct(link,.keep_all = T)

corpus %>% 
  write_rds('data/corpus.rds')


corpus$texto[1]