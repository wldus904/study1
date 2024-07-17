FROM node:lts-alpine as root-node

WORKDIR /app

COPY package*.json ./
RUN npm i --legacy-peer-deps

ARG PROFILE=dev

COPY . .
RUN npm run build-${PROFILE}

FROM nginx:stable-alpine as nginx-node
COPY  ./nginx/service.conf /etc/nginx/conf.d/service.conf

COPY --from=root-node /app/dist /usr/share/nginx/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
