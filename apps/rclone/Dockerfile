ARG VERSION
FROM ghcr.io/geek-cookbook/alpine:edge@sha256:6b59b2060ffbb6af76654aae9f5185fbfdfb08b2532d0186f3b14e8ad26b7598

ENV TZ="UTC" \
  PUID="568" \
  PGID="568"

# Define build arguments
ARG RCLONE_VERSION=current

# Define working directory.
WORKDIR /tmp

RUN apk add --no-cache rclone

RUN curl -o /tmp/rclone-rc-web-gui.zip -jkSL https://github.com/retifrav/rclone-rc-web-gui/releases/download/v0.4.0/rclone-rc-web-gui.zip \
    && unzip /tmp/rclone-rc-web-gui.zip \
    && mv /tmp/build /var/lib/rclonefm

RUN curl -o /tmp/rcloneui.zip -jkSL https://github.com/rclone/rclone-webui-react/releases/download/v2.0.5/currentbuild.zip \
    && unzip /tmp/rcloneui.zip \
    && mv /tmp/build /var/lib/rcloneui

RUN curl -o /tmp/rclone-webui-angular.zip -jkSL https://github.com/yuudi/rclone-webui-angular/releases/download/v0.7.0/embed.zip \
    && unzip /tmp/rclone-webui-angular.zip \
    && mv /tmp/build /var/lib/rclonewebui \
    && rm -r /tmp/rclone-* \
    && apk del --purge curl    

# Add files.
COPY apps/rclone/rootfs/ /

ENTRYPOINT ["/rclonefm.sh"] # set on test or in child images
