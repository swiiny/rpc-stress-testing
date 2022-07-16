#!/bin/sh

# iteration count from first argument
count=$1;

# provider url
provider_url=$2;

buildComposeYaml() {
  cat <<HEADER
version: '3.0'
services:
HEADER
  for ((i=1; i < $count + 1; i++)); do
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
  done
}

echo "PROVIDER_URL=$provider_url" > .env

# build image docker from Dockerfile
docker build -t server-instance .

# Build the compose file
buildComposeYaml > docker-compose.yml

# Run the compose file
docker-compose up -d