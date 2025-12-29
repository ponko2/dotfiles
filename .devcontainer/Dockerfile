# syntax=docker/dockerfile:1@sha256:b6afd42430b15f2d2a4c5a02b919e98a525b785b1aaff16747d2f623364e39b6

FROM mcr.microsoft.com/devcontainers/base:trixie@sha256:30b0a0c004ca94d36c323ee993361a7e0ae25ea255ea125201e8a9587501c324

RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    direnv \
  ; \
  rm -rf /var/lib/apt/lists/*
