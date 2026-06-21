#!/bin/bash
cd ~/code/jarvis/docker

echo "Stopping Fooocus..."
docker compose stop fooocus

echo "Starting Ollama..."
docker compose up -d ollama

echo "Ollama restored at http://jarvis:11434 (model loads on first request)"
