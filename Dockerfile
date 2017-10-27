FROM ubuntu:17.10
ARG version="6.10.1.900"

# Setup

RUN apt-get update
RUN apt-get install -y wget

# Test the regular installer

RUN wget http://pre-release.racket-lang.org/installers/racket-$version-x86_64-linux.sh

RUN sh ./racket-$version-x86_64-linux.sh --in-place --dest ./racket-in-place
RUN ./racket-in-place/bin/racket -e '(+ 1 2)'

RUN sh ./racket-$version-x86_64-linux.sh --unix-style --dest /usr
RUN /usr/bin/racket -e '(+ 1 2)'

RUN /usr/bin/racket-uninstall
RUN rm -rf ./racket-in-place/

# Test the minimal installer

RUN wget http://pre-release.racket-lang.org/installers/racket-minimal-$version-x86_64-linux.sh

RUN sh ./racket-minimal-$version-x86_64-linux.sh --in-place --dest ./racket-minimal-in-place
RUN ./racket-minimal-in-place/bin/racket -e '(+ 1 2)'

RUN sh ./racket-minimal-$version-x86_64-linux.sh --unix-style --dest /usr
RUN /usr/bin/racket -e '(+ 1 2)'

RUN /usr/bin/racket-uninstall
RUN rm -rf ./racket-minimal-in-place/

# Install a compiler

RUN apt-get build-dep -y racket

# Try building Minimal Racket

RUN wget http://pre-release.racket-lang.org/installers/racket-minimal-$version-src-builtpkgs.tgz

RUN tar -xzvf racket-minimal-$version-src-builtpkgs.tgz

WORKDIR "racket-$version/src"
RUN ./configure
RUN make -j4
RUN make -j4 install
WORKDIR ".."
RUN ./bin/racket -e '(+ 1 2)'

WORKDIR ".."

RUN rm -rf racket-$version/

# Try building regular Racket

RUN wget http://pre-release.racket-lang.org/installers/racket-$version-src-builtpkgs.tgz

RUN tar -xzvf racket-$version-src-builtpkgs.tgz

WORKDIR "racket-$version/src"
RUN ./configure
RUN make -j4
RUN make -j4 install
WORKDIR ".."
RUN ./bin/racket -e '(+ 1 2)'

WORKDIR ".."

RUN rm -rf racket-$version/



RUN tar -xzvf racket-$version-src-builtpkgs.tgz
WORKDIR "racket-$version/src"
RUN ./configure CPPFLAGS=-DTEST_ALTERNATE_TARGET_REGISTER=1
RUN make -j4
RUN make -j4 install
WORKDIR ".."
RUN ./bin/racket -e '(+ 1 2)'
WORKDIR ".."
RUN rm -rf racket-$version/

RUN tar -xzvf racket-$version-src-builtpkgs.tgz
WORKDIR "racket-$version/src"
RUN ./configure CPPFLAGS=-funsigned-char
RUN make -j4
RUN make -j4 install
WORKDIR ".."
RUN ./bin/racket -e '(+ 1 2)'
WORKDIR ".."
RUN rm -rf racket-$version/
