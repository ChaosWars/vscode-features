#!/bin/bash

set -eu

source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.

check "check version" bash -c "clang -v"
check "compile helloworld" bash -c "clang++ helloworld.cpp"
check "run helloworld" bash -c "./helloworld"

# Report results
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
