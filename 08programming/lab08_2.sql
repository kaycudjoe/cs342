/*
Karen Cudjoe
CS 342
Lab 08_2
*/

-- Exercise 8.2

SET SERVEROUTPUT ON;

-- Insert yout results into this table
CREATE TABLE SequelsTemp (
	id INTEGER,
	name varchar2(100),
	PRIMARY KEY(id)
);

CREATE OR REPLACE PROCEDURE getSequels(movieIDIn IN Movie.id%type) AS
	CURSOR seq_movie IS
	SELECT s.id, s.name
	FROM Movie m, Movie s
	WHERE m.ID = movieIDIn
	AND m.sequelID = s.id;
	
BEGIN
	for sequel in seq_movie LOOP
		IF sequel.ID IS NOT NULL then
			INSERT INTO SequelsTemp VALUES (sequel.ID, sequel.name);
			getSequels(sequel.ID);
		END IF;
	END LOOP;
END;
/


-- Get the sequels for Ocean's 11, i.e., 4 of them.
BEGIN  getSequels(238071);  END;
/
SELECT * FROM SequelsTemp;

-- Get the sequels for Ocean's Fourteen, i.e., none.
BEGIN  getSequels(238075);  END;
/
SELECT * FROM SequelsTemp;

-- Clean up.
DROP TABLE SequelsTemp;