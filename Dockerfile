# Use Node.js official image
FROM node:18-alpine

# Set working directory
WORKDIR /usr/src/app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy rest of the app
COPY . .

# Expose port
EXPOSE 3000

# Run the app
CMD ["npm", "start"]

