/*
Karen Cudjoe 
CS 342
Homework 07_1
*/

-- Exercise 1
drop VIEW EmployeeDepartmentView;

-- 1. Create a view of all employees and their department; include the employee ID, name, email, hire date and department name. Then write SQL commands to do the following:
CREATE VIEW EmployeeDepartmentView 
AS SELECT e.employee_id, e.first_name, e.last_name, e.email, e.hire_date, d.department_name
FROM Employees e, Departments d
WHERE e.department_id = d.department_id;

-- 1. a. Get the name and ID of the newest employee in the “Executive” department.
SELECT * FROM (
				SELECT employee_id, first_name, last_name
				FROM EmployeeDepartmentView
				WHERE department_name = 'Executive'
				ORDER BY hire_date DESC)
WHERE ROWNUM <= 1;
				
-- 1. b. Change the name of the “Administration” department to “Bean Counting”.
UPDATE EmployeeDepartmentView
SET department_name = 'Bean Counting'
WHERE department_name = 'Administration';
-- This query generates the following error: 'Cannot modify a column which maps to a non key-preserved table'.  We cannot modify a columns which maps to a non key-preserved table. 

-- 1. c. Change the name of “Jose Manuel” to just “Manuel”
UPDATE EmployeeDepartmentView
SET first_name = 'Manuel'
WHERE first_name = 'Jose Manuel';

-- 1. d. Insert a new employee in the “Payroll” department (make up appropriate data for this record).
INSERT INTO EmployeeDepartmentView VALUES (400, 'Karen', 'Cudjoe', 'kec32', '23-JULY-1994', 'Payroll');
-- This insert query gives the error 'cannot modify more than one base table through a join view'. 
-- The view combines both empolyees and departments therefore we are unable to insert anything into it.



