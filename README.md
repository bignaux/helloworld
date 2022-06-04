# helloworld

A full example repository of a Playstation 2 homebrew project.
Contribute here to demonstrate best practice.

That's not intend to be the simplest helloworld, see [fjtrujy's
helloWorldPS2](https://github.com/fjtrujy/helloWorldPS2) or ps2sdk samples.

use [ps2homebrew's .github](https://github.com/ps2homebrew/.github) as base template.

## build instruction

get ps2sdk docker

```sh
docker pull ps2dev/ps2dev
docker run -it -w /app -v "$(pwd)":/app ps2dev/ps2dev sh
apk add build-base git zip gawk ripgrep tzdata
```

configure localtime on ps2sdk docker image:
ln -snf /usr/share/zoneinfo/Europe/Paris  /etc/localtime

## running

```sh
export PS2HOSTNAME=192.168.1.10
```
