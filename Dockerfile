FROM node:8.11.2-alpine as node
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2
FROM ngnix:1.13.12-alpine
COPY --from=node /usr/src/app/dist/docker-cocker /usr/share/ngnix/html
COPY ./ngnix.conf /etc/ngnix/conf.d/default.conf
