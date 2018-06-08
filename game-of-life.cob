
       identification division.
       program-id. game-of-life.
       author. Esko Luontola
       data division.
       working-storage section.
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
       01 cell pic 9(1) value 0.
       01 neighbors pic 9(1) value 0.
       procedure division.
           *> Glider
           move 1 to new-columns(1,3).
           move 1 to new-columns(2,3).
           move 1 to new-columns(3,3).
           move 1 to new-columns(3,2).
           move 1 to new-columns(2,1).

           perform game-loop until new-world = old-world.
           stop run.

       game-loop.
           perform simulate.
           perform clear-screen.
           perform print-world.
           call "C$SLEEP" using 1 end-call.

       simulate.
           move new-world to old-world.
           perform iterate-world.

       iterate-world.
           perform iterate-row varying row-counter from 1 by 1 until row-counter > total-rows.
       iterate-row.
           perform iterate-cell varying column-counter from 1 by 1 until column-counter > total-columns.
       iterate-cell.
           move 0 to neighbors.
           if row-counter > 1 and column-counter > 1 then
               move old-columns(row-counter - 1, column-counter - 1) to cell
               add cell neighbors giving neighbors.
           if row-counter > 1 then
               move old-columns(row-counter - 1, column-counter + 0) to cell
               add cell neighbors giving neighbors.
           if row-counter > 1 and column-counter < total-columns then
               move old-columns(row-counter - 1, column-counter + 1) to cell
               add cell neighbors giving neighbors.

           if column-counter > 1 then
               move old-columns(row-counter + 0, column-counter - 1) to cell
               add cell neighbors giving neighbors.
           if column-counter < total-columns then
               move old-columns(row-counter + 0, column-counter + 1) to cell
               add cell neighbors giving neighbors.

           if row-counter < total-rows and column-counter > 1 then
               move old-columns(row-counter + 1, column-counter - 1) to cell
               add cell neighbors giving neighbors.
           if row-counter < total-rows then
               move old-columns(row-counter + 1, column-counter + 0) to cell
               add cell neighbors giving neighbors.
           if row-counter < total-rows and column-counter < total-columns then
               move old-columns(row-counter + 1, column-counter + 1) to cell
               add cell neighbors giving neighbors.

           move old-columns(row-counter, column-counter) to cell.
           if cell = 1 and neighbors < 2 then
               move 0 to new-columns(row-counter, column-counter).
           if cell = 1 and (neighbors = 2 or neighbors = 3) then
               move 1 to new-columns(row-counter, column-counter).
           if cell = 1 and neighbors > 3 then
               move 0 to new-columns(row-counter, column-counter).
           if cell = 0 and neighbors = 3 then
               move 1 to new-columns(row-counter, column-counter).

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
