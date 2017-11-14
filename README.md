## Docker-ized build and test of Racket releases [![Build Status](https://travis-ci.org/samth/docker-racket-build.svg?branch=full-travis)](https://travis-ci.org/samth/docker-racket-build)

##### To build a particular configuration

```
docker-compose build racket-x86-minimal
```

##### Build the testing configuration

```
docker-compose build racket-x86-minimal-test
```

##### Run the non-gui tests


```
docker-compose run racket-x86-minimal-test
```

##### Run the gui tests

```
docker-compose run racket-x86-minimal-test-gui
```


##### Run a particular command in a generated image

```
docker-compose run racket-x86-minimal-test raco test -p my-collection
```
