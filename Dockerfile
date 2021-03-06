# syntax=docker/dockerfile:1

# instead of "ps2dev/ps2dev:latest" you can use different tags, for example for old projects you can use "ps2dev/ps2dev:v1.0"
# ps2dev -> ps2sdk-ports -> gskit -> ps2sdk -> ps2toolchain -> ps2toolchain-*
FROM ps2dev/ps2dev:latest

MAINTAINER Bignaux Ronan ronan@aimao.org

# need testing for repo
RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && apk update
RUN apk add --no-cache build-base git zip gawk ripgrep tzdata python3 py3-pip repo gpg-agent openssh-client

# RUN pip3 install -r requirements.txt

RUN git config --global --add safe.directory /app
RUN git config --global user.email "you@example.com"
RUN git config --global user.name "Your Name"
RUN git config --global color.diff auto

ENV PS2_WORKSPACE /workspace
