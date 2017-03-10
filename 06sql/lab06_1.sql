/*
Karen Cudjoe
CS 342
*/

-- Exercise 6.1
@drop.sql
@schema.sql
@data.sql

--a. 
SELECT t.Name, t.mandate, pt.personID 
FROM (Team t 
LEFT OUTER JOIN PersonTeam pt
ON pt.role = 'chair'
AND pt.teamName = t.Name
);

