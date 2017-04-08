/*
Karen Cudjoe
CS 342
Homework 08_1
*/

/*
Auditing — Implement a “shadow” log that records every update to the rank of any Movie record. 
Store your log in a separate table ( RankLog ) and include the ID of the user who made the change (accessed using the system constant user), 
the date of the change (accessed using sysdate) and both the original and the modified ranking values.
*/
DROP TRIGGER shadow;
DROP SEQUENCE shadowSeq;
DROP TABLE Ranklog;

CREATE TABLE RankLog (
	ID integer PRIMARY KEY,
	user_ID varchar (30), 
	changeDate date,
	original_Rank number(10,2), 
	modified_Rank number(10,2)
	);
	
CREATE SEQUENCE shadowSeq
	start with 1
	increment by 1;
	
CREATE OR REPLACE TRIGGER shadow AFTER UPDATE OF rank ON Movie FOR EACH ROW
BEGIN
	INSERT INTO Ranklog VALUES (shadowSeq.nextval, user, SYSDATE, :old.rank, :new.rank);
END;
/

UPDATE Movie
SET RANK = 9.4
where ID = 17173;

UPDATE Movie
SET RANK = 2.9
where name = 'Footloose';

UPDATE Movie
SET RANK = 6
where id in (350424, 267038);

SELECT * FROM RankLog;