/*
Karen Cudjoe
CS 342
Lab 7.1
*/

-- Create a view that for the CPDB “birthday czar” that includes each person’s full name, age (using TRUNC(MONTHS_BETWEEN(SYSDATE, birthdate)/12) ) and birthdate (only), and then write commands that:
CREATE VIEW birthday_czar
AS SELECT firstName, lastName, TRUNC(MONTHS_BETWEEN(SYSDATE, birthdate)/12) Age, birthdate
FROM Person;

-- a. Retrieve the GenX people from the database (i.e., those born from 1961–1975).
SELECT firstName ||' '|| lastName as Person_Name, Age, Birthdate
FROM birthday_czar
WHERE birthdate >= '01-JAN-1961' AND birthdate <= ' 31-DEC-1975';


-- b. Update the Person base table to include a GenX birthdate for some person who had a NULL birthdate before. Now, try to re-run your query on the view from the previous question. Do the results of the view query change? Why or why not?
UPDATE Person
SET birthdate = '23-JULY-1972'
WHERE ID = 5;

SELECT firstName ||' '|| lastName as Person_Name, Age, Birthdate
FROM birthday_czar 
WHERE birthdate >= '01-JAN-1961' AND birthdate <= ' 31-DEC-1975';

-- I re-run my query on the view from the previous question and the reults of the view query change. birthday_czar is a non-materialized view. Therefore, the view is implemented via query modification - the view query is tranformed into a query on the underlying base tables.


-- c. Insert a new person using your new view. If this doesn’t work, explain (but do not implement) the modifications you’d have to make to your view so that it does. Be sure that you understand what is required for a view to be updateable and what happens to the fields of the inserted record in the base table not included in the view.
INSERT INTO birthday_czar VALUES ('Liz', 'Sackey', 29, '21-APR-1986');
-- This doesn't work as my view is not key preserved (the relationship between view and the table is not key preserved). Age is computed from a birthdate so a birthdate cannot be computed from the age. To modify this, I will select the ID from the person table instead of the age when creating the view. 

-- d. Drop your new view. Does this affect your base tables in any way?
drop VIEW birthday_czar;
-- No, this doesn't affect my base table in any way as the view was just pulling values from the table. 