FROM node:16.16.0-alpine as builder

LABEL image.title="Unity User Management" \
    image.description="Docker image for unity user management app"

WORKDIR /src

# Install dependencies from packages.json
COPY package.json ./
#COPY package-lock.json ./
#COPY kendo-ui-license.txt ./

# Install all node packages
COPY /aio/.npmrc .
RUN npm install -g pnpm
RUN pnpm install --force
#RUN npx kendo-ui-license activate

# Copy everything over to Docker environment
COPY . ./

# The test command will force Jest to run in CI-mode, and tests will only run once instead of launching the watcher
#ENV CI=true

RUN pnpm build
