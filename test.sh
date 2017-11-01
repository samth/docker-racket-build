# See "Writing Safe Shell Scripts" at https://sipb.mit.edu/doc/safe-shell/
# Note that this script is run with "sh", not bash, so pipefail isn't a thing
# We also set -x in order to see each test command in `docker-compose logs`.
set -eufx

# TODO: Ideally, these test suites should all be run with `raco test`. This
# enables proper counting of test cases and removes the need for separate
# commands. Also makes timeout logic and other test configuration easy to add.

# robby
racket -l tests/racket/contract/all
racket -l tests/racket/contract-stress-argmin
racket -l tests/racket/contract-stress-take-right

# samth
raco test -l tests/match/main

# ryanc
raco test -c tests/stxparse
raco test -c tests/data
racket -l tests/srfi/run-tests
# WARNING: high RAM usage (over 1GB on 15-inch 2012 macbook pro)
racket -l tests/db/all-tests

# robby
raco test -l tests/planet/run-all

# sstrickl
raco test -l tests/units/test-unit-contracts
racket -l tests/racket/contract/define-contract
racket -l tests/racket/contract/with-contract
racket -l tests/racket/contract/class

# stchang
raco test -l lazy/tests/main

# dvanhorn
raco test -c eopl/tests

# jay
raco test -c datalog/tests
raco test -c racklog/tests
raco test -c tests/html

# mflatt
# WARNING: pack.rktl writes to collects dirs, so it's probably best to run this
# one last to avoid test environment issues. The complex subshell expression is
# a dirty hack that ought to be replaced by a simple Racket script which
# computes the right path and calls (load). But I'm too tired right now.
racket -f "$(racket -e "(require setup/dirs) (display (path->string (find-pkgs-dir)))")/racket-test-core/tests/racket/pack.rktl"
