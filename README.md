# helloworld

A full example repository of a Playstation 2 homebrew project.
Contribute here to demonstrate best practice.

That's not intend to be the simplest helloworld, see [fjtrujy's
helloWorldPS2](https://github.com/fjtrujy/helloWorldPS2) or ps2sdk samples.
The goal is to provide a complete template and set up standards for code, build
and distribution.

It uses [ps2homebrew's .github](https://github.com/ps2homebrew/.github) as base template.

## build instruction

using `docker compose` :

    docker compose up

TODO:
*   document CI/docker strategy
*   introducing $GIT_WORKSPACE

*   `git submodule` : when you want shared component, that not you want to add them in each project.
*   `[git-workspace]`(https://github.com/orf/git-workspace) : not project centric, you can't specifying individual
 repos [#171](https://github.com/orf/git-workspace/issues/171) . Interesting tool anyway. Could be use to maintain
 ps2dev or ps2homebrew docker volume, allows to be used as shared workspace.
