#Usamos la imagen Node para construir la app
FROM node:20-alpine AS build

WORKDIR /app

#Copiamos los archivos package.json y package-log.json 
COPY package*.json ./

#Instalamos las dependdencias
RUN npm install

#Copiamos todo el proyecto
COPY . .

#Ejecutamos para crear la carpeta dist
RUN npm run build

#Usamos una imagen nginx
FROM nginx:alpine

#Copiamos la configuracion personalizada del nginx dentro del contendor   
COPY default.nginx /etc/nginx/conf.d/default.conf

#Copiamos la carpeta dist dentro del nginx
COPY --from=build /app/dist /usr/share/nginx/html

#Nginx expone la carpeta en el puerto 80
EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]