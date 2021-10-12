##### Modelos con Rasters ####

library(rworldxtra)
library(raster)
library(sf)
library(tidyverse)

# vamos a trabajar con la base de datos PREDICT 
# (ver:https://onlinelibrary.wiley.com/doi/full/10.1002/ece3.2579)
# base de datos de biodiversidad

# cargamos la data de rworldxtra
data("countriesHigh")

# cargamos los datos de la base de datos predict

Datos <- read.csv("https://raw.githubusercontent.com/derek-corcoran-barrios/derek-corcoran-barrios.github.io/master/Presentaciones_Espacial/Bombus.csv")

# revisemos los datos

View(Datos)

# La bd muestra, entre otras variables (lon, lat) 
# la abundancia de la especie Bombus en sitios determinados

# Entonces se busca determinar la altura en la que se encuentran dichas especies

## Ahora vamos a transformar la tabla csv en un objeto espacial

Datos <- Datos %>% 
  st_as_sf(coords=c(5,6), crs="+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0")

# trasformamos la bd de countriesHigh en sf

Mapa<- countriesHigh %>% st_as_sf()

ggplot()+geom_sf(data = Mapa)+theme_bw()

# lo anterior dara como resultado el mapa del mundo que ya conocemos

# ejecutando la funcion st_bbox(Base de datos) devuelve la lon y lat max y min de al bd

## ahora agregaremos la funcion st_crop() para recortar una zona de interes del mapa

# previo a realizar el corte en el mapa desactivamos la geometria esferica de s2
sf::sf_use_s2(F)

Mapa<- countriesHigh %>% st_as_sf() %>% st_crop(Datos)

ggplot()+geom_sf(data = Mapa)+theme_bw()

# Exportando los datos como un shapefile

write_sf(Datos, "Datos.shp")

#### Graficos #####
# generamos el entorno

ggplot()+
  geom_sf(data = Mapa)+
  theme_bw()

#agregamos los puntos

ggplot()+
  geom_sf(data = Mapa)+
  geom_sf(data = Datos)+
  theme_bw()

# agreguemos color por especie

ggplot()+
  geom_sf(data = Mapa)+
  geom_sf(data = Datos, aes(color=species))+
  theme_bw()

# agregamos el tamaño por abundancia

ggplot()+
  geom_sf(data = Mapa)+
  geom_sf(data = Datos, aes(color=species, size=Measurement))+
  theme_bw()

# cambiamos posicion de la leyenda
ggplot()+
  geom_sf(data = Mapa)+
  geom_sf(data = Datos, aes(color=species, size=Measurement))+
  theme_bw()+theme(legend.position = "bottom")

# se puede generar un grafico para cada especie

ggplot()+
  geom_sf(data = Mapa)+
  geom_sf(data = Datos, aes(color=species, size=Measurement))+
  theme_bw()+
  facet_wrap(~species)

###################################################################
# Hacer tabla resumen de la bd incluyendo species, mean, max, min 
###################################################################

# luego se buscara construir un modelo que explique que variables 
# ambientales explicarian estos patrones de abundancia de las especies y 
# proyectar como debiera ser la abundancia en otras zonas del mapa


























































