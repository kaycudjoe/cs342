-- Karen Cudjoe
-- CS 342, lab01_1

--a. list alll the rows of the departments table--
SELECT * from DEPARTMENTS;

--b. find the number of employees in the database (nb., use the COUNT() aggregate function for this).--
SELECT COUNT(*) FROM employees;
 
--c. List the employees who ,  
--i. make more than $15,000 per year --
SELECT * FROM employees
WHERE salary > 15000; 

--ii. were hired from 2002–2004 (inclusive) --
SELECT * FROM employees
WHERE hire_date >= '01-Jan-2002' AND hire_date <= '31-2004';

--iii. have a phone number that doesn’t have the area code 515 (nb., use NOT LIKE with the wildcard %). --
SELECT * FROM employees
WHERE phone_number NOT LIKE '515%';

--d. list the names of the employees who are in the finance department. Try to format the names as “firstname lastname” using concatenation (i.e., || ) and order them alphabetically.-
SELECT first_name || '' || last_name FROM employees, departments
WHERE employees.department_id = departments.department_id
AND department_name = 'Finance'
ORDER BY last_name;

--e. list the city, state and country name for all locations in the Asian region.--
SELECT city, state_province, country_name FROM locations, countries, regions
WHERE region_name = 'Asia'
AND countries.region_id = regions.region_id
AND locations.country_id = countries.country_id;

--f. list the locations that have no state or province specified in the database (nb. use the NULL value for this query).--
SELECT * FROM locations
WHERE state_province IS NULL; 

