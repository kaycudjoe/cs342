CREATE OR REPLACE PROCEDURE INSERTStudent(studentIdIn IN integer, firstNameIn IN student.firstName%type, lastNameIn IN student.lastName%type, emailIn IN student.email%type, 
										phoneNumberIn IN student.phoneNumber%type, graduationDateIn IN student.graduationDate%type, scholarshipreceivedateIn IN student.scholarshipreceivedate%type, 
										graduateIdIn IN INTEGER, staffIdIn IN INTEGER) as 
	counter integer;
begin
	SELECT count(*) into counter FROM student s, Graduate g
		where s.graduateID = g.ID;
	IF counter > 3 then
		RAISE_APPLICATION_ERROR(-20001, 'Too many students assigned. ' || studentIdIn || ' cannot be assigned to graduate');
	end IF;
	INSERT into student(id, firstName, lastName, email, phoneNumber, graduationDate , scholarshipreceivedate, graduateID, staffID ) values
		(studentIdIn, firstNameIn, lastNameIn, emailIn, phoneNumberIn, graduationDateIn, scholarshipreceivedateIn, graduateIdIn, staffIdIn);
	dbms_output.put_line('Student ' || studentIdIn || ' was added to the team: ' || graduateIdIn);
end;
/
Show errors;
