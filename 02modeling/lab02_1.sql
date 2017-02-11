-- This command file loads a simple movies database, dropping any existing tables
-- with the same names, rebuilding the schema and loading the data fresh.
--
-- CS 342, Spring, 2015
-- kvlinden, kec32

-- Drop current database
DROP TABLE Casting;
DROP TABLE Movie;
DROP TABLE Performer;

-- Create database schema
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
	status varchar(6),
	FOREIGN KEY (movieId) REFERENCES Movie(Id) ON DELETE CASCADE,
	FOREIGN KEY (performerId) REFERENCES Performer(Id) ON DELETE SET NULL,
	CHECK (status in ('star', 'costar', 'extra'))
	);

-- Load sample data
INSERT INTO Movie VALUES (1,'Star Wars',1977,8.9, 2000);
INSERT INTO Movie VALUES (2,'Blade Runner',1982,8.6, 1500);

INSERT INTO Performer VALUES (1,'Harrison Ford');
INSERT INTO Performer VALUES (2,'Rutger Hauer');
INSERT INTO Performer VALUES (3,'The Mighty Chewbacca');
INSERT INTO Performer VALUES (4,'Rachael');

INSERT INTO Casting VALUES (1,1,'star');
INSERT INTO Casting VALUES (1,3,'extra');
INSERT INTO Casting VALUES (2,1,'star');
INSERT INTO Casting VALUES (2,2,'costar');
INSERT INTO Casting VALUES (2,4,'costar');


-- Exercise 2.1
-- a. 
--i. The command below attempts to create a repeated primary key value. This violates entity integrity. This error is thrown - "unique constraint violated".
INSERT INTO Movie VALUES (1, 'Hidden Figures', 2017, 8.7, 5000);

-- ii. The command below attempts to create a NULL primary key value. This violates domain integrity as NULL is not a valid data type for the primary key. This error is thrown - "cannot insert NULL into ("KEC32."MOVIE."ID);
INSERT INTO Movie Values (NULL, 'Hidden Figures', 2017, 8.7, 5000);

-- iii. The command below is a violation og a CHECK constraint. This violates the domain integrity as 1888 is not a valid date. This error is thrown - "check constraint violated"
INSERT INTO Movie VALUES (3, 'Promise', 1888, 7.7, 4000);

-- iv. The command below is a violation of an SQL datatype constraint. It violates domain integrity as 'yesyes' is not a float data type. This error is thrown - "invalid number"
INSERT INTO Movie VALUES (3, 'Promise', 2016, 'yesyes', 3000);

-- v. The command below tries to insert a negative score value. The score data type is a float, but it doesnt state if the float should be positive or negative. So the negative float number is a valid entry for this database. 
INSERT INTO Movie VALUES (3, 'Promise', 2016, -4, 2000);


-- b. 
-- i. The command below tries adding a new record with a NULL value for a foreign key value. This does not create any error as it is not the primary key of the table. 
INSERT INTO Casting VALUES (NULL, 2, 'star');

-- ii. The command below tries to add a foreign key value in a referencing table that doesn't match any key value in the referenced table. This error is thrown - "Integrity constraint violated - parent key not found." This is due to the fact that we can't reference a key value that doesn't exist. 
INSERT INTO Casting VALUES (7, 2, 'star');

-- iii. The command below tries adding a new record with a key value in a referenced table with no related records in the referencing table. This doesn't throw an error, as a record doesn't have to be referenced by a child table. 
INSERT INTO Performer VALUES (5, 'Moes Moss');


-- c. 
-- i. The command below tries to delete a referenced record that is referenced by a referencing record. This deletes the Movie with id 1 in the Movie table, and goes on to delete the records of the Movie with id 1 in the Casting table. 
DELETE FROM MOVIE WHERE id = 1; 

-- ii. The command below tries to delete a referencing record that references a referenced record. This works fine - it changes nothing in Movie, but changes occur in Casting as Casting needs a Movie to exist to reference it. 
DELETE FROM Casting WHERE MovieId = 1;

-- iii. The command below tries to modeify the ID of a movie record that is referenced by a casting record. This throws the error - "Integrity constraint violated - child record found". This is because it vilates referential integrity. 
UPDATE Movie
SET id = 43
WHERE year = 1982;

-- Oracle doesn't support ON UPDATE CASCADE because it is not so necessary. It is also risky to use it since it updates several tables without the coder's direct approval. 

