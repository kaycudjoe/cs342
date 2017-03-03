-- Create the Calvin LifeWork user and database. 

-- Create the user.
DROP USER kec32 CASCADE;
CREATE USER kec32 
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
	TO kec32;

-- Connect to the user's account/schema.
CONNECT kec32/kec32password;

-- (Re)Create the database.
DEFINE kec32=S:\CS342\project\Design
@&kec32\load