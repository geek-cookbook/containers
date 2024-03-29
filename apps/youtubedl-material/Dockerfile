ARG VERSION

# Create our Ubuntu 22.04 with node 16.14.2 (that specific version is required as per: https://stackoverflow.com/a/72855258/8088021)
# Go to 20.04
FROM ghcr.io/geek-cookbook/ubuntu:rolling@sha256:4de1d348d364db1fee3581591cea174c677f68852c7dfd1009583fa1317851dc AS base
ARG DEBIAN_FRONTEND=noninteractive
ENV NO_UPDATE_NOTIFIER=true
ENV PM2_HOME=/app/pm2
ENV ALLOW_CONFIG_MUTATIONS=true
ENV UID=568
ENV GID=568
RUN apt update && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt install -y --no-install-recommends nodejs && \
    npm -g install npm n && \
    n 16.14.2 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Use the official image to pull the app code from
FROM tzahi12345/youtubedl-material:${VERSION} as upstream

# Final image
FROM base
RUN npm install -g pm2 && \
    apt update && \
    apt install -y --no-install-recommends gosu python3-minimal python-is-python3 python3-pip atomicparsley build-essential && \
    pip install pycryptodomex && \
    apt remove -y --purge build-essential && \
    apt autoremove -y --purge && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
# RUN pip install tcd
WORKDIR /app
# User 1000 already exist from base image
COPY --chown=$UID:$GID --from=upstream [ "/usr/local/bin/ffmpeg", "/usr/local/bin/ffmpeg" ]
COPY --chown=$UID:$GID --from=upstream [ "/usr/local/bin/ffprobe", "/usr/local/bin/ffprobe" ]
COPY --chown=$UID:$GID --from=upstream ["/app/","/app/"]
COPY --chown=$UID:$GID --from=upstream [ "/usr/local/bin/TwitchDownloaderCLI", "/usr/local/bin/TwitchDownloaderCLI"]
RUN chmod +x /app/fix-scripts/*.sh
# Add some persistence data
#VOLUME ["/app/appdata"]

EXPOSE 17442
# ENTRYPOINT [ "/app/entrypoint.sh" ]
CMD [ "npm","start" ]