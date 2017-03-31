/*
Karen Cudjoe 
CS 342
Homework 07_1
*/

-- Exercise 1
drop VIEW EmpDeptView;

-- 1. Create a view of all employees and their department; include the employee ID, name, email, hire date and department name. Then write SQL commands to do the following:
CREATE VIEW EmpDeptView 
AS SELECT e.employee_id, e.first_name, e.last_name, e.email, e.hire_date, d.department_name
FROM Employees e, Departments d
WHERE e.department_id = d.department_id;

-- 1. a. Get the name and ID of the newest employee in the “Executive” department.
SELECT * FROM (
				SELECT employee_id, first_name, last_name
				FROM EmpDeptView
				WHERE department_name = 'Executive'
				ORDER BY hire_date DESC)
WHERE ROWNUM <= 1;
				
-- 1. b. Change the name of the “Administration” department to “Bean Counting”.
UPDATE EmpDeptView
SET department_name = 'Bean Counting'
WHERE department_name = 'Administration';
-- This query generates the following error: 'Cannot modify a column which maps to a non key-preserved table'.  We cannot modify a columns which maps to a non key-preserved table. 

-- 1. c. Change the name of “Jose Manuel” to just “Manuel”
UPDATE EmpDeptView
SET first_name = 'Manuel'
WHERE first_name = 'Jose Manuel';

-- 1. d. Insert a new employee in the “Payroll” department (make up appropriate data for this record).
INSERT INTO EmpDeptView VALUES (400, 'Karen', 'Cudjoe', 'kec32', '23-JULY-1994', 'Payroll');
-- This insert query gives the error 'cannot modify more than one base table through a join view'. 
-- The view combines both empolyees and departments therefore we are unable to insert anything into it.




--Exercise 2
DROP MATERIALIZED VIEW Mat_EmpDeptView;


-- 2. Create a view of all employees and their department; include the employee ID, name, email, hire date and department name. Then write SQL commands to do the following:
CREATE MATERIALIZED VIEW Mat_EmpDeptView 
AS SELECT e.employee_id, e.first_name, e.last_name, e.email, e.hire_date, d.department_name
FROM Employees e, Departments d
WHERE e.department_id = d.department_id;

-- 2. a. Get the name and ID of the newest employee in the “Executive” department.
SELECT * FROM (
				SELECT employee_id, first_name, last_name
				FROM Mat_EmpDeptView
				WHERE department_name = 'Executive'
				ORDER BY hire_date DESC)
WHERE ROWNUM = 1;
				
-- 2. b. Change the name of the “Administration” department to “Bean Counting”.
UPDATE Mat_EmpDeptView
SET department_name = 'Bean Counting'
WHERE department_name = 'Administration';
-- This query doesnt work because the materialized view is read only and as such, cannot be updated directly. 

-- 2. c. Change the name of “Jose Manuel” to just “Manuel”
UPDATE Mat_EmpDeptView
SET first_name = 'Manuel'
WHERE first_name = 'Jose Manuel';
-- This query doesnt work because the materialized view is read only and as such, cannot be updated directly.

-- 2. d. Insert a new employee in the “Payroll” department (make up appropriate data for this record).
INSERT INTO Mat_EmpDeptView VALUES (400, 'Karen', 'Cudjoe', 'kec32', '23-JULY-1994', 'Payroll');
-- This query doesnt work because the materialized view is read only and as such, cannot be updated directly.




/*
Exercise 3

a. The query on which your view from exercise 1 is based - Write this query using both the relational algebra and tuple relational calculus, with respect to the original HR relations.
Relational Algebra:
π employee_id, first_name, last_name, email, hire_date, department_name (Employees ∞ department_id = department_id Departments)

Relational Calculus:
{e.employee_id, e.first_name, e.last_name, e.email, d.hire_date | Employees(e) ^ Departments(d) ^ e.department_id = d.department_id}


b. 
{e.employee_ID, e.first_name, e.last_name, | empView(e) ^ e.hire_Date = {min(e.hire_date} | empview(e)}}
*/