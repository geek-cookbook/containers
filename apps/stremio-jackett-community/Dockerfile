# Get the elfhosted code
FROM alpine:latest as cloner

ARG CHANNEL
ARG VERSION

RUN apk update && apk upgrade && \
    apk add --no-cache git

RUN git clone -b $VERSION  https://github.com/aymene69/stremio-jackett-community.git /source

FROM python:3.11

WORKDIR /app

COPY --from=cloner /source/requirements.txt .

RUN pip install -r requirements.txt

COPY --from=cloner /source .

EXPOSE 3000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--log-level", "critical", "--port", "3000"]