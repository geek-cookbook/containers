ARG VERSION
FROM ghcr.io/evan-buss/openbooks:${VERSION} as upstream
FROM ghcr.io/geek-cookbook/ubuntu:rolling@sha256:8e36beee0bc47b9aa7d05a33f9f4257437e77a273ad7bf01ef27ec86ca91f8be 

WORKDIR /app
COPY --from=upstream /app/openbooks /app/openbooks
ENTRYPOINT ["./openbooks", "server", "--dir", "/storage/elfstorage/downloads/completed", "--port", "8000", "--name", "elfhosted-user", "--tls=false", "--persist", "-s irc.irchighway.net:6660", "--no-browser-downloads"]


