/*
Karen Cudjoe
CS 342
Homework 05
*/

--1. a. 
SELECT e.employee_ID, e.first_name, e.last_name
FROM Employees e JOIN Job_History jh on jh.employee_ID = e.employee_ID
WHERE end_date IS NOT NULL;


-- 1. b. 
SELECT e.first_name ||''|| e.last_name AS Employee, e.hire_date AS Employee_Hire_Date, m.first_name ||''|| m.last_name AS Manager, m.hire_date AS Manager_Hire_Date
FROM Employees e
JOIN Employees m ON e.manager_ID = m.employee_ID
AND e.hire_date < m.hire_date
WHERE EXISTS (SELECT * FROM Job_History jh WHERE e.employee_ID = jh.employee_ID 
AND jh.department_ID = m.department_ID);


-- 1. c. 
-- Join Query
SELECT DISTINCT c.country_name
FROM Countries c
JOIN locations l on c.country_ID = l.country_ID
JOIN Departments d ON d.location_ID = l.location_ID;

-- Nested Query 
SELECT DISTINCT c.country_name
FROM Countries c, Locations l 
WHERE c.country_ID = l.country_ID
AND EXISTS (SELECT d.department_ID FROM Departments d 
where d.location_ID = l.location_ID);

/* The join query is better as it is much faster and more readable than the nested query. Also, Oracle is able to optimize join queries well.