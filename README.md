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

    docker compose up build

* Getting the sources

  ```bash
  git clone https://github.com/bignaux/helloworld.git
  repo init -u https://github.com/bignaux/helloworld.git -m helloworld.xml -b main
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

### Introduction

At the time of writing, there is no common workflow to manage dependancies between projects in the PS2 scene. Most written in C/C++, PS2 homebrew doesn't benefit some source/project manager, as pip for python or npm for js.

issue :

-   copy/paste code and ...
-   ps2sdk and ps2sdk-ports as central code repositories
-   custom code to manage component

2 steps should not be mixed : create the workspace, build the software.

snippet from helloworld.git/Makefile :

		tap.o:
		  $(MAKE) $@ -C $(PS2_WORKSPACE)/libs/libtap -f Makefile.PS2
	
[ps2pkgs](https://github.com/bignaux/ps2pkgs) would serve as the reference for the PS2_WORKSPACE tree structure, as there is a [FHS](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard) to serve as reference for the layout of a UNIX system. 

### use with repo
(WIP)
Since git is widely use on PS2 scene, [repo](https://gerrit.googlesource.com/git-repo/) , without introducing more complex tools like nix, bitbake or cmake.


    repo init -q -u https://github.com/bignaux/helloworld.git

some alternatives :
-   git submodule : when you want shared component, that not you want to add them in each project.
 It has already annoyed many contributors here.
-   [git-workspace](https://github.com/orf/git-workspace) : not project centric, you can't specifying individual
 repos [#171](https://github.com/orf/git-workspace/issues/171) . Interesting tool anyway. Could be use to maintain
 ps2dev or ps2homebrew docker volume, allows to be used as shared workspace.
-   [clowder](https://clowder.cat/) : as repo but yaml, less google/android centric
-   [west](https://github.com/zephyrproject-rtos/west) : as repo, but yaml from zephyrproject.


### use with docker
(WIP)

TODO: describe workflow to create/share/manage PS2_WORKSPACE volume between host and dockers containers.

    docker compose down --volumes
    -v helloworld_workspace:/workspace

### use with github action
(WIP)

TODO: describe workflow to use docker workflow with github action.