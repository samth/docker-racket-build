## Docker-ized build and test of Racket releases [![Build Status](https://travis-ci.org/samth/docker-racket-build.svg?branch=full-travis)](https://travis-ci.org/samth/docker-racket-build)

This repository provides Dockerfiles and `docker-compose` configuration for
installing and testing Racket versions, including official releases and
snapshot versions. The goal of this project is to reduce the manual effort
required to test and release new Racket versions, see the [Release Overview][1]
wiki page for details on that process.

### Quickstart `docker-compose` example commands

```shell
# Build a Racket installation
docker-compose build racket-x86-minimal

# Run a REPL in a built installation
docker-compose run racket-x86-minimal

# Build non-GUI release tests for an installation
docker-compose build racket-x86-minimal-test

# Run previously-built non-GUI release tests
docker-compose run racket-x86-minimal-test

# Start the GUI browser debugging services in the background
docker-compose up -d nginx

# Build and run GUI release tests
docker-compose build racket-x86-minimal-test-gui
docker-compose run racket-x86-minimal-test-gui
# Now open localhost in your browser (if debugging services are up)

# Run a different command in an already built image
docker-compose run racket-x86-minimal-test raco test -p my-collection
```

### Docker configuration overview

The [Docker Compose][2] configuration in `docker-compose.yml` defines a few
services for each installer variant:

- A `racket-{installer}` service on top of an image that simply installs Racket
and builds all installed packages. Running a container from this service drops
you into a Racket REPL.
- A `racket-{installer}-test` service built on top of the corresponding
`racket-{installer}` service. Running a container from this service runs
automated non-GUI release tests, specifically it runs the `test.sh` script.
- A `racket-{installer}-test-gui` service that's like the `-test` service, but
it runs GUI tests using an X server external to the service.

Several services are defined for use by the GUI tests, including:

- An X11 server implemented by `xvfb` used directly by the `-test-gui`
services. Unfortunately the X11 protocol is difficult to proxy in a
transparently distributed way, so only *one* `xvfb` container may be run at a
time and GUI test containers can't share the same container.
- A few proxy services that convert a read-only connection to the X11 service
into a VNC connection over Websockets. Like the X11 protocol, this is hard to
autoscale and only one container of each of these proxy services (`x11vnc` and
`websockify`) may be run at once.
- An NGINX webserver and a small service that builds the `noVNC` JS HTML5 app,
with the webserver hosting the app at `localhost:80`. The app connects to the
VNC-over-Websockets connection letting you watch what the GUI tests are doing
to the X11 server in real time by opening your browser and pressing the
"connect" button.

### Installer variants

Not all installer variants are installed and tested. The following is a
complete list of installer names used in the `racket-{installer}` services:

| Name  | Meaning |
| --- | --- |
| `i386` | Linux 32-bit installer for main-distribution Racket |
| `i386-minimal` | Linux 32-bit installer for minimal Racket |
| `x86` | Linux 64-bit installer for main-distribution Racket |
| `x86-minimal` | Linux 64-bit installer for minimal Racket |
| `x86-natipkg` | Linux 64-bit installer for main-distribution Racket with bundled OS libraries |
| `x86-natipkg-minimal` | Linux 64-bit installer for minimal Racket with bundled OS libraries |

[1]: https://github.com/racket/racket/wiki/Release-overview
[2]: https://docs.docker.com/compose/
