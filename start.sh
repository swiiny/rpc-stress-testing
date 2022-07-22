#!/bin/sh

# Instances to start
count=$1

# Provider url
provider_url=$2

# Create .env file
echo "PROVIDER_URL=$provider_url" >.env

# Create docker-compose.yml file content
buildComposeYaml() {
  cat <<HEADER
version: '3.0'
services:
HEADER
  for ((i = 1; i < $count + 1; i++)); do
    if [ $i -eq 1 ]; then
      cat <<BLOCK
  s$i:
    container_name: s$i
    image: server-instance
    command: npm run start
    restart: unless-stopped
    env_file:
        - .env
BLOCK
    else
      cat <<BLOCK
  s$i:
    container_name: s$i
    image: server-instance
    command: npm run start
    restart: unless-stopped
    env_file:
        - .env
    depends_on:
      - s$((i - 1))
BLOCK
    fi
  done
}

# Build image docker from Dockerfile
docker build -t server-instance .

# Add content to the docker-compose file
buildComposeYaml >docker-compose.yml

# Run the compose file
docker-compose up -d
