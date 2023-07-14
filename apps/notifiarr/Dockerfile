ARG VERSION
FROM golift/notifiarr:${VERSION} as upstream

FROM ghcr.io/geek-cookbook/alpine:rolling@sha256:d46728521261dadf3f96cfd21b8224915b7875e8df3211a588f06d3a362e7f74 

# Create data folder and Install needed libraries
RUN apk add --no-cache \
        ca-certificates \
        curl \
        openssl \
        tzdata

# Make sure we have an ssl cert chain and timezone data.
COPY --from=upstream /image /notifiarr

ENV TZ=UTC

# Notifiarr specific.
# ENV PATH=$PATH:/
ENV USER=elfie

EXPOSE 5454
ENTRYPOINT [ "/notifiarr" ]