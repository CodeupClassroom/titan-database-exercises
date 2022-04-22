USE employees;

SELECT emp_no FROM dept_manager;

SELECT birth_date
FROM employees
WHERE emp_no IN (
    SELECT emp_no FROM dept_manager
    );

SELECT CONCAT(first_name, ' ', last_name), birth_date
FROM employees
WHERE emp_no IN (
    SELECT emp_no FROM dept_manager
);

USE codeup_test_db;

SELECT * FROM preferences;

INSERT INTO preferences (person_id, album_id) VALUES ((SELECT id FROM persons WHERE first_name = 'Tareq'), (SELECT id FROM albums WHERE name = 'Rumours'));

SELECT first_name, name FROM persons JOIN preferences p on persons.id = p.person_id JOIN albums a on a.id = p.album_id WHERE first_name = 'Tareq';

UPDATE preferences
    SET album_id = (SELECT id FROM albums WHERE name = 'Led Zeppelin IV')
    WHERE album_id = (SELECT id FROM albums WHERE name = 'Rumours')
    AND person_id = (SELECT id FROM persons WHERE first_name = 'Tareq')
    ;

SELECT first_name, name FROM persons JOIN preferences p on persons.id = p.person_id JOIN albums a on a.id = p.album_id WHERE first_name = 'Tareq';

# Exercise Walkthrough
# Find all the employees with the same hire date as employee 101010 using a subquery.
# 69 Rows

USE employees;

SELECT hire_date
FROM employees
WHERE emp_no = 101010;

SELECT *
FROM employees
WHERE hire_date IN (
    SELECT hire_date
    FROM employees
    WHERE emp_no = 101010
    );

# Find all the titles held by all employees with the first name Aamod.
# 314 total titles, 6 unique titles


SELECT first_name, emp_no FROM employees WHERE first_name = 'Aamod';

SELECT title
FROM titles
WHERE emp_no IN (
    SELECT emp_no FROM employees WHERE first_name = 'Aamod'
    );

SELECT title, COUNT(title)
FROM titles
WHERE emp_no IN (
    SELECT emp_no FROM employees WHERE first_name = 'Aamod'
)
GROUP BY title;

# Find all the current department managers that are female.

# +------------+------------+
# | first_name | last_name  |
# +------------+------------+
# | Isamu      | Legleitner |
# | Karsten    | Sigstam    |
# | Leon       | DasSarma   |
# | Hilary     | Kambil     |
# +------------+------------+

# Oscar Castro's solution
SELECT first_name, last_name AS employee_name
FROM employees WHERE emp_no IN (
    SELECT emp_no FROM dept_manager
    WHERE YEAR(to_date) = 9999 AND gender = 'F'
    );

# Find all the department names that currently have female managers.
#
# +-----------------+
# | dept_name       |
# +-----------------+
# | Development     |
# | Finance         |
# | Human Resources |
# | Research        |
# +-----------------+

SELECT dept_name
FROM departments
WHERE dept_no IN (
    SELECT dept_no
    FROM dept_manager
    WHERE to_date LIKE '9%' AND emp_no IN (
        SELECT emp_no
        FROM employees
        WHERE gender = 'F'
    )
          );

#Find the first and last name of the employee with the highest salary.

# +------------+-----------+
# | first_name | last_name |
# +------------+-----------+
# | Tokuyasu   | Pesch     |
# +------------+-----------+

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
WHERE emp_no IN (
    SELECT emp_no
    FROM salaries
    WHERE to_date LIKE '9%' AND salary IN (
        SELECT MAX(salary) FROM salaries
    )
    );





