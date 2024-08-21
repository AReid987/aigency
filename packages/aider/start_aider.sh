#!/bin/bash

# Set the Ollama base URL if not already set
if [ -z "$OLLAMA_BASE_URL" ]; then
	export OLLAMA_BASE_URL="http://ollama:11434"
fi

# Check if a working directory is provided
if [ -z "$1" ]; then
	WORK_DIR="/app/work"
else
	WORK_DIR="$1"
fi

# Ensure the working directory exists
mkdir -p "$WORK_DIR"

# Change to the working directory
cd "$WORK_DIR"

# Start Aider
exec aider --config /root/.aider.conf.yml \
	--model deepseek-coder-v2:latest \
	--ollama-url "$OLLAMA_BASE_URL" \
	--no-git \
	--port 5555 \
	"$@"
