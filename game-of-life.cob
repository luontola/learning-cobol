
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
       01 counter pic 9(2) value 0.
       procedure division.
           perform display-row until counter is equal to 11.
       stop run.

       display-row.
           display new-rows(counter).
           add 1 to counter.
