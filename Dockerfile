FROM ubuntu:17.10
RUN apt-get update
RUN apt-get install -y wget

# Test the regular installer

RUN wget http://pre-release.racket-lang.org/installers/racket-6.10.1.900-x86_64-linux.sh

RUN sh ./racket-6.10.1.900-x86_64-linux.sh --in-place --dest ./racket-in-place
RUN ./racket-in-place/bin/racket -e '(+ 1 2)'

RUN sh ./racket-6.10.1.900-x86_64-linux.sh --unix-style --dest /usr
RUN /usr/bin/racket -e '(+ 1 2)'

RUN /usr/bin/racket-uninstall
RUN rm -rf ./racket-in-place/

# Test the minimal installer

RUN wget http://pre-release.racket-lang.org/installers/racket-minimal-6.10.1.900-x86_64-linux.sh

RUN sh ./racket-minimal-6.10.1.900-x86_64-linux.sh --in-place --dest ./racket-minimal-in-place
RUN ./racket-minimal-in-place/bin/racket -e '(+ 1 2)'

RUN sh ./racket-minimal-6.10.1.900-x86_64-linux.sh --unix-style --dest /usr
RUN /usr/bin/racket -e '(+ 1 2)'

RUN /usr/bin/racket-uninstall
RUN rm -rf ./racket-minimal-in-place/

# Install a compiler

RUN apt-get build-dep -y racket

# Try building Minimal Racket

RUN wget http://pre-release.racket-lang.org/installers/racket-minimal-6.10.1.900-src-builtpkgs.tgz

RUN tar -xzvf racket-minimal-6.10.1.900-src-builtpkgs.tgz

WORKDIR "racket-6.10.1.900/src"
RUN ./configure
RUN make
RUN make install
WORKDIR ".."
RUN ./bin/racket -e '(+ 1 2)'

WORKDIR ".."

RUN rm -rf racket-6.10.1.900/

# Try building regular Racket

RUN wget http://pre-release.racket-lang.org/installers/racket-6.10.1.900-src-builtpkgs.tgz

RUN tar -xzvf racket-6.10.1.900-src-builtpkgs.tgz

WORKDIR "racket-6.10.1.900/src"
RUN ./configure
RUN make
RUN make install
WORKDIR ".."
RUN ./bin/racket -e '(+ 1 2)'

WORKDIR ".."

RUN rm -rf racket-6.10.1.900/



