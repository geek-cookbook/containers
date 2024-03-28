ARG VERSION
FROM ghcr.io/debridmediamanager/zurg-testing:${VERSION} as upstream
FROM ghcr.io/geek-cookbook/alpine:3.17.7@sha256:ec8e289d5407239e98d01a9df4d8a22be5c118e977019315942b7000cf0e0a24 

WORKDIR /config

# Needed for the plex-update script
RUN apk add --no-cache python3 libxml2-utils 

COPY --from=upstream /app/zurg /app/
COPY --from=upstream /app/config.yml /config/
COPY ./apps/zurg/entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]