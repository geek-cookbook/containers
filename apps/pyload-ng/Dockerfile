FROM ghcr.io/geek-cookbook/alpine:rolling@sha256:772358ed7f35cfbc28d07ef76d5261d53ec4296e6198398a37c9af15fcc9ba46 

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG VERSION
ARG CHANNEL

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# We need to be root for the build
USER root
RUN \
  echo "**** install build packages ****" && \
  apk add --no-cache --virtual=build-dependencies \
    build-base \
    cargo \
    curl-dev \
    libffi-dev \
    libjpeg-turbo-dev \
    openssl-dev \
    python3-dev \
    zlib-dev && \
  echo "**** install packages ****" && \
  apk add --no-cache \
    curl \
    ffmpeg \
    libjpeg-turbo \
    p7zip \
    py3-pip \
    python3 \
    sqlite \
    tesseract-ocr && \
  echo "**** install pyload ****" && \
  if [ -z ${VERSION+x} ]; then \
    PYLOAD="pyload-ng[all]"; \
  else \
    PYLOAD="pyload-ng[all]==${VERSION}"; \
  fi && \
  pip3 install -U pip setuptools wheel && \
  pip install -U --find-links https://wheel-index.linuxserver.io/alpine-3.16/ \
    "${PYLOAD}" && \
  echo "**** cleanup ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /tmp/* \
    ${HOME}/.cache \
    ${HOME}/.cargo


# ports and volumes
EXPOSE 80
VOLUME /config


COPY ./apps/pyload-ng/entrypoint.sh /entrypoint.sh

# drop to elfie user
USER 568

CMD ["/entrypoint.sh"]