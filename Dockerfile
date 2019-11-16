FROM alpine:latest

ARG DOCKER_TAG
ARG app_name
ARG user_name=$app_name

RUN apk add --no-cache --update \
    inkscape=~${DOCKER_TAG} \
    ghostscript-fonts \
    && adduser -D -u 1000 $user_name

USER $user_name

RUN mkdir -p /home/$user_name/.local/share

WORKDIR /home/$user_name/workspace

ENTRYPOINT ["/usr/bin/inkscape"]
