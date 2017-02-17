-- Starter code for lab 3.
--
-- CS 342, Spring, 2017
-- kvlinden, kec32

drop table PersonTeam;
drop table Person;
drop table Homegroup;
drop table HouseHold;
drop table Team;


create table HouseHold(
	ID integer PRIMARY KEY,
	street varchar(30),
	city varchar(30),
	state varchar(2),
	zipcode char(5),
	phoneNumber char(12)
	);
	
CREATE TABLE Homegroup (
	ID integer PRIMARY Key,
	groupName varchar (20)
	);
	
create table Person (
	ID integer PRIMARY KEY,
	title varchar(4),
	firstName varchar(15),
	lastName varchar(15),
	membershipStatus char(1) CHECK (membershipStatus IN ('m', 'a', 'c')),
	householdID integer NOT NULL,
	mentorID integer,
	homegroupID integer,
	FOREIGN KEY (householdID) REFERENCES Household (ID) ON DELETE CASCADE, 
	FOREIGN KEY (mentorID) REFERENCES Person (ID) ON DELETE SET NULL,
	FOREIGN KEY (homegroupID) REFERENCES Homegroup (ID) ON DELETE SET NULL,
	role varchar(15)
	);

CREATE TABLE Team (
	ID integer PRIMARY KEY,
	teamName varchar(20),
	description varchar(50)
	);
	
CREATE TABLE PersonTeam (
	personID integer, 
	teamID integer, 
	role varchar(25),
	beginDate date, 
	endDate date, 
	CHECK (endDate > beginDate), -- end date must be further than begin date
	FOREIGN KEY (personID) REFERENCES Person (ID) ON DELETE SET NULL, 
	FOREIGN KEY (teamID) REFERENCES Team (ID) ON DELETE SET NULL
	);
	
	
INSERT INTO Household VALUES (0,'2347 Oxford Dr. SE','Grand Rapids','MI','49506','616-243-5680');

INSERT INTO Homegroup VALUES (0, 'Bible Studies');
INSERT INTO Homegroup VALUES (1, 'Prayer Ministry');
INSERT INTO Homegroup VALUES (2, 'Jell Group');
INSERT INTO Homegroup VALUES (3, 'Habanero Group');

INSERT INTO Person VALUES (0,'mr.','Keith','VanderLinden', 'm', 0, NULL, 2, 'father');
INSERT INTO Person VALUES (1,'ms.','Brenda','VanderLinden','m', 0, 1, 0, 'mother');
INSERT INTO Person VALUES (2,'mr.','Karen','VanderLinden', 'm', 0, NULL, 1, 'daughter');
INSERT INTO Person VALUES (3,'ms.','Frank','VanderLinden','m', 0, 2, 3, 'son');
	
INSERT INTO Team VALUES (0, 'Elders', 'Pray for the body');
INSERT INTO Team VALUES (1, 'Music', 'Sing the songs well');
INSERT INTO Team VALUES (2, 'Clean up Committee', ' Clean up after service');

INSERT INTO PersonTeam VALUES (1, 1, 'Choir Director', '29-Jan-2007', '14-Feb-2015');
INSERT INTO PersonTeam VALUES (2, 0, 'Clergy', '29-Jan-2014', '14-March-2015');
INSERT INTO PersonTeam VALUES (3, 2, 'Cleaning lead', '08-June-2014', '14-Feb-2015');
                                                                                                                                                     