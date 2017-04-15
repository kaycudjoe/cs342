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


CLEAR SCREEN;
SET AUTOTRACE ON;
SET SERVEROUTPUT ON;
SET TIMING ON;
SET WRAP OFF;

—- 1. Get the movies directed by Clint Eastwood.
-- First try
SELECT m.id, m.name
FROM Movie m, Director d, MovieDirector md
WHERE m.id = md.movieId
AND d.id = md.directorId
AND d.firstName = 'Clint'
AND d.lastName = 'Eastwood';
-- Runtime: 0.03 seconds.


--Second try
CREATE Index mdIndex ON MovieDirector(directorId, movieId);

SELECT m.ID, m.name
FROM Movie m, Director d, MovieDirector md
where d.id = md.directorId
and md.movieId = m.id
and d.firstName = 'Clint'
and d.lastName = 'Eastwood';
	-- Runtime: 0.01 seconds
drop index mdIndex;


-- Third try
CREATE INDEX dIndex ON Director(firstName, lastName);

SELECT m.id, m.name
FROM Movie m, Director d, MovieDirector md
WHERE m.id = md.movieId
AND d.id = md.directorId
AND d.firstName = 'Clint'
AND d.lastName = 'Eastwood';

DROP INDEX dIndex;
-- This averaged a runtime of 0.03 seconds.

/*
My three attempts are listed above. My first attempt was done without an index.
I used an index on the MovieDirector table for the second one and an index on the
Director table for the third one.
The attempt using the index on the moviedirector table had the best average run time.
In try 2, the database does a 'Table Access by Index RowID' operation on the MovieDirector instead of a 'Table Access Full'.
In try 3, the database does a 'Table Access by Index RowID' operation on the Director instead of a 'Table Access Full'.
I choose attempt two because the index used on the MovieDirector table makes the run time faster than the two other tries as it doesn’t use a 'Table Access Full'.
*/
