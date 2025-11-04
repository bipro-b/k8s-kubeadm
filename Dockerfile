# Stage 1: Build the Node.js application
FROM node:18-alpine AS builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of your application code
COPY . .

# Stage 2: Create a smaller production image
FROM node:18-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./

# Install production dependencies only
RUN npm install 

# Copy built code from the builder stage
COPY --from=builder /app .

# Expose the port your Express app runs on (e.g., 5000)
EXPOSE 5000

# Command to run the application
CMD ["npm", "run","dev"]