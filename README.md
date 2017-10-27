

To test building and installation of various versions the current
pre-release of Racket.

```
$ sudo docker build . -t racket-build
```


To test Racket itself, using the current pre-release.

```
$ sudo docker build . -f Dockerfile-tests -t racket-test
```

