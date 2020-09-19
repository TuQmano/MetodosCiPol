###############################
#     Tuercas & Tornillos
#     CLASE 2: Intro a R
#     Juan Pablo Ruiz Nicolini
#     22/09/2020
###############################

# Basado en script de G.Feierherd
# https://github.com/feierherd/R-code-for-teaching/blob/master/An%20intro%20to%20R.R


#################################################
## PREÁMBULO: secuencia de comandos y consola
################################################## ######

# R es una herramienta para manipulación de datos, cálculo y gráficos
# Es un software de código abierto (es decir, gratuito) mantenido por la comunidad R.

# R funciona 
# 1. Escribiendo el código en la consola (al lado del signo 'mayor que')
# 2. O escribiendo en un script (como este) y enviando las líneas de código a la consola.

# Para Windows: use Ctrl-R para enviar texto desde el Editor a la consola
# Para Mac: use Comando-Intro para enviar texto a la Consola

# A menos que esté trabajando en cálculos muy simples, escribir en el editor y guardar el código
# como un script que utiliza una extensión de archivo ".R".

# Cada línea que comienza con '#' es ignorada por la consola (análoga a * o // en Stata).
# Para agregar comentarios al código sin generar errores de sintaxis.
# De hecho, el primer consejo es que el código sea MUY comentado para que pueda entender
# si tuvieras que volver más tarde (Esto es MUY importante) o que alguien más que uno pueda entenderlo



################################################## ######
## R como calculadora
################################################## ######

2 + 18

50821/6

21 ^ 4

log (4) / 9 ^ 2


################################################## ######
## OBJETOS
################################################## ######



# R es un lenguaje de programación orientado a objetos (como JAVA o C)

# Un objeto es la composición de sustantivos (datos tales como números, cadenas o variables)
# y verbos (como funciones).

# Se puede almacenar un objeto para su recuperación posterior utilizando "<-" como operador de asignación
# (atajo mac: alt y - al mismo tiempo.  atajo pc: ctrl y - al mismo tiempo).

a <- 2 + 18
a

b <- 50821/6
b

mi.nombre =  "TuQmano"



# Notar que  = es equivalente a <- pero que <- hace que el mecanismo de asignación sea más claro al leerlo

## el comando ls ()  sirve para ver qué objetos están almacenados actualmente en el entorno R

ls ()

## Use el comando rm () para deshacerse de un objeto particular almacenado

rm (mi.nombre)
ls ()

## Use el comando rm (list = ls ()) para deshacerse de todos los objetos almacenados

rm (list = ls ())


R <- 1; Stata = 0 
# Porque es gratis, más flexible y tiene excelentes gráficos
# (y se puede usar Comando-enter para enviar texto a la consola)

## En R, cada "objeto" tiene una "clase", que indica su tipo abstracto

numero1 <- 2
numero1 # este es un "tipo de datos" NUMÉRICO
class (numero1)

R <- "¡diversión! <- NERD"
# este es un "tipo de datos" de Caacteres (string, character)
class (R)

boleano <- TRUE


# esto es un "tipo de datos" LÓGICO
class (boleano)


#!is.logical(boleano)

x <- 0
y <- 2
# ---------
z <- x>y
z #FALSO 

# Se puede ejecutra una variedad de operadores boleanos (> <  &  | ==)
# Notar la diferencia entre "="  y "=="



## Importante!!! Nota: No nombrar objetos como "mean" o "sum" o "7" ya que esas son
## cosas que R ya tiene pre empaquetadas.

# Se pueden crear objetos más "largos·, como vectores, que creamos con c (), para concatenar.

vector1 <- c (2, 2, 7, -1, 4)
vector1

R <- c ("Aprender","a","usar" ,"R")
R



mi.nombre <- "TuQmano"


paste(R, mi.nombre)

R2 <- "Aprender a usar R,"

paste (R2,mi.nombre)



## R realiza operaciones matemáticas en objetos numéricos

vector2 <- c (2,5,1,3,2)

vector1 + vector2



vec1 <- vector1
vec2 <- vector2



vec1 - vec2

3 * vec2

vec2 * 3

## Trucos para crear vectores

vec3 <- 1: 5 # usa números enteros del 1 al 5
vec3


vec4 <- c (1: 5, 7, 11) # enteros de 1 a 5, luego 7 y 11.
vec4


vector.1 <- c (1,2,3,4)
vector.2 <- c (100,99,98,97)


cbind (vector.1, vector.2) #  Sumar filas (rows -> r bind)
rbind (vector.1, vector.2) # Sumar columnas (col -> c bind)


#Matriz de 4x2
mat4x2 <- cbind (vector.1, vector.2) 
colnames(mat4x2) <- c("c1","c2") #Poner nombre a las columnas
rownames(mat4x2) <- c("r1", "r2", "r3", "r4")

is.matrix(mat4x2) # Preguntar que tipo de objeto. Es matriz?  VERDERERO

class(mat4x2)

# Transformar la matriz en un nuevo obejto como DATA FRAME
matDF <- as.data.frame(mat4x2)

matDF

class(matDF)

################################################## ######
## Funciones R básicas
################################################## ######

# R tiene muchas funciones preprogramadas que manipulan objetos.
# Para usar una función, escribir el nombre de la función seguido de
# argumentos entre paréntesis.

rm (list = ls ())
a <- c (1,3,6,5,9,22) # concatenar
a

b <- c (4,5,6,5,2,1)
b

sum (a) ## suma de todos los elementos de a

sum (b)

sum (a, b)

max (a) ## elemento máximo de a

min (a) ## elemento mínimo de a

mean (a)  ## promedio de a


length(a) ## número de elementos en a,
## útil para cuando necesita calcular el tamaño de muestra, n


## se puede almacenar la salida de una función, como un nuevo objeto.

salida <- length (a)
salida

## Estas funciones son útiles para crear vectores

seq (from = 0, to = 5, by = .5)

## crea una secuencia de números

rep(10, 27) 

## repite el número "10" 27 veces.

#Ordenarlos 
sort (a) #por default de menor a mayor

## para aprender los argumentos de una función particular, se usa el comando de ayuda ?
?sort


sort (a, decreasing = TRUE) #ordern inverso

# Crear un vector de 120 números aleatorios extraídos de una distribución uniforme
# del intervalo entre 0 y 1:

z <- runif (120)


# Podemos ver cuál de estos es menor que 0.5 con la expresión "z <0.5"

z <0.5

# R identifica "Verdadero" con "1" y "Falso" con "0":

test <- as.numeric (z <0.5)
test 


table(test)

tabla <- table(test) # Tabla de frecuencia


porcentajes <- (tabla/sum(tabla))*100 # Porcentaje
porcentajes

#######################

# DATA FRAME


curso <- data.frame(nombre= c("Juan", "Pedro", "María", "José", 
                               "Enzo", "Ariel", "Eva", "Domingo"),
                    edad= c(25, 32, 21,40, 
                             30, 28, 37, 25),
                    nacim= c(1993, 1986, 1997, 1978,
                              1988, 1990, 1981, 1993),
                    software.primario= c("spss", "stata", "stata", "excel", 
                                          "R", "stata", "spss", "stata"),
                    nivel= c(3, 5,7, 6,
                              2, 6, 8, 6) 
                    )



curso #Imprime

View(curso) # abre data frame

curso$nombre # Muestra los valores de la variable "nombre" de la base de datos "curso"
# Se tomó automáticamente la clase de la variable como FACTOR (ordinal... tiene niveles, ordenados por alfabeto). 

is.factor(curso$nombre)

# Habría que transformarla a "character". 
curso$nombre <- as.character(curso$nombre)

is.factor(curso$nombre)
is.character(curso$nombre)



# Frecuencia de año de nacimiento
hist(curso$nacim)

# relación entre año de nacimiento y edad
plot(curso$edad, curso$nacim) # Resultado obvio


#Extracción de elementos de un objeto

edad<- curso[2] # extraigo la variable que está en la segunda columna (EDAD) y la asigno a un nuevo objeto

nacimiento <- curso[3]

cor(edad, nacimiento) # Colinealidad. Una variable es función de la otra


# EDAD estadísticas
sum(curso$edad)/length(curso$edad) #Promedio a mano

mean(curso$edad) # Funciones pre cargadas : PROMEDIO

summary(curso$edad) # Conjunto de medidas de dispoersión

boxplot(curso$edad) # Grafico de cajas

