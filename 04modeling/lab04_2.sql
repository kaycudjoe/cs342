-- This command file loads an experimental person database.
-- The data conforms to the following assumptions:
--     * People can have 0 or many team assignments.
--     * People can have 0 or many visit dates.
--     * Teams and visits don't affect one another.
--
-- CS 342, Spring, 2017
-- kvlinden, kec32

DROP TABLE PersonTeam;
DROP TABLE PersonVisit;

CREATE TABLE PersonTeam (
	personName varchar(10),
    teamName varchar(10)
	);

CREATE TABLE PersonVisit (
	personName varchar(10),
    personVisit date
	);

-- Load records for two team memberships and two visits for Shamkant.
INSERT INTO PersonTeam VALUES ('Shamkant', 'elders');
INSERT INTO PersonTeam VALUES ('Shamkant', 'executive');
INSERT INTO PersonVisit VALUES ('Shamkant', '22-FEB-2015');
INSERT INTO PersonVisit VALUES ('Shamkant', '1-MAR-2015');

-- Query a combined "view" of the data of the form View(name, team, visit).
SELECT pt.personName, pt.teamName, pv.personVisit
FROM PersonTeam pt, PersonVisit pv
WHERE pt.personName = pv.personName;

/*
a. Functional dependencies:
	personName -> teamName
	personName -> personVisit
	personName -> teamName | personVisit

	It's a multi-valued dependency because personName independently set teamName and personVisit
		
	There are no non trivial functional dependencies where the left hand side is not a superkey. Hence, both tables are in BCNF. 
	There are no non trivial multi-valued dependencies where the left hand side is not a superkey. Hence, both tables are in 4NF. 

b. BCNF?
	There exiSt no non-trivial functional dependencies where the left hand side is not a superkey. So, this view is in BCNF
	
	4NF?
	personName ->> teamName | personVisit
	The table has two multi valued dependencies and this violates 4NF. 
	There exists a multi-valued dependency where the left hand side is not a superkey. So this view is not in 4NF 
	
	
c. No, the original schema and the derived "view" schema are not equally appropriate. The more appropriate option will be the original schema as it does not require the combination of the teams of the person and personVisit to be entered into the database schema. Therefore, redundancies are done away with. Also, it's easier to add more data to the original schema.
*/

--Homework 4.2 d
drop table PersonView;

create table PersonView (
	name varchar(15),
	team varchar(10),
	visit date
	);

insert into PersonView (name, team, visit)

SELECT pt.personName, pt.teamName, pv.personVisit
FROM PersonTeam pt, PersonVisit pv
WHERE pt.personName = pv.personName;
	
SELECT * from PersonView;
