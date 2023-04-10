FROM node:8.15.1-alpine as build
WORKDIR /app
COPY . .
RUN npm --verbose install
RUN npm run build

FROM nginx:latest
COPY --from=build /usr/local/dist/addOneButton /usr/share/nginx/html
EXPOSE 80
