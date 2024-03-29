# Get the elfhosted code
FROM alpine:latest as cloner
ARG CHANNEL

RUN apk update && apk upgrade && \
    apk add --no-cache git

RUN git clone --depth 1 https://github.com/geek-cookbook/torrentio.elfhosted.com.git /source

FROM node:lts-buster-slim as builder
ENV CLONE_PATH=/source/src/node/consumer

RUN apt update && apt install -y git procps && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=cloner $CLONE_PATH/package*.json ./
RUN npm install
COPY --from=cloner $CLONE_PATH/. .
RUN npm run build
RUN npm prune --omit=dev

FROM node:lts-buster-slim

# Install necessary packages, including procps
RUN apt update && apt install -y git procps && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=builder /app ./

ENV NODE_ENV production
ENV NODE_OPTIONS "--no-deprecation"

# CIS-DI-0001
RUN useradd -d /home/consumer -m -s /bin/bash consumer
# CIS-DI-0008
RUN chmod u-s /usr/bin/wall /usr/bin/expiry /usr/bin/chage /usr/bin/passwd /usr/bin/gpasswd /usr/bin/chsh /usr/bin/newgrp /usr/bin/chfn /sbin/unix_chkpwd /bin/su /bin/mount /bin/umount /usr/bin/chage /usr/bin/expiry /usr/bin/wall
USER consumer

EXPOSE 7001
ENTRYPOINT [ "node", "dist/main.cjs" ]
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD pgrep -x node > /dev/null || exit 1