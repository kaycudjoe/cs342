create table Graduate (
	ID integer PRIMARY KEY, 
	firstName varchar(15),
	lastName varchar(15),
	email varchar(50),
	phoneNumber char(12)
	);

create table Staff (
	ID integer PRIMARY KEY, 
	firstName varchar(15),
	lastName varchar(15),
	email varchar(50),
	phoneNumber number
	);	
		
create table Student (
	ID integer PRIMARY KEY, 
	firstName varchar(15),
	lastName varchar(15),
	email varchar(50),
	phoneNumber integer,
	schoolyear varchar(10),
	graduateID integer,
	staffID integer,
	FOREIGN KEY (staffID) REFERENCES Staff(ID) ON DELETE CASCADE,
	FOREIGN KEY (graduateID) REFERENCES Graduate(ID) ON DELETE CASCADE
	);

create table Employer (
	ID integer PRIMARY KEY, 
	firstName varchar(15),
	lastName varchar(15),
	email varchar(50),
	phoneNumber number,
	companyName varchar(30)
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
	FOREIGN KEY (yearRequiredID) REFERENCES YearRequired(ID) ON DELETE SET NULL
	);

create table StudentRequirement (
	studentID integer, 
	requirementID integer, 
	yearlevelTaken varchar(10),
	scholarship varchar(30),
	FOREIGN KEY (studentID) REFERENCES Student(ID) ON DELETE CASCADE,
	FOREIGN KEY (requirementID) REFERENCES Requirement(ID) ON DELETE CASCADE
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