/* Karen Cudjoe
CS 342
Project - Queries
*/

@drop.sql
@schema.sql
@data.sql

/* 
Query 1: 
What the query returns: This query returns the IDs, firstName, lastName and scholarship receive date, assigned staff member, assgigned graduate and all employees (past/present) of all scholarship recipients who have graduation dates in 2017. 
Who would care about the results: The career center staff and organizers of the Calvin LifeWork program will care about the results. 
The purpose of this query is to recognize the recipients of the scholarship as well as to recognize and applaud their assigned graduates, employers and career center staff members whose staudents receive scholarships, and to assign these graduates to students since their work with the current student is done. 
*/
-- Fulfils a join of at least four tables
-- Fulfils proper comparisons of NULL values
SELECT s.ID, s.firstName ||' , '|| s.lastName, s.scholarshipreceivedate, sc.firstName ||' , '|| sc.lastName, g.firstName ||' , '|| g.lastName, e.firstName ||' , '|| e.lastName
FROM Student s, Staff sc, Graduate g, Employer e, StudentEmployer se
WHERE s.graduationDate >= '01-JAN-2017' AND s.graduationDate <= '31-DEC-2017'
AND s.scholarshipreceivedate IS NOT NULL
AND s.graduateID = g.ID
AND s.staffID = sc.ID
AND se.studentID = s.ID
AND se.employerID = e.ID; 

/*
Query 2:
What the query returns: This query displays the IDs and names of students who have worked as well as the number of internships they have had
Who would care about the results: The career center staff will care about these results 
The purpose of this query is to let the career center staff know which students have ever interned during their stay in college
*/
-- Fulfils aggregate statistics on grouped data
SELECT s.ID, s.firstName ||' , ' || s.lastName, Count(*)
FROM StudentEmployer se JOIN Student s
ON se.studentID = s.ID
GROUP BY s.ID, s.firstName, s.lastName
ORDER BY s.ID;


/*
Query 3:
What the query returns: This query returns the IDs, firstName, lastName and all employees (past/present) of each scholarship recipient 
Who would care about the results: The career center staff will care about the results. 
The purpose of this query will be to know the employers of all scholarship recipients
*/
-- Fulfils a combination of inner and outer joins
SELECT DISTINCT s.ID, s.firstName ||' , '|| s.lastName, e.firstName ||' , '|| e.lastName 
FROM Student s 
LEFT OUTER JOIN StudentEmployer se ON se.studentID = s.ID
INNER JOIN Employer e ON se.employerID = e.ID
WHERE s.scholarshipreceivedate IS NOT NULL
ORDER BY s.ID ASC;


/*
Query 4:
What the query returns: This query returns the IDs, firstName, lastName of each scholarship recipient and the number of jobs they have had
Who would care about the results: The career center staff will care about the results. 
The purpose of this query will be to know the number of jobs each scholarship recicipient has had
*/
-- Fulfils a combination of inner and outer joins
SELECT s.ID, s.firstName ||' , '|| s.lastName AS Scholarship_Recipient, Count(*) AS Num_Jobs
FROM StudentEmployer se
LEFT OUTER JOIN Student s ON se.studentID = s.ID
INNER JOIN Employer e ON se.employerID = e.ID
WHERE s.scholarshipreceivedate IS NOT NULL
GROUP BY s.ID, s.firstName, s.lastName
ORDER BY s.ID ASC;


/*
Query 5: 
What the query returns: This query gets a count of how many students are enrolled in the program who have had internships or jobs 
Who would care about the results: The career center staff will care about these results 
The purpose of this query is to let the career center staff how many students have interned during their stay in college in order to determine if they should be habing more job search workshops
*/
-- a nested select statement
SELECT COUNT(*) AS EmpNumberEnrolled FROM (
SELECT DISTINCT s.ID FROM Student s WHERE s.ID IN
	(SELECT se.studentID FROM StudentEmployer se)
	);


/*
Query 6: 
What the query returns: This query returns the ID, firstname and last name of the students assigned to each staff member
Who would care about the results: The career center staff will care about the results. 
The purpose of this query will be to know which staff member each student is  assigned to
*/
-- Fulfils Left outer join
SELECT sc.ID AS Staff_ID, s.ID AS Student_ID, s.firstName, s.lastName
FROM Staff sc LEFT OUTER JOIN Student s ON s.staffID = sc.ID
ORDER BY sc.ID ASC;


/* 
Query 7
What the query returns: Get the IDs of all the students a particular graduate is mentoring 
Who would care about the results: The graduate and the career center staff
*/
-- Fulfils a self join using tuple variables
SELECT s1.ID AS Student_ID, s1.firstName ||' , '|| s1.lastName AS Student_name, s2.ID AS Graduate_ID, s2.graduationDate, s2.graduationDate
FROM Student s1, Graduate s2
WHERE s2.graduationDate >= '01-JUNE-2015'
AND s1.graduateID = s2.ID
ORDER BY s2.ID ASC;


/* 
View 1
I chose materialized view because it will allow students to see the requirements they have fulfilled faster
What the view provides: This view shows the ID and name student and the requirements he or she has fulfilled
Who would use it: The students - to monitor their progress and the career center staff - to see which students are making headway in the program
*/
Drop MATERIALIZED VIEW StudentRequirementView;
CREATE MATERIALIZED VIEW StudentRequirementView
AS SELECT s.ID, s.firstName, s.lastName, sr.requirementID
FROM Student s, StudentRequirement sr, Requirement r
WHERE sr.studentID = s.ID
AND sr.requirementID = r.ID;

SELECT * FROM StudentRequirementView;


/* 
View 2
I chose materialized view because it will allow freshmen to see the requirements they have fulfilled faster
What the view provides: This view shows the requirements that have been fulfilled by each freshman
Who would use it: The freshmen - to monitor their progress and the career center staff - to see which freshmen are making headway in the program
*/
Drop MATERIALIZED VIEW StudentRequirement1View;
CREATE MATERIALIZED VIEW StudentRequirement1View
AS SELECT s.ID, s.firstName, s.lastName, sr.requirementID
FROM Student s JOIN StudentRequirement sr ON sr.studentID = s.ID
WHERE s.graduationDate >= '01-JAN-2020'
AND s.ID NOT IN (SELECT s.ID FROM StudentRequirement
				WHERE ROWNUM >= 7);

SELECT * FROM StudentRequirement1View;
