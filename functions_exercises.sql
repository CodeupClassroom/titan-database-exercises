USE employees;

# Problem 2
# Update your queries for employees whose names start and end with 'E'.
# Use concat() to combine their first and last name together as a single column in your results.
SELECT CONCAT(first_name, ' ', last_name)
FROM employees
WHERE last_name LIKE 'e%e'

# Problem 3
SELECT COUNT(*)
FROM employees
WHERE MONTH(birth_date) = 12
  AND DAY(birth_date) = 25;
SELECT COUNT(*)
FROM employees
WHERE birth_date LIKE '%-12-25';

DESCRIBE employees;


# Problem 4
SELECT COUNT(*)
FROM employees
WHERE birth_date LIKE '%-12-25'
  AND hire_date LIKE '199%';


SELECT COUNT(*)
FROM employees
WHERE MONTH(birth_date) = 12
  AND DAY(birth_date) = 25
  AND hire_date LIKE '199%';


# Problem 5
SELECT first_name, last_name
FROM employees
WHERE MONTH(birth_date) = 12
  AND DAY(birth_date) = 25
  AND hire_date LIKE '199%'
ORDER BY birth_date, hire_date DESC
LIMIT 1;

# Problem 6
SELECT CONCAT('Days at company: ', DATEDIFF(NOW(), hire_date)) AS `Days at Company`,
       CONCAT(first_name, ' ', last_name)                      AS `Name`
FROM employees
WHERE hire_date LIKE '199%'
  AND birth_date LIKE '%12-25'
SELECT COUNT(*) FROM employees WHERE MONTH(birth_date) = 12 AND DAY(birth_date) = 25;
