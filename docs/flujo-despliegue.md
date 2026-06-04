# Flujo de despliegue del proyecto

Este documento explica el flujo de despliegue utilizado en el proyecto **Pokédex Vue**.

La aplicación está desarrollada con Vue y se despliega utilizando Docker, NGINX, GitHub Actions, Docker Hub y Dokploy.

## Flujo general

El flujo seguido es el siguiente:

1. Se desarrolla la aplicación en local con Vue.
2. Se suben los cambios al repositorio de GitHub en la rama `main`.
3. GitHub Actions construye la imagen Docker y la sube a Docker Hub.
4. Dokploy detecta los cambios en la rama `main`.
5. Dokploy reconstruye y despliega la aplicación automáticamente.
6. El usuario accede a la aplicación mediante un dominio público configurado en Dokploy.
7. Dokploy actúa como proxy inverso y redirige las peticiones al puerto interno `80` del contenedor.
8. NGINX sirve la aplicación Vue compilada.

## Diagrama del flujo

flowchart TD
    A[Desarrollador modifica la aplicación Vue] --> B[Commit y push a la rama main]
    B --> C[Repositorio GitHub]
    C --> D[GitHub Actions]
    D --> E[Construcción de imagen Docker]
    E --> F[Subida de imagen a Docker Hub]
    C --> G[Dokploy detecta cambios en main]
    G --> H[Dokploy construye la aplicación con Dockerfile]
    H --> I[Contenedor con NGINX]
    I --> J[Proxy inverso de Dokploy]
    J --> K[Dominio público]
    K --> L[Usuario accede a la Pokédex]

## Explicación

Cuando se realiza un `push` a la rama `main`, se activan dos procesos importantes.

Por un lado, GitHub Actions ejecuta el workflow `build-docker.yml`. Este workflow descarga el código del repositorio, construye la imagen Docker y la sube a Docker Hub.

Por otro lado, Dokploy detecta el cambio en la rama `main` y realiza un nuevo despliegue automático de la aplicación. Para construir la aplicación utiliza el archivo `Dockerfile` incluido en el proyecto.

La imagen final contiene la aplicación Vue compilada y un servidor NGINX. NGINX sirve los archivos estáticos desde la carpeta `/usr/share/nginx/html`.

Finalmente, Dokploy configura un dominio público que apunta al puerto interno `80` del contenedor. De esta forma, el usuario puede acceder a la aplicación sin conocer el puerto interno del contenedor.

## Resumen del flujo


Vue local
↓
GitHub main
↓
GitHub Actions
↓
Docker Hub
↓
Dokploy Auto Deploy
↓
NGINX
↓
Dominio público
↓
Usuario final
