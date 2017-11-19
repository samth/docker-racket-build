# Environment files for docker-compose

This directory contains various environment files that can be used to configure
the root `docker-compose.yml` file, making it easier to change which version of
Racket is tested.

## Usage instructions

Choose one of the available environment files (named something like "foo.env")
and replace the root `.env` file with a copy of the chosen environment file.
Then, add a `RACKET_VERSION=some-version` variable declaration with the desired
Racket version (e.g. 6.11.0.1). **Be sure to add the RACKET_VERSION declaration
before all other variable declarations**, as some environment files use
`RACKET_VERSION` to configure other variables. Update the `# From:` line if
you're committing the change to Git instead of only changing the config for
local development.

Once you've updated the environment file run `docker-compose` commands as you
normally would; the `.env` file will automatically be used to configure the
`docker-compose.yml` file. The `.env` file checked into the repo source
specifies the current default configuration, which also tells Travis CI what
installers to test.

## Available environments

At present, environments are defined for using the current snapshot installer
and for using any official release installers. An environment for using the
current prerelease installer is not yet defined.

## Why?

Racket installers aren't centrally organized and cataloged very well, and
different sources of installers for different versions use different naming
conventions for the installer download URLs. This makes it hard to automate and
script installation of a particular Racket version for a particular platform.
We'll have to make do with these environment files until that problem is
resolved. See [this github issue][1] for more discussion.

[1]: https://github.com/samth/docker-racket-build/issues/28
