####   Snippets de código
####   Misceláneos


####  1. CONECTAR A UNA BASE DE DATOS  (de "Importar Datos")
####  Documentacion DB https://tuqmano.github.io/MetodosCiPol/Clase03/Clase3.html#15
####  Presentación https://tuqmano.github.io/MetodosCiPol/Clase04/Clase4.html#33


library(DBI)
library(RSQLite)
library(odbc)

setwd("docs/Clase05/extra_data_and_script/")

Arg03<- dbConnect(odbc::odbc(),
                  driver = "SQLite3 ODBC Driver",
                  database="2003.sqlite3")

setwd("../../..")


####  2.  "Transformar Datos" desde dataset SQL via Connections

DEPTOS <- tbl(Arg03, "Departamento")%>% 
  filter(dep_proCodigoProvincia == "23")

MESAS_PRESI <- tbl(Arg03, "MesasPresidente") %>% 
  filter(mes_proCodigoProvincia == "23")

totales_tucuman <- MESAS_PRESI  %>% 
  group_by(mes_depCodigoDepartamento) %>% 
  select(-mesEstado) %>% 
  summarise_if(is.numeric, sum) %>% 
  print(n = Inf)

#### 3. Datos Relacionales 

totales_tucuman %>% 
  left_join(DEPTOS)

#,by = c("mes_depCodigoDepartamento" = "depCodigoDepartamento")



