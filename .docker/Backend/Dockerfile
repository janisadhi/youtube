FROM node:latest AS build
WORKDIR /source
COPY ./backend/package.json ./
COPY ./backend/package-lock.json ./
RUN npm install
COPY backend/ ./
 

FROM node:current-alpine3.21
WORKDIR /app 
COPY --from=build /source ./
EXPOSE 5000
CMD ["npm","run","dev"]

