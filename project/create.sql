-- Create the Calvin Lifework user and database. 
-- See ../README.txt for details.

-- Create the user.
DROP USER calvinLW CASCADE;
CREATE USER calvinLW
	IDENTIFIED BY kec32password
	QUOTA 5M ON System;
GRANT 
	CONNECT,
	CREATE TABLE,
	CREATE SESSION,
	CREATE SEQUENCE,
	CREATE VIEW,
	CREATE MATERIALIZED VIEW,
	CREATE PROCEDURE,
	CREATE TRIGGER,
	UNLIMITED TABLESPACE
	TO calvinLW;

-- Connect to the user's account/schema.
CONNECT calvinLW/kec32password;


-- Set up the Oracle directory for the dump database feature.
-- Use Oracle directories for input/output files to avoid permissions problems. (?)
-- This is needed both to create and to load the *.dmp files.
DROP DIRECTORY exp_dir;
CREATE DIRECTORY exp_dir AS 'C:\Users\kec32\Documents\project';
GRANT READ, WRITE ON DIRECTORY exp_dir to calvinLW;


-- Create the database.
DEFINE calvinLW=C:\Users\kec32\Documents\project
@&calvinLW\load