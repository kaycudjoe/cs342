-- gradtaken trigger checks to make sure that a graduate is not assigned too many students
-- Each graduate can have a maximum of 3 students assigned
-- If the insert command tries to assign more students to graduates such that a graduate will have more than 3 assigned students, an application error is raised notifying the user of the error. 



CREATE OR REPLACE TRIGGER gradtaken BEFORE INSERT ON Graduate FOR EACH ROW
DECLARE
	COUNTER INTEGER;
	maxnumberofStudents EXCEPTION;
BEGIN
	SELECT COUNT(*) INTO COUNTER FROM Graduate g, Student s
	WHERE s.graduateID = g.ID;
	-- If the graduate is already fully taken (has the maximum number of students assigned) raise an exception. 
	IF COUNTER > 3 THEN 
		RAISE maxnumberofStudents;
	END IF;
EXCEPTION
-- if the graduate is already full
	WHEN maxnumberofStudents THEN
		RAISE_APPLICATION_ERROR(-20001, 'Graduate has too many students assigned.');
END;
/
Show errors;