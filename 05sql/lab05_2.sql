/*
Karen Cudjoe
CS 342
*/

-- Exercise 5.2
@schema.sql
@data.sql

-- a. 
-- not correlated
SELECT *
FROM (SELECT * FROM Person 
WHERE birthdate IS NOT NULL 
ORDER BY birthdate DESC)
WHERE ROWNUM = 1;

-- b. 
-- When there are three or more people who share the same name, it creates multiple records as each new record is mapped to the other records with the same name - the number of rows will increase even further
SELECT P1.ID, P2.ID, P1.firstName, P1.lastname
FROM Person P1, Person P2
WHERE P1.ID <> P2.ID
AND P2.firstName = P1.firstName;


-- c. 
-- not correlated
SELECT P.firstName, P.lastname
FROM Person P, PersonTeam PT
WHERE P.ID = PT.PersonID
AND PT.teamName = 'Music'
	AND NOT EXISTS (SELECT *
			FROM Homegroup hg
			WHERE P.homegroupID = hg.ID
			AND hg.name = 'Byl');

-- correlated			
(SELECT P.firstName, P.lastname
FROM Person P, PersonTeam PT
WHERE P.ID = PT.PersonID
AND PT.teamName = 'Music')
	MINUS (SELECT P.firstName, P.lastName
			FROM Homegroup hg, Person P
			WHERE P.homegroupID = hg.ID
			AND hg.name = 'Byl');
			
			
@drop.sql