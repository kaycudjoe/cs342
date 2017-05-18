/*
Karen Cudjoe
CS 342
Stored procedures for the calvinLW database
-- 05/21/2017

SET SERVEROUTPUT ON;

/* multistepTransact is stored procedure which implements a multi-step transaction.
This transaction has the ACID properties as isolation, preservation of consistency and durability are provided by the system and database design and atomicity is manually applied.
The purpose of this stored procedure is to update the lastname and email for an existing Graduate who has changed his or her lastName or email (upon marriage, graduation, workplace change or so).
*/


CREATE OR REPLACE PROCEDURE  multiStepTransact(graduateIdIn IN Graduate.id%type, 
lastNameIn IN Graduate.lastName%type, emailIn IN Graduate.email%type)
AS

Cursor c1 
IS
	SELECT lastName, email
	FROM Graduate
	WHERE id = GraduateIdIn
	FOR UPDATE; 

v1 Graduate.lastName%type;
v2 Graduate.email%type;

incorrectlastName_exception EXCEPTION;
incorrectemail_exception EXCEPTION;

BEGIN

	SAVEPOINT startpoint;
-- Throw an exception if the input does not contain the full new address for the Graduate
	IF lastNameIn IS NULL THEN
		RAISE incorrectlastName_exception;
	ELSIF emailIn IS NULL THEN 
		RAISE incorrectemail_exception;
	END IF;
	
-- Row Exclusive Table Lock is automatically issued against the Graduate Table when an update statement is issued against the table. To ensure isolation for 
-- the multiple update statements, the row share table lock is applied so that the updates are done one at a time and if something goes wrong, everything is rolled back to before any of the update statements.

	OPEN c1;
	
	LOOP
		FETCH c1 into v1, v2;
		EXIT WHEN c1%NOTFOUND;
		UPDATE Graduate SET lastName = lastNameIn WHERE CURRENT OF c1;
		UPDATE Graduate SET email = emailIn WHERE CURRENT OF c1;
	END LOOP;
	
	CLOSE c1;

	COMMIT;	
EXCEPTION
	WHEN incorrectlastName_exception THEN
		RAISE_APPLICATION_ERROR(-20001, 'Please provide an accurate non-NULL value for the lastName');
		ROLLBACK TO startpoint;
	
	WHEN incorrectemail_exception THEN
		RAISE_APPLICATION_ERROR(-20002, 'Please provide an accurate non-NULL value for the email');
		ROLLBACK TO startpoint;
	
END;
/



-- Tests
-- This should update the lastName and email information for the Graduate with id = 22
BEGIN 
	multistepTransact(22, 'Cudjoe', 'kec32@students.calvin.edu');
END;
/

SELECT * FROM Graduate WHERE id = 22;

-- This should throw incorrectlastName_exception
BEGIN 
	multistepTransact(23, NULL, 'efb4@students.calvin.edu');
END;
/

SELECT * FROM Graduate WHERE id = 23;

-- This should throw incorrectemail_exception
BEGIN 
	multistepTransact(24, 'Boye', NULL);
END;
/

SELECT * FROM Graduate WHERE id = 24;
