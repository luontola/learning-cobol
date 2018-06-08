
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
           move 1 to new-columns(4,5).
           move 1 to new-columns(5,5).
           move 1 to new-columns(6,5).

           perform game-loop until 0 = 1.
           stop run.

       game-loop.
           perform simulate.
           perform print-world.

       simulate.
           move new-world to old-world.
           perform iterate-world.

       iterate-world.
           perform iterate-row varying row-counter from 1 by 1 until row-counter > total-rows.
       iterate-row.
           perform iterate-column varying column-counter from 1 by 1 until column-counter > total-columns.
       iterate-column.
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
           display ''.
       print-row.
           display new-rows(row-counter).
