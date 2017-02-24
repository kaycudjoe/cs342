-- This command file loads an experimental person relation.
-- The data conforms to the following assumptions:
--     * Person IDs and team names are unique for people and teams respectively.
--     * People can have at most one mentor.
--     * People can be on many teams, but only have one role per team.
--     * Teams meet at only one time.
--
-- CS 342
-- Spring, 2017
-- kvlinden, kec32

drop table AltPerson;

CREATE TABLE AltPerson (
	personId integer,
	name varchar(10),
	status char(1),
	mentorId integer,
	mentorName varchar(10),
	mentorStatus char(1),
    teamName varchar(10),
    teamRole varchar(10),
    teamTime varchar(10)
	);

INSERT INTO AltPerson VALUES (0, 'Ramez', 'v', 1, 'Shamkant', 'm', 'elders', 'trainee', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'elders', 'chair', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'executive', 'protem', 'Wednesday');
INSERT INTO AltPerson VALUES (2, 'Jennifer', 'v', 3, 'Jeff', 'm', 'deacons', 'treasurer', 'Tuesday');
INSERT INTO AltPerson VALUES (3, 'Jeff', 'm', NULL, NULL, NULL, 'deacons', 'chair', 'Tuesday');


/* 
a. The relation is not well-designed because of the following reasons:
	Informal
	- The database limits a person to just one mentor
	- There are so many NULL values in the tuples. This is becayse a lot of the attribues do not apply to all the relation's tuples. 
	- There are multiple entries for the same person (Shamkart, because he belongs to two different teams)
	- It makes it possible to get spurious tables.
	- The meeting days for some of the teams is repeated each time someone is added to the team. Eg. the meeting day for elders is repeated each time a new elder is added to the team
	- The relationship between person and team is not well defined 


	Formal
	It is not in Boyce-Codd Normal Form. 
	For BCNF, the following conditions should hold
	X --> Y is a trivial function dependency 
	X is a super key for the schema R

	Functional Dependencies:
	personID -> name, status, mentorId, mentorName, mentorStatus
	mentorID -> mentorName and mentorStatus
	teamName -> teamTime
	teamName, personID -> teamRole

	Candidate Keys: personID and teamName
	
	There are no non-trivial functional dependencies wih sub keys therefore, BCNF doesn't apply to this schema. 
	mentorID is also not super keys, so this is not BCNF. 
	There are a lot of redundancies. 

	b. Properly normalized schema for this database
	Person(personID, name, mentorID, status) where personID is the PRIMARY KEY and mentorID is a Foreign Key
	Team(teamName, teamTime)
	PersonTeam(personID, teamName, teamRole)
*/	
	
	
-- Homework Exercise 4.1 c. 
-- drop table
drop table PersonTeam;
drop table Team;
drop table Person;

-- create table
create table Person (
	ID integer PRIMARY KEY,
	name varchar (15), 
	mentorID integer, 
	status varchar (3),
	FOREIGN KEY (mentorID) REFERENCES Person(ID) ON DELETE SET NULL,
	CHECK (mentorID != ID)
);

create table Team (
	teamName varchar(15) PRIMARY KEY, 
	teamTime varchar(10)
);

create table PersonTeam (
	personID integer, 
	teamName varchar(15),
	teamRole varchar(15),
	FOREIGN KEY (personID) REFERENCES Person(ID) ON DELETE SET NULL,
	FOREIGN KEY (teamName) REFERENCES Team(teamName) ON DELETE SET NULL
);
	
-- insert data
INSERT INTO Person SELECT DISTINCT personID, name, mentorID, status FROM Altperson;
INSERT INTO Team SELECT DISTINCT teamName, teamTime FROM Altperson;
INSERT INTO PersonTeam SELECT DISTINCT personID, teamName, teamRole FROM Altperson;

-- write queries
SELECT * FROM Person;
SELECT * FROM Team;
SELECT * FROM PersonTeam;
