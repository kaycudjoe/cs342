CREATE OR REPLACE TRIGGER gradtaken BEFORE INSERT ON Graduate FOR EACH ROW
DECLARE
	COUNTER INTEGER;
	maxnumberofStudents EXCEPTION;
BEGIN
	SELECT COUNT(*) INTO COUNTER FROM Graduate g, Student s
	WHERE s.graduateID = g.ID;
	IF COUNTER > 3 THEN 
		RAISE maxnumberofStudents;
	END IF;
EXCEPTION
	WHEN maxnumberofStudents THEN
		RAISE_APPLICATION_ERROR(-20001, 'Graduate has too many students assigned.');
END;
/
Show errors;