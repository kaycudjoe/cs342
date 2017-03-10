/*
Karen Cudjoe
CS 342
*/

-- Exercise 5.3
@drop.sql
@schema.sql
@data.sql

--a. 
SELECT p1.lastName ||', '|| p1.firstName ||' and '|| p2.firstName ||' - '|| h.phoneNumber ||' - '|| h.street AS Family_Entries
FROM Person p1 JOIN Person p2 ON p1.householdID = p2.householdID AND p1.ID < p2.ID
JOIN Household h ON p2.householdID = h.ID AND p2.householdRole <> 'child';

--b. 
SELECT p1.lastName ||', '|| p1.firstName ||' and '|| p2.firstName ||' , '|| P2.lastName ||' - '|| h.phoneNumber ||' - '|| h.street AS Family_Entries
FROM Person p1 JOIN Person p2 ON p1.householdID = p2.householdID AND p1.ID < p2.ID
JOIN Household h ON p2.householdID = h.ID 
AND p2.householdRole <> 'child'; 

-- c. 
SELECT p1.lastName ||', '|| p1.firstName ||' and '|| p2.firstName ||' , '|| P2.lastName ||' - '|| h.phoneNumber ||' - '|| h.street AS Family_Entries
FROM Person p1 JOIN Person p2 ON p1.householdID = p2.householdID AND p1.ID < p2.ID
JOIN Household h ON p2.householdID = h.ID 
AND p2.householdRole <> 'child'
UNION
SELECT p.lastName ||', '|| p.firstName ||' - '|| h.phoneNumber ||' - '|| h.street AS Family_Entries
FROM Person p
JOIN Household h ON p.householdID = h.ID
WHERE p.householdRole = 'single';