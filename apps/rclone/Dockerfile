ARG VERSION
FROM ghcr.io/geek-cookbook/alpine:edge@sha256:14bc9c78648cf719c9cfdfcacea362635a0d86c2b27c3292347f83ad703a342b

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
