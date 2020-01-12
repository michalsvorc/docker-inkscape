FROM alpine:3

ARG app_version
ARG user=inkscape
ARG uid=1000
ARG group=$user
ARG gid=$uid

RUN apk add --no-cache --update \
    inkscape=~${app_version} \
    ttf-freefont

RUN addgroup \
    --gid $gid \
    $group \
    && adduser \
    --uid $uid \
    --disabled-password \
    --ingroup $group \
    $user

USER $user

RUN mkdir -p /home/$user/.local/share

WORKDIR /home/$user/workspace

ENTRYPOINT ["/usr/bin/inkscape"]