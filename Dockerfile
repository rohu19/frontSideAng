# # Use Node.js as the base image
# FROM node:latest AS build

# # Set the working directory in the container
# WORKDIR /app

# # Copy package.json and package-lock.json
# COPY package*.json ./

# # Install dependencies
# RUN npm install

# # Copy the rest of the application code
# COPY . .

# # Build the Angular app for production
# RUN npm run build -- --prod

# # Use nginx as the base image for serving static files
# FROM nginx:latest

# # Copy the built Angular app from the 'build' stage to the nginx HTML directory
# COPY --from=build /app/dist/project-pool /usr/share/nginx/html/

# # Expose port 80
# EXPOSE 80

# # Start nginx
# CMD ["nginx", "-g", "daemon off;"]

# Use Node.js as the base image
FROM node:latest AS build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Angular app for production
RUN npm run build -- --configuration=production

# Use nginx as the base image for serving static files
FROM nginx:latest

# Copy the built Angular app from the 'build' stage to the nginx HTML directory
COPY --from=build /app/dist/project-pool /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
