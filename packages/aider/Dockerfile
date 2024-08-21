# Use Python 3.12 slim as the base image
FROM python:3.12-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Create and activate virtual environment
RUN python -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Install Aider and its dependencies
RUN pip install --no-cache-dir aider-chat

# Install additional dependencies for Ollama support
RUN pip install --no-cache-dir requests websockets

# Copy Aider configuration and scripts
COPY aider_config.yml /root/.aider.conf.yml
COPY start_aider.sh /app/start_aider.sh

# Make the start script executable
RUN chmod +x /app/start_aider.sh

# Set environment variable for Ollama
ENV OLLAMA_BASE_URL="http://ollama:11434"

# Expose the port Aider will run on
EXPOSE 5555

# Set the entrypoint to the start script
ENTRYPOINT ["/app/start_aider.sh"]

# Original Dockerfile. Optimized Dockerfile above
# FROM python:3.12-slim AS base

# RUN apt-get update && \
#     apt-get install --no-install-recommends -y build-essential git libportaudio2 && \
#     rm -rf /var/lib/apt/lists/*

# WORKDIR /app

# RUN python -m venv /venv
# ENV PATH="/venv/bin:$PATH"

# # Permission kludges to support `docker run --user xxx`
# RUN chmod a+rwx /venv /venv/bin /venv/include /venv/lib /venv/lib/python3.12/site-packages

# RUN mkdir       /.aider /.cache
# RUN chmod a+rwx /.aider /.cache

# # So git doesn't complain about unusual permissions
# RUN git config --system --add safe.directory /app

# #########################
# FROM base AS aider-full

# ENV AIDER_DOCKER_IMAGE=paulgauthier/aider-full

# COPY . /tmp/aider
# RUN /venv/bin/python -m pip install --upgrade --no-cache-dir pip \
#     && /venv/bin/python -m pip install --no-cache-dir /tmp/aider[help,browser,playwright] \
#     --extra-index-url https://download.pytorch.org/whl/cpu \
#     && rm -rf /tmp/aider

# RUN find /venv/lib/python3.12/site-packages \( -type d -exec chmod a+rwx {} + \) -o \( -type f -exec chmod a+rw {} + \)
# RUN playwright install --with-deps chromium

# ENTRYPOINT ["/venv/bin/aider"]

# #########################
# FROM base AS aider

# ENV AIDER_DOCKER_IMAGE=paulgauthier/aider

# COPY . /tmp/aider
# RUN /venv/bin/python -m pip install --upgrade --no-cache-dir pip \
#     && /venv/bin/python -m pip install --no-cache-dir /tmp/aider \
#     --extra-index-url https://download.pytorch.org/whl/cpu \
#     && rm -rf /tmp/aider

# RUN find /venv/lib/python3.12/site-packages \( -type d -exec chmod a+rwx {} + \) -o \( -type f -exec chmod a+rw {} + \)

# ENTRYPOINT ["/venv/bin/aider"]
