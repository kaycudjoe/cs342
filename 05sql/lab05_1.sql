/*
Karen Cudjoe
CS 342
*/

-- Exercise 5.1
@schema.sql
@data.sql

-- a.
SELECT * FROM Person, Household;

-- This returns the count of the records for the cross-product of all person and household records
SELECT Count (*) FROM Person, Household;
/* 
I got 128 records. This is because the number of recorsd for the cross-product is the product of the number of rowd of Person (16 rows) and the number of rows of household (8 rows)
= 16 * 8 = 128
*/

-- b. 
SELECT firstName, lastName, birthdate
FROM Person
WHERE birthdate IS NOT NULL
ORDER BY TO_CHAR(birthdate, 'DDD');

@drop.sql