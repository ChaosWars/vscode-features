#!/bin/bash

set -eu

source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.

check "check version" bash -c "clang -v"
check "compile helloworld" bash -c "clang++ helloworld.cpp -o helloworld"
check "run helloworld" bash -c "./helloworld | grep 'Hello, World!'"

# Report results
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
