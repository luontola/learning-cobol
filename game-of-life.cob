
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
       procedure division.
           move 1 to new-columns(4,5)
           move 1 to new-columns(5,5)
           move 1 to new-columns(6,5)

           perform iterate-world.
           perform print-world.
       stop run.

       iterate-world.
           perform iterate-row varying row-counter from 1 by 1 until row-counter > total-rows.
       iterate-row.
           perform iterate-column varying column-counter from 1 by 1 until column-counter > total-columns.
       iterate-column.
           move 2 to new-columns(row-counter, column-counter).

       print-world.
           perform print-row varying row-counter from 1 by 1 until row-counter > total-rows.
       print-row.
           display new-rows(row-counter).
