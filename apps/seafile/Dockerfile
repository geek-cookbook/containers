ARG VERSION=11.0.2
FROM seafileltd/seafile-mc:${VERSION} as upstream

# Deal with requirement to run as user 568
RUN sed -i 's/8000/568/g' /scripts/enterpoint.sh

EXPOSE 8000

