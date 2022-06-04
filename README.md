# helloworld

A full example repository of a Playstation 2 homebrew project.
Contribute here to demonstrate best practice.

That's not intend to be the simplest helloworld, see [fjtrujy's
helloWorldPS2](https://github.com/fjtrujy/helloWorldPS2) or ps2sdk samples.
The goal is to provide a complete template and set up code standards for build
and distribution (iso,new-app-system ...).

It uses [ps2homebrew's .github](https://github.com/ps2homebrew/.github) as base template.

## build instruction

using docker compose :

```sh
docker compose run -e DEBUG=1 build
```
