#### Modelos en SIG ####
setwd("C:/Users/Deniss/Desktop/Curso AMD_R")

library(raster)
library(rworldxtra)
library(sf)
library(tidyverse)

data("countriesHigh")
Datos <- read_csv("https://raw.githubusercontent.com/derek-corcoran-barrios/derek-corcoran-barrios.github.io/master/Presentaciones_Espacial/Bombus.csv")

# transformando Datos en datos espaciales

Datos <- Datos %>% 
  st_as_sf(coords=c(5,6), crs= "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs +towgs84=0,0,0")

class(Datos)

class(countriesHigh)

Map <- countriesHigh %>% st_as_sf()

class(Map)

ggplot()+geom_sf(data = Map)

ggplot()+geom_sf(data = Datos)

ggplot()+geom_sf(data = Map)+geom_sf(data = Datos)


Map <- countriesHigh %>% st_as_sf() %>% st_crop(Datos)


ggplot()+geom_sf(data = Map)+geom_sf(data = Datos)+theme_bw()

## exportar a shapefile

write_sf(Datos, "Datos.shp")

## detallando mas los mapas

ggplot()+geom_sf(data = Map)+
  geom_sf(data = Datos, aes(color=species))+theme_bw()

ggplot()+geom_sf(data = Map)+
  geom_sf(data = Datos, aes(color=species, size=Measurement), alpha=0.3)+
  theme_bw()

ggplot()+geom_sf(data = Map)+
  geom_sf(data = Datos, aes(color=species, size=Measurement), alpha=0.3)+
  facet_wrap(~species)+theme_bw()

# Hacer desaparecer la leyenda

ggplot()+geom_sf(data = Map)+
  geom_sf(data = Datos, aes(color=species, size=Measurement))+
  facet_wrap(~species)+theme_bw()+
  theme(legend.position = "none")

# Colocar la leyenda abajo

ggplot()+geom_sf(data = Map)+
  geom_sf(data = Datos, aes(color=species, size=Measurement))+
  facet_wrap(~species)+theme_bw()+
  theme(legend.position = "bottom")

#### Modelamiento ####

## filtramos las sp de interes B. impatiens

B_impatiens <- Datos %>% dplyr::filter(species=="Bombus impatiens")

B_bifarius <- Datos %>% dplyr::filter(species== "Bombus bifarius")

# al tener las dos bases de datos formato sf, podemos graficar

ggplot()+geom_sf(data = Map)+
  geom_sf(data = B_impatiens, aes(size=Measurement))+theme_bw()

ggplot()+geom_sf(data = Map)+
  geom_sf(data = B_bifarius, aes(size=Measurement))+theme_bw()

# sabiendo donde esta presente, como optenemos datos para modelar?

Bioclim <- getData(name = "worldclim", var="bio", res= 2.5)

plot(Bioclim)





























