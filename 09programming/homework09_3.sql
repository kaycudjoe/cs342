/*
Karen Cudjoe
CS 342
Homework 3
/*

/*
Implement the following SQL queries on the IMDBLarge, optimize them using physical database and SQL tuning.

For each query, include a short (one-paragraph) discussion that includes the following.

the alternate implementation forms you could have used and why you chose the one you did
the indexes your queries use (or don’t use) and why they help
the general SQL tuning heuristics you’ve deployed
Demonstrate what you’ve accomplished by reviewing the execution plans for each query.

For testing purposes, it can be helpful to run these queries on the smaller IMDB; this works provided that you relax the requirements a bit (e.g., directors with more than 2 rather than 200 movies, etc.).
*/

-- 3.
-- Get the most popular actors, where actors are designated as popular if their movies have an average rank greater than 8.5 with a movie count of at least 10 movies.
-- Try 1

select a.ID, a.firstName, a.lastName, avg(m.rank)
from Actor a, Role r, Movie m
WHERE a.id = r.actorId
AND r.movieId = m.id
GROUP BY a.ID, a.firstName, a.lastName
having avg(m.rank) > 8.5
and count(m.id) >= 10;

/*
Elapsed: 00:00:02.84

Execution Plan
----------------------------------------------------------
Plan hash value: 3980326649

--------------------------------------------------------------------------------
-------

| Id  | Operation             | Name  | Rows  | Bytes |TempSpc| Cost (%CPU)| Tim
e     |

--------------------------------------------------------------------------------
-------

|   0 | SELECT STATEMENT      |       |  2045 | 77710 |       | 14536   (2)| 00:
02:55 |

|*  1 |  FILTER               |       |       |       |       |            |
      |

|   2 |   HASH GROUP BY       |       |  2045 | 77710 |       | 14536   (2)| 00:
02:55 |

|*  3 |    HASH JOIN          |       |  3414K|   123M|    25M| 14442   (1)| 00:
02:54 |

|   4 |     TABLE ACCESS FULL | ACTOR |   817K|    16M|       |   845   (1)| 00:
00:11 |

|*  5 |     HASH JOIN         |       |  3432K|    55M|  7208K|  7592   (1)| 00:
01:32 |

|   6 |      TABLE ACCESS FULL| MOVIE |   388K|  2654K|       |   498   (1)| 00:
00:06 |

|   7 |      TABLE ACCESS FULL| ROLE  |  3432K|    32M|       |  3155   (1)| 00:
00:38 |

--------------------------------------------------------------------------------
*/

-- Try 2

create index roleIndex on Role (movieId, actorId);

select a.ID, a.firstName, a.lastName, avg(m.rank)
from Actor a, Role r, Movie m
WHERE a.id = r.actorId
AND r.movieId = m.id
group by a.ID, a.firstName, a.lastName
having avg(m.rank) > 8.5
and count(1) >= 10;

drop index roleIndex;

-- This was slow - Runtime was 2.82 seconds. 
-- I also got the following error: ORA-01652: unable to extend temp segment by 128 in tablespace SYSTEM

/*
Elapsed: 00:00:02.82

Execution Plan
----------------------------------------------------------
Plan hash value: 3980326649

--------------------------------------------------------------------------------
-------

| Id  | Operation             | Name  | Rows  | Bytes |TempSpc| Cost (%CPU)| Tim
e     |

--------------------------------------------------------------------------------
-------

|   0 | SELECT STATEMENT      |       |  8537 |   316K|       | 26374   (1)| 00:
05:17 |

|*  1 |  FILTER               |       |       |       |       |            |
      |

|   2 |   HASH GROUP BY       |       |  8537 |   316K|   156M| 26374   (1)| 00:
05:17 |

|*  3 |    HASH JOIN          |       |  3414K|   123M|    25M| 14442   (1)| 00:
02:54 |

|   4 |     TABLE ACCESS FULL | ACTOR |   817K|    16M|       |   845   (1)| 00:
00:11 |

|*  5 |     HASH JOIN         |       |  3432K|    55M|  7208K|  7592   (1)| 00:
01:32 |

|   6 |      TABLE ACCESS FULL| MOVIE |   388K|  2654K|       |   498   (1)| 00:
00:06 |

|   7 |      TABLE ACCESS FULL| ROLE  |  3432K|    32M|       |  3155   (1)| 00:
00:38 |

--------------------------------------------------------------------------------
*/


-- Try 3
create index movieIndex on Movie (ID, rank);
create index actorIndex on Actor (ID, firstName, lastName);

select a.ID, a.firstName, a.lastName, avg(m.rank)
from Actor a, Role r, Movie m
WHERE a.id = r.actorId
AND r.movieId = m.id
group by a.ID, a.firstName, a.lastName
having avg(m.rank) > 8.5
and count(1) >= 10;

drop index movieIndex;
drop index actorIndex;

/*
Elapsed: 00:00:02.86

Execution Plan
----------------------------------------------------------
Plan hash value: 3643598247

--------------------------------------------------------------------------------
---------------

| Id  | Operation                | Name       | Rows  | Bytes |TempSpc| Cost (%C
PU)| Time     |

--------------------------------------------------------------------------------
---------------

|   0 | SELECT STATEMENT         |            |  2045 | 77710 |       | 14293
(2)| 00:02:52 |

|*  1 |  FILTER                  |            |       |       |       |
   |          |

|   2 |   HASH GROUP BY          |            |  2045 | 77710 |       | 14293
(2)| 00:02:52 |

|*  3 |    HASH JOIN             |            |  3414K|   123M|    25M| 14199
(1)| 00:02:51 |

|   4 |     TABLE ACCESS FULL    | ACTOR      |   817K|    16M|       |   845
(1)| 00:00:11 |

|*  5 |     HASH JOIN            |            |  3432K|    55M|  7208K|  7349
(1)| 00:01:29 |

|   6 |      INDEX FAST FULL SCAN| MOVIEINDEX |   388K|  2654K|       |   254
(1)| 00:00:04 |

|   7 |      TABLE ACCESS FULL   | ROLE       |  3432K|    32M|       |  3155
(1)| 00:00:38 |

--------------------------------------------------------------------------------
*/

/*
The roleIndex does not seem to have an effect on the execution time.
In try 3, adding the actorIndex in this case did not increase the optimization in any way
Used Count(1) instead of Count(movieId)
Selected from only required attributes
I can't think of any alternate queries that could be faster than the first.

Used:
INDEX FAST FULL SCAN: There no longer has to be TABLE ACCESS FULL on the Movie table or the Actor table. 
TABLE ACCESS FULL: The entire index is read as a composite index is created for the ID, firstname and lastname. 
*/
