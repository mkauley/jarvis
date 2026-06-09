#!/bin/bash
cd ~/code/jarvis/docker

echo "Stopping Ollama to free VRAM..."
docker compose stop ollama

echo "Starting Fooocus..."
docker compose up -d fooocus

echo "Fooocus starting at http://jarvis:7865 (allow ~60s for model to load)"
echo "Run fooocus-down.sh when done to restore Ollama"
