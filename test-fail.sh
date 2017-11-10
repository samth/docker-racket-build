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
# Tests don't exist in 6.11 release yet, they're only on master
# WARNING: pack.rktl writes to collects dirs, so it's probably best to run this
# one last to avoid test environment issues.
racket -l tests/racket/test-pack

# GUI FAILURES

# Fails due to font & rendering differences
racket -l redex/tests/run-tests

# mflatt
# Fails due to suspected directory problems. Investigate why this needs
# its own directory, possibly use explicit /tmpdir or edit test to avoid
# directory dependency entirely.
mkdir test-dir
cd test-dir
racket -l tests/gracket/test
gracket -z -e 1
gracket -e 1

# TODO: Memory leak tests (in the tests/drracket/io/leak-on-run module)
# causes script to hang, possibly because of Docker killing the module
# execution process without the script properly catching the failure signal.
# The run.sh script seems to only run modules and ought to be replaced by a
# proper invocation of `raco test`.
cd `raco fc tests/drracket/io`
chmod +x run.sh
bash ./run.sh
