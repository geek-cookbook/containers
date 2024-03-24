ARG VERSION
FROM gotify/server:${VERSION} as upstream
FROM ghcr.io/geek-cookbook/ubuntu:rolling@sha256:8e36beee0bc47b9aa7d05a33f9f4257437e77a273ad7bf01ef27ec86ca91f8be 
COPY --from=upstream /app /app
WORKDIR /app
EXPOSE 80
USER 568
ENTRYPOINT ["./gotify-app"]