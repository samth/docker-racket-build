# Like the `test.sh` script, but for GUI tests. These tests require a running X
# server (run with xvfb for a fake X backend) and several GUI-related foreign
# libraries. Test commands that are prefixed with "xvfb-run" should instead
# rely on a single shared X server, since it's easier and more intuitive to run
# one in its own Docker container that's shared for all tests.
set -eufx

# TODO: This script doesn't actually work yet. Commands that are known to fail
# should be moved to the test-fail.sh script.

# samth
xvfb-run racket -l typed-racket-test -- --all

# jay
xvfb-run raco test -c tests/xml # needs gui libs for XML snips
xvfb-run raco test -c plai

# robby
xvfb-run racket -l 2htdp/tests/bitmap-as-image-in-universe
xvfb-run racket -l 2htdp/tests/image-equality-performance-htdp
xvfb-run racket -l 2htdp/tests/image-equality-performance
xvfb-run racket -l 2htdp/tests/image-too-large
xvfb-run racket -l 2htdp/tests/test-image

xvfb-run raco test -c framework/tests

# fails due to font & rendering differences
xvfb-run racket -l redex/tests/run-tests

# mflatt
# TODO: investigate why this needs its own directory, possibly use explicit
# /tmpdir or edit test to avoid directory dependency entirely.
mkdir test-dir
cd test-dir
xvfb-run racket -l tests/gracket/test
xvfb-run gracket -z -e 1
xvfb-run gracket -e 1

cd `raco fc pcps-test`
for i in *.rkt; do racket -t $i; done
for i in *.ss; do racket -t $i; done

cd `raco fc tests/drracket/io`
chmod +x run.sh
bash ./run.sh
