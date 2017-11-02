# This script contains test commands that are currently known to fail due to
# configuration issues or known bugs. They should be moved into the appropriate
# `test.sh` or `test-gui.sh` script once fixed.

# ryanc
# fails due to the same failures seen on drdr
raco test -l tests/macro-debugger/all-tests

# stchang
# currently fails because of check-random, fix is on master
raco test -l tests/stepper/automatic-tests

# mflatt
# fails with something about -fPIC
racket -l tests/racket/embed-in-c
# fails with unicode / locale issues
racket -l tests/compiler/embed/test
# fails with an error about #f being passed to `system*`
racket -l distro-build/tests/unix-installer
