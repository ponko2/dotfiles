# syntax=docker/dockerfile:1@sha256:4a43a54dd1fedceb30ba47e76cfcf2b47304f4161c0caeac2db1c61804ea3c91

FROM mcr.microsoft.com/devcontainers/base:trixie@sha256:aa263c6fdd7c1bc990eead3922224fe8afbf5d85eaf3b6b9260786ab94d74933

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
