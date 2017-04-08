/*
Karen Cudjoe
CS 342
Homework 08_2
*/

/*
Bacon Number — Implement a tool that loads a table (named BaconTable) with records that specify an actor ID and that actor’s Bacon number. 
An actor’s bacon number is the length of the shortest path between the actor and Kevin Bacon (KB) in the “co-acting” graph. 
That is, KB has bacon number 0; all actors who acted in the same movie as KB have bacon number 1; all actors who acted in the same movie as some actor with Bacon number 1 but have not acted with Bacon himself have Bacon number 2, etc. 
Actors who have never acted with anyone with a bacon number should not have a record in the table. Stronger solutions will be configured so that the number can be based on any actor, not just Kevin Bacon.
*/

DROP TABLE baconTable;

CREATE TABLE baconTable (
	actorID integer PRIMARY KEY,
	baconNumber integer
);

CREATE OR REPLACE PROCEDURE baconNumber (p_actorID IN INTEGER, p_baconNum IN INTEGER) IS COUNTER INTEGER;
BEGIN
	-- get all the actors in all movies p_actor is in 
	FOR actor in (SELECT DISTINCT actorID FROM role WHERE movieID IN
		(SELECT movieID FROM Role WHERE p_actorID = actorID)) LOOP
		
	-- ensure current actor is not already in table 
		SELECT COUNT(*) INTO Counter FROM baconTable
		WHERE actorID = actor.actorID;
		
		IF counter > 0 THEN 
			-- check to see if baconNumber is bigger than current baconNumber. If it is, still insert
			UPDATE baconTable SET baconNumber = p_baconNum 
			WHERE actorID = actor.actorID 
			AND baconNumber > p_baconNum;
			-- else, insert into the bacon table
			
		ELSE
			if p_baconNum < 41 THEN 
				INSERT INTO baconTable VALUES (actor.actorID, p_baconNum+1);
				baconNumber(actor.actorID, p_baconNum+1);
			END IF;
		END IF;
	END LOOP;
END;
/

BEGIN
	baconNumber(22591, 1);
END;
/