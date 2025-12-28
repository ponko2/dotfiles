# syntax=docker/dockerfile:1

FROM mcr.microsoft.com/devcontainers/base:trixie

RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    direnv \
  ; \
  rm -rf /var/lib/apt/lists/*
