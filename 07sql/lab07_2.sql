/* Karen Cudjoe
CS 342
Lab 7.1
*/

-- update the person with ID = 7 to have a birthday before 1961
UPDATE Person
SET birthdate = '14-JUNE-1960'
WHERE ID = 7;

-- Repeat the previous exercise, but this time use a materialized view. Pay particular attention to what changes in the view and in the table respectively.

-- Create a view that for the CPDB “birthday czar” that includes each person’s full name, age (using TRUNC(MONTHS_BETWEEN(SYSDATE, birthdate)/12) ) and birthdate (only), and then write commands that:
CREATE MATERIALIZED VIEW birthday_czar
AS SELECT firstName, lastName, TRUNC(MONTHS_BETWEEN(SYSDATE, birthdate)/12) Age, birthdate
FROM Person;


-- a. Retrieve the GenX people from the database (i.e., those born from 1961–1975).
SELECT *
FROM birthday_czar
WHERE birthdate >= '01-JAN-1961' AND birthdate <= '31-DEC-1975';


-- b. Update the Person base table to include a GenX birthdate for some person who had a NULL birthdate before. Now, try to re-run your query on the view from the previous question. Do the results of the view query change? Why or why not?
UPDATE Person
SET birthdate = '14-JUNE-1970'
WHERE ID = 7;

SELECT *
FROM birthday_czar
WHERE birthdate >= '01-JAN-1961' AND birthdate <= '31-DEC-1975';
-- I re-run my query on the materialized view from the previous question and the reults of the view query did not change. birthday_czar is a materialized view, hence the view does not reflect any new changes to the base tables.


-- c. Insert a new person using your new view. If this doesn’t work, explain the modifications you’d have to make to your view so that it does. Be sure that you understand what is required for a view to be updateable and what happens to the fields of the new record in the base table that are not included in the view.
INSERT INTO birthday_czar VALUES ('Liz', 'Sackey', 29, '21-APR-1986');

-- This throws the error 'data manupulation operation not legal on this view'. This is because you cannot insert into the materialized view unless the view is created using 'FOR UPDATE AS' as opposed to 'AS'. Using 'AS' made the view read-only. Therefore, using 'FOR UPDATE AS' instead of 'AS' will enable it to work. Also, instead of storing the age, I will store the birthdate and store the person ID as well. The implementation will be as follows
-- CREATE MATERIALIZED VIEW birthday_czar FOR UPDATE AS
-- SELECT ID, firstName, lastName, birthdate
-- FROM Person;

-- the updated query will be 
-- INSERT INTO birthday_czar VALUES ('Liz', 'Sackey', 29, '21-APR-1986');


-- d. Drop your new view. Does this affect your base tables in any way?
DROP MATERIALIZED VIEW birthday_czar;
-- dropping the new view does not affect the base tables in any way