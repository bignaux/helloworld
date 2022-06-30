# helloworld

A full example repository of a Playstation 2 homebrew project.
Contribute here to demonstrate best practice.

That's not intend to be the simplest helloworld, see [fjtrujy's
helloWorldPS2](https://github.com/fjtrujy/helloWorldPS2) or ps2sdk samples.
The goal is to provide a complete template and set up standards for code, build
and distribution.

It uses [ps2homebrew's .github](https://github.com/ps2homebrew/.github) as base template.

## build instruction

just run `docker compose` :

    docker compose up make

    * Getting the sources

      ```bash
      git clone https://github.com/bignaux/helloworld.git
      repo init -u https://github.com/bignaux/helloworld.git -m helloworld_local_manifest.xml -b main
      repo sync --force-sync
      ```    




## CI/CD strategy and docker workflow

minimise code in github action to avoid :
-   possible issue from difference between developer and github environment
-   specific code on github actions
-   need git push

Use dockerfile to specify image, prefere docker compose services to jobs.

    docker pull ps2dev/ps2dev
    docker build . -t helloworld
    docker run --env-file .env -it -w /app -v "$(pwd)":/app helloworld:latest

## PS2_WORKSPACE

issue :

-   copy/paste code and ...
-   ps2sdk and ps2sdk-ports as central code repositories
-   custom script downloading component



    repo init -q --no-clone-bundle -u https://github.com/bignaux/helloworld.git

    docker compose down --volumes
    -v helloworld_workspace:/workspace

some alternatives :
-   git submodule : when you want shared component, that not you want to add them in each project.
 It has already annoyed many contributors here.
-   [git-workspace](https://github.com/orf/git-workspace) : not project centric, you can't specifying individual
 repos [#171](https://github.com/orf/git-workspace/issues/171) . Interesting tool anyway. Could be use to maintain
 ps2dev or ps2homebrew docker volume, allows to be used as shared workspace.
-   [clowder](https://clowder.cat/) : as repo but yaml, less google/android centric
