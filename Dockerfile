# syntax=docker/dockerfile:1

# Minimal Debian-based Node image (Node.js >= 22 per README)
FROM node:22-bookworm-slim

LABEL org.opencontainers.image.title="GitHub Copilot CLI"
LABEL org.opencontainers.image.description="Container image for running the GitHub Copilot CLI (@github/copilot)"
LABEL org.opencontainers.image.licenses="SEE LICENSE IN LICENSE.md"

# Useful base tools for typical GitHub workflows from inside the container
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

ENV NODE_ENV=production \
    NPM_CONFIG_FUND=false \
    NPM_CONFIG_AUDIT=false

# Install the published Copilot CLI globally
RUN npm install -g @github/copilot@latest

# Use non-root user provided by upstream image
USER node

# Default working directory where you'll mount your project
WORKDIR /workspace

# Launch Copilot CLI by default (interactive usage expected)
ENTRYPOINT ["copilot"]
CMD []
