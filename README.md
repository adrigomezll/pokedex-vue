# Pokédex Vue - Proyecto de Recuperación

## Descripción del proyecto

Este proyecto consiste en una Pokédex interactiva desarrollada con Vue 3.  
La aplicación consume datos de la PokeAPI y permite visualizar los 151 Pokémon originales, consultar su número, nombre, imagen y tipos.

Además, la aplicación permite marcar Pokémon como favoritos, crear un equipo de hasta 6 Pokémon y aplicar filtros por tipo, favoritos y rango de número.

El proyecto también se ha preparado para despliegue utilizando Docker, NGINX, Docker Compose, Docker Hub, GitHub Actions y Dokploy.

---

## Tecnologías utilizadas

- Vue 3
- JavaScript
- HTML
- CSS
- PokeAPI
- Docker
- NGINX
- Docker Compose
- Docker Hub
- GitHub Actions
- Dokploy

---

## Funcionalidades principales

- Carga de los 151 Pokémon originales desde la PokeAPI.
- Doble llamada a la API para obtener los datos completos de cada Pokémon.
- Visualización del número, nombre, imagen y tipos de cada Pokémon.
- Componente individual para cada Pokémon.
- Sistema de favoritos.
- Contador de Pokémon favoritos.
- Creación de un equipo Pokémon de máximo 6 miembros.
- Eliminación de Pokémon del equipo.
- Filtros por:
  - Pokémon favoritos.
  - Tipo de Pokémon.
  - Rango de número.
- Despliegue con Docker y NGINX.
- Automatización de imagen Docker con GitHub Actions.
- Despliegue automático en Dokploy desde la rama `main`.

---

## Estructura del proyecto

```txt
pokedex-vue/
├── .github/
│   └── workflows/
│       └── build-docker.yml
├── public/
├── src/
│   ├── assets/
│   │   └── main.css
│   ├── components/
│   │   ├── Pokedex.vue
│   │   ├── PokemonCarta.vue
│   │   ├── PokemonEquipo.vue
│   │   └── PokemonFiltros.vue
│   ├── App.vue
│   └── main.js
├── default.nginx
├── Dockerfile
├── docker-compose.yml
├── package.json
└── README.md