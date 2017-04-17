/*
Karen Cudjoe
CS 342
Homework 09_2
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

-- 2. Get the number of movies directed by each director who's directed more than 200 movies.
-- First Try
SELECT d.firstName, d.lastName, COUNT(movieID)
FROM Director d, MovieDirector md
WHERE  d.id = md.directorId
Group By d.firstName, d.lastName
Having count(movieID) > 200;

/*
Elapsed: 00:00:00.23

Execution Plan
----------------------------------------------------------
Plan hash value: 2646178372

--------------------------------------------------------------------------------
--------------

| Id  | Operation            | Name          | Rows  | Bytes |TempSpc| Cost (%CP
U)| Time     |

--------------------------------------------------------------------------------
--------------

|   0 | SELECT STATEMENT     |               | 19033 |   576K|       |  2089   (
1)| 00:00:26 |

|*  1 |  FILTER              |               |       |       |       |
  |          |

|   2 |   HASH GROUP BY      |               | 19033 |   576K|    14M|  2089   (
1)| 00:00:26 |

|*  3 |    HASH JOIN         |               |   380K|    11M|  2800K|   836   (
1)| 00:00:11 |

|   4 |     TABLE ACCESS FULL| DIRECTOR      | 86880 |  1781K|       |    86   (
2)| 00:00:02 |

|   5 |     TABLE ACCESS FULL| MOVIEDIRECTOR |   380K|  3717K|       |   215   (
1)| 00:00:03 |

--------------------------------------------------------------------------------
*/


-- Second Try

CREATE index movieDirectorIdIndex ON MovieDirector(directorId);

SELECT d.firstName, d.lastName, COUNT(1)
FROM Director d, MovieDirector md
WHERE d.id = md.directorId
GROUP BY d.firstName, d.lastName
HAVING COUNT(1) > 200;

drop index movieDirectorIdIndex;

/*
Elapsed: 00:00:00.25

Execution Plan
----------------------------------------------------------
Plan hash value: 2646178372

--------------------------------------------------------------------------------
--------------

| Id  | Operation            | Name          | Rows  | Bytes |TempSpc| Cost (%CP
U)| Time     |

--------------------------------------------------------------------------------
--------------

|   0 | SELECT STATEMENT     |               | 19033 |   483K|       |  1833   (
1)| 00:00:22 |

|*  1 |  FILTER              |               |       |       |       |
  |          |

|   2 |   HASH GROUP BY      |               | 19033 |   483K|    11M|  1833   (
1)| 00:00:22 |

|*  3 |    HASH JOIN         |               |   380K|  9665K|  2800K|   745   (
1)| 00:00:09 |

|   4 |     TABLE ACCESS FULL| DIRECTOR      | 86880 |  1781K|       |    86   (
2)| 00:00:02 |

|   5 |     TABLE ACCESS FULL| MOVIEDIRECTOR |   380K|  1858K|       |   215   (
1)| 00:00:03 |

--------------------------------------------------------------------------------
*/



/*
My attempts are listed above.
My first attempt was done without an index. I joined the Director and MovieDirector tables and selected the director firstame, director lastname, and the number of movies directed.

For the second attempt, I used an index on the MovieDirector table as I thought this will make searching through the MovieDirector table much faster.
The runtime for this attempt was however almost the same as the first.
The execution plan of both attempt are also the same as they both require a 'Table Access Full'
Either attempt can be chosen but I choose attempt one. This is because it is easier to do, and I dont have to spend time creating an index which will turn out to be not useful.
*/
