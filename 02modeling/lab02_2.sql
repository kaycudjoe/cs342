-- This command file loads a simple movies database, dropping any existing tables
-- with the same names, rebuilding the schema and loading the data fresh.
--
--Can you modify the movies database to support the enumerated status type using the relational model itself rather than hard-coding the values in a CHECK constraint?
-- Yes, To modify the movies database to support the enumerated status type using the relational model itself, create a separate table for the statuses where you can insert in the values for the enumerated status. 
-- The benefits of doing this is to allow easy modification and inserting of the Values into this table instead of having to always change the hard coded data. 
-- The disadvantage of this will be that it is hard to remember what integer (numeric key) you used for what value. Also, you have to use 'join' to get the status name.
-- CS 342, Spring, 2015
-- kvlinden, kec32

-- Drop current database
DROP TABLE Casting;
DROP TABLE Movie;
DROP TABLE Performer;
DROP TABLE StatusPerformer;

-- Create database schema
CREATE TABLE StatusPerformer (
	id integer,
	status varchar(6),
	PRIMARY KEY(id)
	);
	
CREATE TABLE Movie (
	id integer,
	title varchar(70) NOT NULL, 
	year decimal(4), 
	score float,
	votes integer,
	PRIMARY KEY (id),
	CHECK (year > 1900)
	);

CREATE TABLE Performer (
	id integer,
	name varchar(35),
	PRIMARY KEY (id)
	);

CREATE TABLE Casting (
	movieId integer,
	performerId integer,
	StatusPerformerId integer,
	FOREIGN KEY (movieId) REFERENCES Movie(Id) ON DELETE CASCADE,
	FOREIGN KEY (performerId) REFERENCES Performer(Id) ON DELETE SET NULL,
	FOREIGN KEY (statusperformerId) REFERENCES StatusPerformer(Id) ON DELETE SET NULL
	);

-- Load sample data
INSERT INTO StatusPerformer VALUES (1, 'star');
INSERT INTO StatusPerformer VALUES (2, 'costar');
INSERT INTO StatusPerformer Values (3, 'extra');

INSERT INTO Movie VALUES (1,'Star Wars',1977,8.9, 2000);
INSERT INTO Movie VALUES (2,'Blade Runner',1982,8.6, 1500);

INSERT INTO Performer VALUES (1,'Harrison Ford');
INSERT INTO Performer VALUES (2,'Rutger Hauer');
INSERT INTO Performer VALUES (3,'The Mighty Chewbacca');
INSERT INTO Performer VALUES (4,'Rachael');

INSERT INTO Casting VALUES (1,1,1);
INSERT INTO Casting VALUES (1,3,3);
INSERT INTO Casting VALUES (2,1,1);
INSERT INTO Casting VALUES (2,2,2);
INSERT INTO Casting VALUES (2,4,2);
