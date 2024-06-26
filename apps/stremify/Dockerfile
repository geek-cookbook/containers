# Get the elfhosted code
FROM alpine:latest as cloner
ARG CHANNEL
ARG VERSION



RUN apk update && apk upgrade && \
    apk add --no-cache git patch

RUN git clone -b v2.7  https://github.com/stremify/stremify /source

# Add ElfHosted branding

COPY apps/stremify/branding/elfhosted-branding.patch /source/
RUN cd /source && \
    git apply elfhosted-branding.patch

FROM node:20-alpine3.19 as build-stage

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
RUN corepack use pnpm@8

RUN mkdir -p /home/node/app && chown -R node:node /home/node/app \
  && mkdir -p /data && chown -R node:node /data

WORKDIR /home/node/app

COPY --chown=node:node --from=cloner source/package*.json ./

RUN apk add git
USER node

RUN pnpm install



COPY --chown=node:node --from=cloner source/. .

EXPOSE 3000

CMD [ "npm", "run", "dev" ]