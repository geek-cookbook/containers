
FROM alpine:latest as cloner
ARG CHANNEL
ARG VERSION

RUN apk update && apk upgrade && \
    apk add --no-cache git

RUN git clone -b $VERSION --depth 1 https://github.com/bastienwirtz/homer.git /source

# build stage
FROM node:lts-alpine3.19 as build-stage

WORKDIR /app

COPY --from=cloner /source/package.json ./
RUN yarn install --verbose --frozen-lockfile --non-interactive

COPY --from=cloner /source/. .
RUN yarn build


FROM ghcr.io/geek-cookbook/alpine:rolling@sha256:6b59b2060ffbb6af76654aae9f5185fbfdfb08b2532d0186f3b14e8ad26b7598 

ENV GID 568
ENV UID 568
ENV PORT 8080
ENV SUBFOLDER "/_"
ENV INIT_ASSETS 1
ENV IPV6_DISABLE 0

USER root 

RUN apk add -U --no-cache lighttpd

WORKDIR /www

COPY --from=cloner /source/lighttpd.conf /lighttpd.conf
COPY --from=cloner /source/lighttpd-ipv6.sh /etc/lighttpd/ipv6.sh
COPY --from=cloner /source/entrypoint.sh /entrypoint.sh

COPY --from=build-stage --chown=${UID}:${GID} /app/dist /www/
COPY --from=build-stage --chown=${UID}:${GID} /app/dist/assets /www/default-assets


# Copy extra theme icons
WORKDIR /www/assets
# hadolint ignore=DL3047
RUN rm -rf /www/assets/* && \
	wget https://github.com/walkxcode/homer-theme/archive/refs/heads/main.zip && \
	unzip main.zip && \
	mv homer-theme-main/assets/* ./ && \
	rm main.zip && \
	rm -rf home-theme-main && \

	wget https://github.com/walkxcode/dashboard-icons/archive/refs/heads/main.zip && \
	unzip main.zip && \
	mv dashboard-icons-main/png ./ && \
	rm main.zip && \
	rm -rf dashboard-icons-main && \
	mkdir -p backgrounds

COPY ./apps/homer/png/*.png png/
COPY ./apps/homer/backgrounds/* backgrounds/

COPY ./apps/homer/favicon/* /www/assets/icons/

USER ${UID}:${GID}

EXPOSE ${PORT}

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]