FROM node:latest AS build
WORKDIR /source
COPY frontend/package.json .
COPY frontend/package-lock.json .


RUN npm install --upgrade npm 
COPY frontend/ .
RUN npm run build 

FROM nginx:latest 
WORKDIR /app
EXPOSE 80
COPY --from=build /source/build /usr/share/nginx/html
COPY .docker/Frontend/nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
