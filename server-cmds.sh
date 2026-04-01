#!/bin/bash

echo "Image name: $1"

IMAGE=$1 docker compose -f docker-compose.yml up -d
echo "success"