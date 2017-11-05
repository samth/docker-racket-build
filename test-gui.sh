# Like the `test.sh` script, but for GUI tests. These tests require a running X
# server (run with xvfb for a fake X backend) and several GUI-related foreign
# libraries. Test commands that are prefixed with "xvfb-run" should instead
# rely on a single shared X server, since it's easier and more intuitive to run
# one in its own Docker container that's shared for all tests.
set -eufx

# samth
racket -l typed-racket-test -- --all

# jay
raco test -c tests/xml # needs gui libs for XML snips
raco test -c plai

# robby
racket -l 2htdp/tests/bitmap-as-image-in-universe
racket -l 2htdp/tests/image-equality-performance-htdp
racket -l 2htdp/tests/image-equality-performance
racket -l 2htdp/tests/image-too-large
racket -l 2htdp/tests/test-image

raco test -c framework/tests

raco test -p pcps-test
