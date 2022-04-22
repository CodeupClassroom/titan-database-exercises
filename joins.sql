USE employees;

SELECT employees.last_name AS name, salaries.salary AS salary FROM employees JOIN salaries ON employees.emp_no = salaries.emp_no;

SELECT CONCAT(employees.last_name, ' ', employees.first_name) AS name, salaries.salary AS salary, salaries.from_date AS startDate, salaries.to_date AS endDate FROM employees JOIN salaries ON employees.emp_no = salaries.emp_no WHERE salaries.emp_no = 14781;

SELECT CONCAT(e.last_name, ' ', e.first_name) AS name, s.salary AS salary, s.from_date AS startDate, s.to_date AS endDate FROM employees e JOIN salaries s ON e.emp_no = s.emp_no;

USE join_test_db;

SELECT users.name AS user_name, roles.name AS role_name FROM users LEFT JOIN roles ON users.role_id = roles.id;

USE codeup_test_db;

DROP TABLE IF EXISTS `persons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `persons` (
                           `id` int unsigned NOT NULL AUTO_INCREMENT,
                           `first_name` varchar(25) NOT NULL,
                           `album_id` int unsigned NOT NULL,
                           PRIMARY KEY (`id`),
                           KEY `album_id` (`album_id`),
                           CONSTRAINT `persons_album_id_fk` FOREIGN KEY (`album_id`) REFERENCES `albums` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `persons` VALUES (1,'Olivia',29),(2,'Santiago',27),(3,'Tareq',15),(4,'Anaya',28);

SHOW INDEXES FROM persons;
SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = 'codeup_test_db';

SELECT p.first_name, a.name FROM persons p JOIN albums a ON p.album_id = a.id;

SELECT p.first_name, a.name FROM albums a LEFT JOIN persons p on a.id = p.album_id;

SELECT p.first_name, a.name FROM persons p LEFT JOIN albums a on a.id = p.album_id;

SELECT p.first_name, a.name FROM persons p RIGHT JOIN albums a on a.id = p.album_id;

DROP TABLE preferences;

CREATE TABLE preferences (
    person_id INT UNSIGNED NOT NULL,
    album_id INT UNSIGNED NOT NULL,
    CONSTRAINT preferences_person_id_fk FOREIGN KEY (person_id) REFERENCES persons (id),
    CONSTRAINT preferences_album_id_fk FOREIGN KEY (album_id) REFERENCES albums (id)
);

INSERT INTO preferences (person_id, album_id) VALUES (1, 12), (1, 5), (1, 22), (1, 29), (2, 1), (2, 31), (2, 30), (3, 11), (3, 26), (3, 25);

SELECT p.first_name, a.name AS `favorite album` FROM persons p JOIN preferences pf ON p.id = pf.person_id JOIN albums a on pf.album_id = a.id;

USE employees;

# Join using the ON keyword
SELECT employees.last_name AS name, salaries.salary AS salary FROM employees JOIN salaries ON employees.emp_no = salaries.emp_no;

# Join using the USING keyword - only available when the column you are joining on has the SAME NAME in both tables
SELECT employees.last_name AS name, salaries.salary AS salary FROM employees JOIN salaries USING (emp_no);

# NATURAL JOIN will only work if both tables have a column with the same name AND that column is defined as a primary key in one of the tables.
SELECT employees.last_name AS name, salaries.salary AS salary FROM employees NATURAL JOIN salaries;

SELECT salary
    FROM salaries s JOIN dept_emp de ON s.emp_no = de.emp_no
    JOIN departments d ON de.dept_no = d.dept_no
    JOIN employees e ON e.emp_no = de.emp_no
WHERE d.dept_name = 'Research';

SELECT CONCAT(first_name, ' ', last_name), salary
FROM salaries s JOIN dept_emp de ON s.emp_no = de.emp_no
                JOIN departments d ON de.dept_no = d.dept_no
                JOIN employees e ON e.emp_no = de.emp_no
WHERE d.dept_name = 'Research'
AND s.to_date = '9999-01-01'
ORDER BY salary DESC;

# Exercises
#     write a query that shows each department along with the name of the current manager for that department.
#
# +--------------------+--------------------+
# | Department Name    | Department Manager |
# +--------------------+--------------------+
# | Customer Service   | Yuchang Weedman    |
# | Development        | Leon DasSarma      |
# | Finance            | Isamu Legleitner   |
# | Human Resources    | Karsten Sigstam    |
# | Marketing          | Vishwani Minakawa  |
# | Production         | Oscar Ghazalie     |
# | Quality Management | Dung Pesch         |
# | Research           | Hilary Kambil      |
# | Sales              | Hauke Zhang        |
# +--------------------+--------------------+

SELECT dept_name AS "Department Name", CONCAT(first_name, ' ', last_name) AS "Department Manager"
    FROM departments d
        JOIN dept_manager dm on d.dept_no = dm.dept_no
        JOIN employees e on e.emp_no = dm.emp_no
    WHERE to_date LIKE '9%'
    ORDER BY dept_name;

# #
# Find the name of all departments currently managed by women.
#
# +------------------+--------------------+
# | Department Name  | Department Manager |
# +------------------+--------------------+
# | Development      | Leon DasSarma      |
# | Finance          | Isamu Legleitner   |
# | Human Resources  | Karsten Sigstam    |
# | Research         | Hilary Kambil      |
# +------------------+--------------------+

SELECT dept_name AS "Department Name", CONCAT(first_name, ' ', last_name) AS "Department Manager"
FROM departments d
         JOIN dept_manager dm on d.dept_no = dm.dept_no
         JOIN employees e on e.emp_no = dm.emp_no
WHERE to_date LIKE '9%'
    AND gender = 'F'
ORDER BY dept_name;

# Current titles of employees currently working in the Customer Service department

# +--------------------+-------+
# | title              | Total |
# +--------------------+-------+
# | Senior Staff       | 11268 |
# | Staff              |  3574 |
# | Senior Engineer    |  1790 |
# | Engineer           |   627 |
# | Technique Leader   |   241 |
# | Assistant Engineer |    68 |
# | Manager            |     1 |
# +--------------------+-------+

SELECT title, COUNT(title) AS Total
FROM titles t JOIN dept_emp de on t.emp_no = de.emp_no
    WHERE dept_no = 'd009'
    AND t.to_date LIKE '9%'
    AND de.to_date LIKE '9%'
GROUP BY title;

#Find the current salary of all current managers.
#
# +--------------------+--------------------+--------+
# | Department Name    | Department Manager | Salary |
# +--------------------+--------------------+--------+
# | Customer Service   | Yuchang Weedman    |  58745 |
# | Development        | Leon DasSarma      |  74510 |
# | Finance            | Isamu Legleitner   |  83457 |
# | Human Resources    | Karsten Sigstam    |  65400 |
# | Marketing          | Vishwani Minakawa  | 106491 |
# | Production         | Oscar Ghazalie     |  56654 |
# | Quality Management | Dung Pesch         |  72876 |
# | Research           | Hilary Kambil      |  79393 |
# | Sales              | Hauke Zhang        | 101987 |
# +--------------------+--------------------+--------+

SELECT dept_name AS "Department Name", CONCAT(first_name, ' ', last_name) AS "Department Manager", salary AS Salary
FROM departments d
         JOIN dept_manager dm on d.dept_no = dm.dept_no
         JOIN employees e on e.emp_no = dm.emp_no
         JOIN salaries s on e.emp_no = s.emp_no
WHERE dm.to_date LIKE '9%'
    AND s.to_date LIKE '9%'
ORDER BY dept_name;

#Bonus Find the names of all current employees, their department name, and their current manager's name .

# +----------------------+------------------+-----------------+
# | Employee             | Department       | Manager         |
# +----------------------+------------------+-----------------+
# | Huan Lortz           | Customer Service | Yuchang Weedman |
# | Basil Tramer         | Customer Service | Yuchang Weedman |
# | Breannda Billingsley | Customer Service | Yuchang Weedman |
# | Jungsoon Syrzycki    | Customer Service | Yuchang Weedman |
# | Yuichiro Swick       | Customer Service | Yuchang Weedman |
# ... 240,124 Rows in total

SELECT CONCAT(e.first_name, ' ', e.last_name) AS Employee,
       dept_name AS Department,
       CONCAT(e2.first_name, ' ', e2.last_name) AS Manager
    FROM employees e
        JOIN dept_emp de ON e.emp_no = de.emp_no
        JOIN departments d ON de.dept_no = d.dept_no
        JOIN dept_manager dm ON d.dept_no = dm.dept_no
        JOIN employees e2 ON dm.emp_no = e2.emp_no
WHERE de.to_date LIKE '9%'
    AND dm.to_date LIKE '9%'
ORDER BY dept_name;

# SELECT CONCAT(e.first_name, ' ' , e.last_name) AS Employee, d.dept_name AS Department, CONCAT(ee.first_name, ' ' , ee.last_name) AS Manager
# FROM employees e
#          JOIN dept_emp de ON e.emp_no = de.emp_no
#          JOIN departments d ON d.dept_no = de.dept_no
#          JOIN dept_manager dm on d.dept_no = dm.dept_no
#          JOIN employees ee on dm.emp_no = ee.emp_no
# WHERE YEAR(de.to_date) = 9999 AND YEAR(dm.to_date) = 9999;

