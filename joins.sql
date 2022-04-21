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




