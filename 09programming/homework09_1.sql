/*
Karen Cudjoe
CS 342
Homework 09_1
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

SET AUTOTRACE ON;
SET SERVEROUTPUT ON;
SET TIMING ON;

—- 1. Get the movies directed by Clint Eastwood.
-- First try
SELECT m.id, m.name
FROM Movie m, Director d, MovieDirector md
WHERE m.id = md.movieId
AND d.id = md.directorId
AND d.firstName = 'Clint'
AND d.lastName = 'Eastwood';

/*
Elapsed: 00:00:00.12

Execution Plan
----------------------------------------------------------
Plan hash value: 3700107762

--------------------------------------------------------------------------------
--------------

| Id  | Operation                    | Name          | Rows  | Bytes | Cost (%CP
U)| Time     |

--------------------------------------------------------------------------------
--------------

|   0 | SELECT STATEMENT             |               |     1 |    56 |   304   (
2)| 00:00:04 |

|   1 |  NESTED LOOPS                |               |       |       |
  |          |

|   2 |   NESTED LOOPS               |               |     1 |    56 |   304   (
2)| 00:00:04 |

|*  3 |    HASH JOIN                 |               |     1 |    31 |   302   (
2)| 00:00:04 |

|*  4 |     TABLE ACCESS FULL        | DIRECTOR      |     1 |    21 |    86   (
2)| 00:00:02 |

|   5 |     TABLE ACCESS FULL        | MOVIEDIRECTOR |   380K|  3717K|   215   (
1)| 00:00:03 |

|*  6 |    INDEX UNIQUE SCAN         | SYS_C008002   |     1 |       |     1   (
0)| 00:00:01 |

|   7 |   TABLE ACCESS BY INDEX ROWID| MOVIE         |     1 |    25 |     2   (
0)| 00:00:01 |

--------------------------------------------------------------------------------

*/

--Second try
CREATE INDEX dIndex ON Director(firstName, lastName);
CREATE Index mdIndex ON MovieDirector(directorId, movieId);

SELECT m.ID, m.name
FROM Movie m, Director d, MovieDirector md
where d.id = md.directorId
and md.movieId = m.id
and d.firstName = 'Clint'
and d.lastName = 'Eastwood';

DROP index mdIndex;
DROP INDEX dIndex;

/*
Elapsed: 00:00:00.07

Execution Plan
----------------------------------------------------------
Plan hash value: 3389412046

--------------------------------------------------------------------------------
--------------

| Id  | Operation                      | Name        | Rows  | Bytes | Cost (%CP
U)| Time     |

--------------------------------------------------------------------------------
--------------

|   0 | SELECT STATEMENT               |             |     4 |   224 |    12   (
0)| 00:00:01 |

|   1 |  NESTED LOOPS                  |             |       |       |
  |          |

|   2 |   NESTED LOOPS                 |             |     4 |   224 |    12   (
0)| 00:00:01 |

|   3 |    NESTED LOOPS                |             |     4 |   124 |     4   (
0)| 00:00:01 |

|   4 |     TABLE ACCESS BY INDEX ROWID| DIRECTOR    |     1 |    21 |     2   (
0)| 00:00:01 |

|*  5 |      INDEX RANGE SCAN          | DINDEX      |     1 |       |     1   (
0)| 00:00:01 |

|*  6 |     INDEX RANGE SCAN           | MDINDEX     |     4 |    40 |     2   (
0)| 00:00:01 |

|*  7 |    INDEX UNIQUE SCAN           | SYS_C008002 |     1 |       |     1   (
0)| 00:00:01 |

|   8 |   TABLE ACCESS BY INDEX ROWID  | MOVIE       |     1 |    25 |     2   (
0)| 00:00:01 |

--------------------------------------------------------------------------------
*/

/*
My attempts are listed above. 
My first attempt was done without an index. I used an index on the MovieDirector table and an index on the Director table for the rest. 
I could have created an index on the Director table using the ID. This is however not necessary as Oracle builds indexes on keys by itself. 

The query uses INDEX RANGE SCAN, TABLE ACCESS BY INDEX ROWID and INDEX UNIQUE SCAN. 
The indexes used helped because an INDEX RANGE SCAN is done on the Director and MovieDirector tables, which doesnt read in the whole table, unlike the query without the index which uses a TABLE ACCESS FULL.
This makes it much faster.  

The query which uses an index on the MovieDirector table, switched a hash join to a nested loop, which is faster. 
*/



