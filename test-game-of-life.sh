#!/bin/bash
set -u

OUTPUT=$(./run.sh game-of-life.cob)
RESULT=$?
echo "$OUTPUT" | sed 's/\x1B\[2J/----------/' > test-game-of-life.actual

# process crashed, print its output as-is
if [ $RESULT != 0 ]; then
    echo -n "$OUTPUT"
    exit $RESULT
fi

# compare output against expected
DIFF=$(diff --unified=10 test-game-of-life.expected test-game-of-life.actual)
if [ ! -z "$DIFF" ]; then
    echo "$DIFF" | more
    exit 1
fi
exit 0
