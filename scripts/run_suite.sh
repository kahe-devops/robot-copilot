#!/bin/sh
set -e

# Run an individual test suite if the TEST_SUITE environmental variable is set.
if [ -z "$TEST_SUITE" ]; then
    TEST_SUITE=""
fi

CMD="robot --console verbose --outputdir /opt/robotframework/reports /opt/robotframework/tests/$TEST_SUITE"

echo ${CMD}

``${CMD}``