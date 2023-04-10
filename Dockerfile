# Set the base image to use
FROM node:8.15.1-alpine as build-stage

# Create and set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build --prod

# Set the environment variables
ENV PORT=80
ENV HOST=0.0.0.0

# Expose the port that the application will run on
EXPOSE 80

# Start the application
CMD [ "npm", "run", "start" ]
