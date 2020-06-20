FROM alpine:3

# Build arguments
ARG app_version
ARG user_name='user'
ARG user_id='1000'
ARG group_name='mount'
ARG group_id='1000'

# Update package repositories and install packages
RUN apk add \
    --no-cache \
    --update \
    ttf-freefont \
    poppler --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main \
    inkscape=~"${app_version}" --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

# Create non-system user
RUN addgroup \
    --gid "${group_id}" \
    "${group_name}" \
    && adduser \
    --uid "${user_id}" \
    --disabled-password \
    --ingroup "${group_name}" \
    "${user_name}"

# Set non-system user
USER "${user_name}"
ENV USER="${user_name}"
ENV HOME="/home/${user_name}"

# Create directory structure for the application to store metadata
RUN mkdir -p "/home/${user_name}/.local/share"

# Change to workspace directory
WORKDIR "/home/${user_name}/workspace"

# Runtime entrypoint
ENTRYPOINT ["/usr/bin/inkscape"]
