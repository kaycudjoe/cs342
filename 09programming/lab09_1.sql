/*
Karen Cudjoe
CS 342
Lab 9
Exercise 9.1
*/

SET AUTOTRACE ON; 
SET SERVEROUTPUT ON;
SET TIMING ON;


-- Build sample queries to test that:

-- a. there is a benefit to using either COUNT(1) , COUNT(*) or SUM(1) for simple counting queries.
-- Using COUNT(*)

SELECT COUNT(*) FROM Movie;

DECLARE 
	temp integer;
BEGIN	
	FOR i in 1..1000 LOOP 
		SELECT COUNT(*) INTO temp FROM Movie;
	END LOOP;
END;
/

-- Using COUNT(1)
SELECT COUNT(1) FROM Movie;

DECLARE 
	temp integer;
BEGIN	
	FOR i in 1..1000 LOOP 
		SELECT COUNT(1) INTO temp FROM Movie;
	END LOOP;
END;
/

-- Using SUM(1)
SELECT SUM(1) FROM Movie;

DECLARE 
	temp integer;
BEGIN	
	FOR i in 1..1000 LOOP 
		SELECT SUM(1) INTO temp FROM Movie;
	END LOOP;
END;
/

/*
The 3 queries contained the same plan output. Count(*) and count(1) took only about 5 seconds to complete their loop whereas SUM(1) took about 11 seconds to complete its loop. 
Therefore, there are benefits to using either COUNT(*) or COUNT(1) as compared to SUM(1) as the previous 2 are faster. 
*/


-- b. the order of the tables listed in the FROM clause affects the way Oracle executes a join query.
-- set 1
SELECT * FROM Movie m, MovieGenre mg
WHERE m.ID = mg.movieID;

SELECT * FROM MovieGenre mg, Movie m
WHERE mg.movieID = m.ID;

-- set 2
SELECT * FROM Role r, MovieGenre mg
WHERE r.movieID = m.ID;

SELECT * FROM MovieGenre mg, Role r
WHERE g.movieID = r.ID;

/*
The order of the tables listed in the FROM clause do not affect the way Oracle executes a join query. 
For both sets of queries, the execution plan outputs match. 
A TABLE ACCESS FULL is executed on the tables in an order chosen by Oracle. 
Therefore, in the 2 examples, Oracles determines a join order and uses it irrespective of how the tables are listed in the FROM Clause. 
*/


-- c. the use of arithmetic expressions in join conditions (e.g., FROM Table1 JOIN Table2 ON Table1.id+0=Table2.id+0 ) affects a query’s efficiency.
--set 1

SELECT * FROM Movie m
JOIN MovieGenre mg ON m.ID = mg.movieID;

SELECT * FROM Movie m
JOIN MovieGenre mg ON m.ID+1 = mg.movieID+1;

-- set 2
SELECT * FROM Role r
JOIN MovieGenre mg ON r.movieID = mg.movieID;

SELECT * FROM Role r
JOIN MovieGenre mg ON r.movieID+1 = mg.movieID+1;
-- In the above, the use of arithmetic expressions in join conditions affects a query’s efficiency as it increases the time elapsed by a few milliseconds.
*/

-- d. running the same query more than once affects its performance.

SELECT COUNT(*) FROM Movie m, Role r
WHERE m.ID = r.movieID;

SELECT COUNT(*) FROM Movie m, Role r
WHERE m.ID = r.movieID;

SELECT COUNT(*) FROM Movie m, Role r
WHERE m.ID = r.movieID;
-- Running the same query more than once does not change its performance. The same execution plan is maintained. The execution times of all three of my runs were 0.06 seconds. 


-- e. adding a concatenated index on a join table improves performance (see the create index command described above).
-- no index
SELECT COUNT(*) FROM Actor a, Role r
WHERE a.ID = r.actorID;

-- with index
CREATE INDEX concatIndex ON Role(actorID, movieID);

SELECT COUNT(*) FROM Actor a, Role r
WHERE a.ID = r.actorID;
-- this didn't work as Oracle gave the error message 'unable to extend temp segment by 128 in tablespace SYSTEM'.
