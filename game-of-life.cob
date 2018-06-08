
       identification division.
       program-id. game-of-life.
       author. Esko Luontola
       data division.
       working-storage section.
       01 old-world.
         05 old-rows occurs 10 times.
           10 old-columns occurs 10 times.
             15 pic 9 value 0.
       01 new-world.
         05 new-rows occurs 10 times.
           10 new-columns occurs 10 times.
             15 pic 9 value 0.
       01 print-counter pic 9(2) value 0.
       procedure division.
           move 1 to new-columns(4,5)
           move 1 to new-columns(5,5)
           move 1 to new-columns(6,5)
           perform print-world.
       stop run.

       print-world.
           move 1 to print-counter.
           perform display-row until print-counter is equal to 11.

       display-row.
           display new-rows(print-counter).
           add 1 to print-counter.
