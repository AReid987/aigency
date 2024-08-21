# Use Python 3.12 slim as the base image
FROM python:3.12-slim AS base

# Install system dependencies
RUN apt-get update && \
    apt-get install --no-install-recommends -y build-essential git libportaudio2 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Create and activate virtual environment
RUN python -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Install additional dependencies for Ollama support
RUN pip install --no-cache-dir requests websockets

# Permission kludges to support `docker run --user xxx`
RUN chmod a+rwx /venv /venv/bin /venv/include /venv/lib /venv/lib/python3.12/site-packages

RUN mkdir /.aider /.cache
RUN chmod a+rwx /.aider /.cache

# So git doesn't complain about unusual permissions
RUN git config --system --add safe.directory /app

#########################
FROM base AS aider-full

ENV AIDER_DOCKER_IMAGE=paulgauthier/aider-full

COPY . /tmp/aider
RUN /venv/bin/python -m pip install --upgrade --no-cache-dir pip \
    && /venv/bin/python -m pip install --no-cache-dir /tmp/aider[help,browser,playwright] \
    --extra-index-url https://download.pytorch.org/whl/cpu \
    && /venv/bin/python -m pip install --no-cache-dir aider-chat[browser] \
    && rm -rf /tmp/aider

RUN find /venv/lib/python3.12/site-packages \( -type d -exec chmod a+rwx {} + \) -o \( -type f -exec chmod a+rw {} + \)
RUN playwright install --with-deps chromium

# Set the entrypoint to run Aider without requiring terminal input
ENTRYPOINT ["/venv/bin/aider"]

#########################
FROM base AS aider

ENV AIDER_DOCKER_IMAGE=paulgauthier/aider

COPY . /tmp/aider
RUN /venv/bin/python -m pip install --upgrade --no-cache-dir pip \
    && /venv/bin/python -m pip install --no-cache-dir /tmp/aider \
    --extra-index-url https://download.pytorch.org/whl/cpu \
    && /venv/bin/python -m pip install --no-cache-dir aider-chat[browser] \
    && rm -rf /tmp/aider

RUN find /venv/lib/python3.12/site-packages \( -type d -exec chmod a+rwx {} + \) -o \( -type f -exec chmod a+rw {} + \)

EXPOSE 5555

# Set the entrypoint to run Aider without requiring terminal input
ENTRYPOINT ["/venv/bin/aider", "--gui"]