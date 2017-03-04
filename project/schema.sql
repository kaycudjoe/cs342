create table Graduate (
	ID integer PRIMARY KEY, 
	firstName varchar(15),
	lastName varchar(15),
	email varchar(70),
	phoneNumber varchar(10)
	);

create table Staff (
	ID integer PRIMARY KEY, 
	firstName varchar(15),
	lastName varchar(15),
	email varchar(70),
	phoneNumber varchar(10)
	);	
		
create table Student (
	ID integer PRIMARY KEY, 
	firstName varchar(15),
	lastName varchar(15),
	email varchar(70),
	phoneNumber varchar(10),
	schoolyear varchar(10),
	scholarshipreceivedate date,
	graduateID integer,
	staffID integer,
	FOREIGN KEY (staffID) REFERENCES Staff(ID) ON DELETE SET NULL,
	FOREIGN KEY (graduateID) REFERENCES Graduate(ID) ON DELETE SET NULL
	);

create table Employer (
	ID integer PRIMARY KEY, 
	firstName varchar(15),
	lastName varchar(15),
	email varchar(70),
	phoneNumber varchar(10),
	CompanyName varchar(40)
	);
	
create table YearRequired (
	ID integer PRIMARY KEY, 
	name varchar(15),
	description varchar(150),
	requiredYear varchar(10)
	);

create table Requirement (
	ID integer PRIMARY KEY, 
	name varchar(60),
	yearRequiredID integer,
	FOREIGN KEY (yearRequiredID) REFERENCES YearRequired(ID) ON DELETE CASCADE
	);

create table StudentRequirement (
	studentID integer, 
	requirementID integer, 
	yearlevelTaken varchar(20),
	FOREIGN KEY (studentID) REFERENCES Student(ID) ON DELETE SET NULL,
	FOREIGN KEY (requirementID) REFERENCES Requirement(ID) ON DELETE SET NULL
	);

create table StudentEmployer (
	studentID integer,
	employerID integer, 
	position varchar(40),
	startDate date, 
	endDate date,
	FOREIGN KEY (studentID) REFERENCES Student(ID) ON DELETE SET NULL,
	FOREIGN KEY (employerID) REFERENCES Employer(ID) ON DELETE SET NULL
	);
	
create table GraduateEmployer (
	graduateID integer, 
	employerID integer, 
	position varchar(40),
	FOREIGN KEY (graduateID) REFERENCES Graduate(ID) ON DELETE SET NULL,
	FOREIGN KEY (employerID) REFERENCES Employer(ID) ON DELETE SET NULL
	);