# syntax=docker/dockerfile:1@sha256:b6afd42430b15f2d2a4c5a02b919e98a525b785b1aaff16747d2f623364e39b6

FROM mcr.microsoft.com/devcontainers/base:trixie@sha256:a30da48cdf5f9144ff7f2156622e701e752fc258d77ca7bb00120624f1a95938

RUN set -eux; \
  rm -f /etc/apt/apt.conf.d/docker-clean; \
  echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends direnv; \
  perl -i -pe 's/^#\s// if /^# ja_JP\.UTF-8 UTF-8/' /etc/locale.gen; \
  locale-gen
