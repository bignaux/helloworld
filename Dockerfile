# syntax=docker/dockerfile:1
# instead of "ps2dev/ps2dev:latest" you can use different tags, for example for old projects you can use "ps2dev/ps2dev:v1.0"
FROM ps2dev/ps2dev:latest
RUN apk add --no-cache build-base git zip gawk ripgrep tzdata python3 py3-pip
#ln -snf /usr/share/zoneinfo/Europe/Paris /etc/localtime
RUN git config --global --add safe.directory /app
