#!/bin/sh
set -eu
./run.sh game-of-life.cob | sed 's/\x1B\[2J/----------/' > test-game-of-life.actual
diff --unified=10 test-game-of-life.expected test-game-of-life.actual | more
