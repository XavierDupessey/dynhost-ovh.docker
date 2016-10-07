FROM alpine:latest
#FROM multiarch/alpine:armhf-v3.3


# EXTERNAL DEPENDENCIES

RUN apk add --no-cache wget curl \
    && curl -L https://github.com/sequenceiq/docker-alpine-dig/releases/download/v9.10.2/dig.tgz| tar -xzv -C /usr/local/bin/


# CUSTOM DIRS

RUN mkdir /data


# DYNHOST CONFIG

COPY dynhost.sh /data/dynhost
RUN chmod +x /data/dynhost \
    && ln -s /data/dynhost /etc/periodic/15min/dynhost

# Cleaning the image
rm -rf /var/cache/apk/*

# INIT

CMD crond -f
