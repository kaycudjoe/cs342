/*
Karen Cudjoe
CS 342
*/

@drop.sql
@schema.sql
@data.sql

CREATE OR REPLACE procedure castingActor(actorID IN Actor.id%type, movieID IN Movie.id%type, role IN Role.role%type) 
AS
BEGIN
INSERT INTO Role VALUES (actorID, movieID, role) ;
END;
/
SHOW ERRORS;


DROP trigger roleTrigger;
CREATE trigger roleTrigger BEFORE INSERT ON Role FOR each row
DECLARE
	counter1 INTEGER;
	counter2 INTEGER;
	actor_duplicate EXCEPTION;
	movie_full EXCEPTION;
BEGIN
	SELECT COUNT(*) INTO Counter1 FROM ROLE
	WHERE actorID = :new.actorID
	and movieID = :new.movieID;
	IF counter1 >=1 THEN 
		RAISE actor_duplicate;
	END IF;
	SELECT COUNT(*) INTO Counter2 FROM ROLE
	WHERE movieID = :new.movieID;
	IF Counter2 >= 230 THEN 
		RAISE movie_full;
	END IF;
EXCEPTION	
	WHEN actor_duplicate THEN
	RAISE_APPLICATION_ERROR(-20001, 'This actor has already been cast for this movie');
	WHEN movie_full THEN
	RAISE_APPLICATION_ERROR(-20002, 'This movie already has 230 castings');
END;
/
SHOW ERRORS;


-- a. Cast George Clooney (# 89558) as “Danny Ocean” in Oceans Eleven (#238072). N.b., he’s already cast in this movie.
BEGIN
castingActor(89558, 238072, 'Danny Ocean');
END;
/

-- b. Cast George Clooney as “Danny Ocean” in Oceans Twelve (#238073). N.b., he’s not currently cast in this movie.
BEGIN
castingActor(89558, 238073, 'Danny Ocean');
END;
/

-- c. Cast George Clooney as “Danny Ocean” in JFK (#167324). N.b., this movie already has 230 castings.
BEGIN
castingActor(89558, 167324, 'Danny Ocean');
END;
/