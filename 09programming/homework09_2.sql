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
SELECT d.ID, d.firstName, d.lastName, COUNT(movieID)
FROM Director d, MovieDirector md
WHERE  d.id = md.directorId
Group By d.ID, d.firstName, d.lastName
Having count(movieID) > 200;


-- Second Try
CREATE index movieDirectorIdIndex ON MovieDirector(directorId);

SELECT d.id, d.firstName, d.lastName, COUNT(1)
FROM Director d, MovieDirector md
WHERE d.id = md.directorId
GROUP BY d.id, d.firstName, d.lastName
HAVING COUNT(1) > 200;



drop index movieDirectorIdIndex;


/*
My attempts are listed above.
My first attempt was done without an index. I joined the Director and MovieDirector tables
and selected the director ID, director firstame, director lastname, and the number of movies directed.
For the second attempt, I used an index on the MovieDirector table as I thought this will make searching through the MovieDirector table much faster.
The runtime for this attempt was however almost the same as the first.
The execution plan of both attempt are also the same as they both require a 'Table Access Full'
In this case, either attempt can be chosen but I choose attempt one because it is easier to do, and I dont have to spend the time creating an index which will turn out to be not so useful.
*/
