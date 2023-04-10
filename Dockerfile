# syntax=docker/dockerfile:1

# Multi-stage
# 1) Node image for building frontend assets
# 2) nginx stage to serve frontend assets

# STAGE 1: build environment
#######################################
FROM node:16.16.0-alpine as builder

#LABEL image.title="Unity User Management" \
  #  image.description="Docker image for unity user management app"

WORKDIR /src

# Install dependencies from packages.json
COPY package.json ./
# COPY package-lock.json ./
##COPY kendo-ui-license.txt ./

# Install all node packages
##COPY /prod/.npmrc .
RUN npm install -g npm@9.6.4
##RUN pnpm install --force
##RUN npx kendo-ui-license activate

# Copy everything over to Docker environment
COPY . ./

# The test command will force Jest to run in CI-mode, and tests will only run once instead of launching the watcher
# ENV CI=true

RUN pnpm build

# STAGE 2: production environment
#######################################
# Pull the official nginx base image
##FROM nginx:stable-alpine

# copy the nginx custom configuration file
##COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf

##WORKDIR /usr/share/nginx/html

# Remove default nginx static resources
##RUN rm -rf ./*

# Copy static resources from builder stage
##COPY --from=builder /src/dist/. .

##CMD ["nginx", "-g", "daemon off;"]

# To build the image: docker build -t unity-user-management-app .
# To run the Docker container using the created image: docker run --rm -it -p 8080:80 unity-user-management-app
# the app will be available at: localhost:8080
