/* 
Karen Cudjoe
CS 342
Homework 06
*/

-- 1. Please write SQL queries that retrieve the following information from the HR database (see HR and OE Schemas).
-- a. The IDs and full names of managers and the number of employees each of them manages. Order the results by decreasing number of employees and return only the top ten results.
SELECT * FROM
(SELECT m.employee_ID AS Manager_ID, m.first_name ||' '|| m.last_name as Manager_name, 
COUNT (e.Employee_ID) AS employee_count
FROM Employees m, Employees e
WHERE e.manager_ID = m.employee_ID
GROUP BY m.employee_ID, m.first_name ||' '|| m.last_name
ORDER BY employee_count DESC)
WHERE rownum <= 10;

-- b. The name, number of employees and total salary for each department outside of the US with less than 100 employees. The total salary is the sum of the salaries of each of the department's employees.
SELECT d.department_name, count(e.employee_ID) AS num_employees, sum(e.salary) AS Total_Salary
FROM Departments d, Employees e, Locations l, Countries c
WHERE d.location_ID = l.location_ID
AND e.department_ID = d.department_ID
AND l.country_ID = c.country_ID
AND c.country_ID <> 'US'
GROUP BY d.department_name
HAVING COUNT (e.employee_ID) < 100;

-- c. The department name, department manager name and manager job title for all departments. If the department has no manager, include it in the output with NULL values for the manager and title.
SELECT d.department_name, m.first_name ||' '|| m.last_name as Manager_name, j.job_title
FROM departments d LEFT OUTER JOIN Employees m ON d.manager_ID = m.employee_ID
LEFT OUTER JOIN Jobs j ON m.job_ID = j.job_ID;

-- d. The name of each department along with the average salary of the employees of that department. If a department has no employees, include it in the list with no salary value. Order your results by decreasing salary. You may order the NULL-valued salaries however you’d like.
SELECT d.department_name, avg(e.salary) as average_salary
FROM Departments d LEFT OUTER JOIN Employees e 
ON d.department_ID = e.department_ID
group by d.department_name
ORDER BY avg(e.salary) DESC;


