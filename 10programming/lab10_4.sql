/*
Karen Cudjoe
CS 342
Lab 10_4
4/21/2017
*/

CREATE OR REPLACE PROCEDURE incrementRank
	(movieIdIn IN Movie.id%type, 
	 deltaIn IN integer
    ) AS
	x Movie.rank%type;
BEGIN
	FOR i IN 1..50000 LOOP
		SELECT rank INTO x FROM Movie WHERE id=movieIdIn FOR UPDATE OF Rank;
		UPDATE Movie SET rank=x+deltaIn WHERE id=movieIdIn;
		COMMIT;
	END LOOP;
END;
/


-- Restart your two SQL*Plus sessions, run the given stored procedure simultaneously in each of them using:

EXECUTE incrementRank(238071, 0.1);
-- Now, determine if it ran correctly. If it does, explain how. If it doesn’t, identify the problem and modify the code so that it does.


/*
This is a lost update problem. Both of the sessions are not isolated, so some of the updates made to the rank are lost. 
It should have resulted in a rank which is increased by 1000, however, it ended with a rank increased by a number less than 1000. 
*/

-- Modification
-- This can be modified by adding a lock to the rows which are affected. Over here, a FOR UPDATE clause will be used. This solves the issue as it isolates the session and makes all changes made easily recognizable. 
