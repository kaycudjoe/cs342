/*
Karen Cudjoe
CS 342
*/

-- Exercise 6.2
@drop.sql
@schema.sql
@data.sql

-- a. It's using grouping because it is using the default group
SELECT TRUNC(AVG(MONTHS_BETWEEN(SYSDATE, birthdate)/12)) AS Average_age
FROM Person;

-- b. 
SELECT h.ID, COUNT (*)
FROM Household h JOIN Person p on h.ID = p.householdID
WHERE h.city = 'Grand Rapids'
GROUP BY h.ID
HAVING COUNT (*) > 1
ORDER BY COUNT (*) DESC;

-- C. 
SELECT h.ID, h.phoneNumber, COUNT (*)
FROM Household h JOIN Person p on h.ID = p.householdID
WHERE h.city = 'Grand Rapids'
GROUP BY h.ID, h.phoneNumber
HAVING COUNT (*) > 1
ORDER BY COUNT (*) DESC;
