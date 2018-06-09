
       identification division.
       program-id. game-of-life.
       author. Esko Luontola
       data division.
       working-storage section.
       01 arg pic x(100) value spaces.
       01 sleep pic 9 value 1.
       01 total-rows pic 9(2) value 10.
       01 total-columns pic 9(2) value 10.
       01 old-world.
         05 old-rows occurs 10 times.
           10 old-columns occurs 10 times.
             15 pic 9 value 0.
       01 new-world.
         05 new-rows occurs 10 times.
           10 new-columns occurs 10 times.
             15 pic 9 value 0.
       01 row-counter pic 9(2) value 0.
       01 column-counter pic 9(2) value 0.
       01 x pic 9(2) value 0.
       01 y pic 9(2) value 0.
       01 row-offset pic s9 value 0.
       01 column-offset pic s9 value 0.
       01 cell pic 9 value 0.
       01 neighbors pic 9 value 0.
       procedure division.
           perform parse-cmdline-args.

           *> Glider
           move 1 to new-columns(1,3).
           move 1 to new-columns(2,3).
           move 1 to new-columns(3,3).
           move 1 to new-columns(3,2).
           move 1 to new-columns(2,1).

           perform game-loop until new-world = old-world.
           stop run.

       parse-cmdline-args.
           accept arg from argument-value.
           perform until arg = spaces
               perform parse-cmdline-arg
               move spaces to arg
               accept arg from argument-value
           end-perform.
       parse-cmdline-arg.
           if arg = "--test" then
               move 0 to sleep.

       game-loop.
           perform simulate.
           perform clear-screen.
           perform print-world.
           call "C$SLEEP" using sleep end-call.

       simulate.
           move new-world to old-world.
           perform iterate-world.

       iterate-world.
           perform iterate-row varying row-counter from 1 by 1 until row-counter > total-rows.
       iterate-row.
           perform iterate-cell varying column-counter from 1 by 1 until column-counter > total-columns.
       iterate-cell.
           perform count-neighbors.
           move old-columns(row-counter, column-counter) to cell.
           if cell = 1 and neighbors < 2 then
               move 0 to new-columns(row-counter, column-counter).
           if cell = 1 and (neighbors = 2 or neighbors = 3) then
               move 1 to new-columns(row-counter, column-counter).
           if cell = 1 and neighbors > 3 then
               move 0 to new-columns(row-counter, column-counter).
           if cell = 0 and neighbors = 3 then
               move 1 to new-columns(row-counter, column-counter).

       count-neighbors.
           move 0 to neighbors.
           *> top left
           move -1 to row-offset.
           move -1 to column-offset.
           perform count-neighbor.
           *> top center
           move -1 to row-offset.
           move +0 to column-offset.
           perform count-neighbor.
           *> top right
           move -1 to row-offset.
           move +1 to column-offset.
           perform count-neighbor.
           *> middle left
           move +0 to row-offset.
           move -1 to column-offset.
           perform count-neighbor.
           *> middle right
           move +0 to row-offset.
           move +1 to column-offset.
           perform count-neighbor.
           *> bottom left
           move +1 to row-offset.
           move -1 to column-offset.
           perform count-neighbor.
           *> bottom center
           move +1 to row-offset.
           move +0 to column-offset.
           perform count-neighbor.
           *> bottom right
           move +1 to row-offset.
           move +1 to column-offset.
           perform count-neighbor.
       count-neighbor.
           compute x = row-counter + row-offset.
           compute y = column-counter + column-offset.
           if x >= 1 and x <= total-rows and y >= 1 and y <= total-columns then
               move old-columns(x, y) to cell
               add cell neighbors giving neighbors.

       print-world.
           perform print-row varying row-counter from 1 by 1 until row-counter > total-rows.
       print-row.
           perform print-cell varying column-counter from 1 by 1 until column-counter > total-columns.
           display x"0A" with no advancing. *> newline
       print-cell.
           if new-columns(row-counter,column-counter) = 1 then
               display x"e2968a" with no advancing *> Unicode Character 'LEFT THREE QUARTERS BLOCK' (U+258A)
           else
               display ' ' with no advancing
           end-if.

       clear-screen.
           display x"1B" "[2J".
