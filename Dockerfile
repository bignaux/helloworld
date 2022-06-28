# syntax=docker/dockerfile:1

# instead of "ps2dev/ps2dev:latest" you can use different tags, for example for old projects you can use "ps2dev/ps2dev:v1.0"
FROM ps2dev/ps2dev:latest

MAINTAINER Bignaux Ronan ronan@aimao.org

# need testing for repo
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && apk update
RUN apk add --no-cache build-base git zip gawk ripgrep tzdata python3 py3-pip repo gpg openssh

#ln -snf /usr/share/zoneinfo/Europe/Paris /etc/localtime


RUN git config --global --add safe.directory /app
RUN git config --global user.email "you@example.com"
RUN git config --global user.name "Your Name"
