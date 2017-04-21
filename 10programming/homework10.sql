/*
Karen Cudjoe
CS 342
Homework 10
4/20/2017
*/

CREATE OR REPLACE PROCEDURE transferRank (sourceId IN Movie.id%type, destinationId IN Movie.id%type, transAmount IN FLOAT) 
AS
	x Movie.rank%type;
	low_exception EXCEPTION;
	negtransAmount EXCEPTION;
BEGIN
	SELECT rank INTO x FROM Movie WHERE id=sourceId 
	FOR UPDATE OF rank;
	
	IF x < transAmount THEN
		RAISE low_exception;
    END IF;
		IF transAmount < 0 THEN
			RAISE negtransAmount;
    END IF;
	
	UPDATE Movie 
	SET rank =(rank-transAmount) 
	WHERE id = sourceId;
	COMMIT;
	
	UPDATE Movie 
	SET rank =(rank+transAmount) 
	WHERE id = destinationId;
	COMMIT;
	
EXCEPTION
	WHEN low_exception THEN
		RAISE_APPLICATION_ERROR(-20001, 'Too low movie rank to take from');
	WHEN negtransAmount THEN
		RAISE_APPLICATION_ERROR(-20002, 'Transfer amount should not be negative');
END;
/

COMMIT;

BEGIN
	FOR i IN 1..10000 LOOP
		transferRank(176712, 176711, 0.1);
		COMMIT;
		transferRank(176711, 176712, 0.1);
		COMMIT;
	END LOOP;
END;
/

SELECT rank FROM Movie WHERE id = 176712;
SELECT rank FROM Movie WHERE id = 176711;
