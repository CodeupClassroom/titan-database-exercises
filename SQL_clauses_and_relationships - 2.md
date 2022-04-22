# SQL Clauses in MySQL

Typically, you are going to want to select a subset of data out of a database. So we are going to use clauses to specify exactly what we are looking for. 

The fundamental clause in SQL is the WHERE clause. We use this to make queries for records that match one or more conditions. 

Some examples from the syllabus
```
SELECT * FROM employees WHERE hire_date = '1985-01-01'

SELECT first_name FROM employees WHERE first_name LIKE '%sus%'

SELECT emp_no, first_name, last_name FROM employees WHERE emp_no BETWEEN 10026 AND 10082;

SELECT emp_no, first_name, last_name FROM employees WHERE last_name IN ('Herber', 'Dredge', 'Lipner', 'Baek');

SELECT emp_no, first_name, last_name FROM employees WHERE emp_no < 10026;

SELECT emp_no, first_name, last_name FROM employees WHERE emp_no < 20000 
    -> AND last_name IN ('Herber', 'Baek')
    -> OR first_name = 'Shridhar';
    
```
NOT BETWEEN AND NOT LIKE
```
SELECT * FROM salaries WHERE NOT salary BETWEEN 50000 AND 100000;

SELECT birth_date FROM employees WHERE NOT birth_date LIKE '195%';

SELECT birth_date, hire_date FROM employees 
WHERE NOT birth_date LIKE '195%'
AND NOT hire_date LIKE '199%';
```


Now what if I want to choose everybody born in a certain month? Make sure you know exactly how the data are represented.

If you try to do January but you think it is 1954-1-... then you will be frustrated.
```
    
SELECT * FROM employees WHERE birth_date LIKE '1954%'

// wrong:
SELECT * FROM employees WHERE birth_date LIKE '1954-1%' AND birth_date NOT LIKE '1954-12%' ORDER BY birth_date ASC;
// even more wrong
 SELECT * FROM employees WHERE birth_date LIKE '1954-1-%' ORDER BY birth_date ASC;
Empty set (0.10 sec)
this is the pattern:
mysql> SELECT * FROM employees WHERE birth_date LIKE '1954-01-%' ORDER BY birth_date ASC;
```


```
Where Clause Exercises    

Part 1

SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya');

SELECT * FROM employees WHERE last_name LIKE 'E%';

SELECT * FROM employees WHERE last_name LIKE '%q%';

Part 2

SELECT * FROM employees WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';

doesn't work:
SELECT * FROM employees WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya' AND gender = 'F';

doesn't work:
SELECT * FROM employees WHERE first_name = ('Irena' OR first_name = 'Vidya' OR first_name = 'Maya') AND gender = 'F';

works:

SELECT * FROM employees WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya') AND gender = 'M';

SELECT * FROM employees WHERE last_name LIKE 'e%' OR last_name LIKE '%e';

SELECT * FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';

```

Let's ORDER BY

```
SELECT * FROM employees WHERE birth_date LIKE '1954-01-%' ORDER BY birth_date;

SELECT * FROM employees WHERE birth_date LIKE '1954-01-%' ORDER BY birth_date, last_name;

```
exercises
```
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name;

SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name, last_name;
```
 let's LIMIT and OFFSET

```
SELECT * FROM employees WHERE birth_date LIKE '1954-01-%' ORDER BY birth_date, last_name LIMIT 20;

SELECT * FROM employees WHERE birth_date LIKE '1954-01-%' ORDER BY birth_date, last_name LIMIT 20 OFFSET 30;
```

exercises

```
SELECT DISTINCT last_name FROM employees ORDER BY last_name DESC LIMIT 10;

SELECT salary FROM salaries ORDER BY salary DESC LIMIT 5;

SELECT emp_no, salary FROM salaries ORDER BY salary DESC LIMIT 5;

SELECT emp_no, salary FROM salaries ORDER BY salary DESC LIMIT 5 OFFSET 45;
```



A little extra
The underscore _ wild card stands for one unknown character.
The DISTINCT clause retrieves only the unique values that match the query.

```
SELECT * FROM employees WHERE last_name LIKE '__e%';
SELECT * FROM employees WHERE last_name LIKE '__e%' ORDER BY last_name;
this doesn't even do anything
SELECT DISTINCT * FROM employees WHERE last_name LIKE '__e%' ORDER BY last_name;
sweeeet
SELECT DISTINCT last_name FROM employees WHERE last_name LIKE '__e%' ORDER BY last_name;
```

## Functions

```
SELECT CONCAT (first_name, last_name) FROM employees WHERE first_name = 'Maya';

SELECT CONCAT (first_name, ' ',  last_name) FROM employees WHERE first_name = 'Maya';

SELECT CONCAT (first_name, ' ',  last_name) FROM employees WHERE first_name = 'Maya' ORDER BY last_name;

SELECT DAYOFMONTH(hire_date) FROM employees WHERE first_name = 'Maya';

SELECT DAYOFMONTH(hire_date) FROM employees WHERE first_name = 'Maya' ORDER BY DAYOFMONTH(hire_date);

SELECT DISTINCT DAYOFMONTH(hire_date) FROM employees WHERE first_name = 'Maya' ORDER BY DAYOFMONTH(hire_date);
```
Look at datediff()
[Date and time functions](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html)
```
SELECT * FROM employees WHERE last_name LIKE '%E' AND last_name LIKE 'e%';

SELECT * FROM employees WHERE DAY(birth_date) = 25 AND MONTH(birth_date) = 12;

SELECT * FROM employees WHERE DAY(birth_date) = 25 AND MONTH(birth_date) = 12 AND YEAR(hire_date) LIKE '199%';

SELECT * FROM employees WHERE DAY(birth_date) = 25 AND MONTH(birth_date) = 12 AND YEAR(hire_date) LIKE '199%' ORDER BY birth_date ASC, hire_date DESC;

SELECT *, DATEDIFF(hire_date, NOW()) FROM employees WHERE DAY(birth_date) = 25 AND MONTH(birth_date) = 12 AND YEAR(hire_date) LIKE '199%' ORDER BY DATEDIFF(hire_date, NOW()) DESC;
```

BONUS

every employee aged 35 when hired

```
 SELECT * FROM employees WHERE YEAR(birth_date) + 35 = YEAR(hire_date);
```

## Aggregate Functions


```
SELECT COUNT(first_name) FROM employees;

SELECT COUNT(first_name) FROM employees GROUP BY gender;

SELECT COUNT(first_name),gender FROM employees GROUP BY gender;

SELECT COUNT(*),gender FROM employees GROUP BY gender;

SELECT AVG(DATEDIFF(hire_date, birth_date))/365 FROM employees;

SELECT MIN(DATEDIFF(hire_date, birth_date))/365 FROM employees;
+------------------------------------------+
| MIN(DATEDIFF(hire_date, birth_date))/365 |
+------------------------------------------+
|                                  20.0411 |
+------------------------------------------+
1 row in set (0.07 sec)

mysql> SELECT MAX(DATEDIFF(hire_date, birth_date))/365 FROM employees;
+------------------------------------------+
| MAX(DATEDIFF(hire_date, birth_date))/365 |
+------------------------------------------+
|                                  47.9096 |
+------------------------------------------+
1 row in set (0.07 sec)

```

GROUP BY combines duplicates into one single value for each group
Consolidates rows based on a common column
The Group By clause tells MySQL how to cluster values before counting them.

EXERCISES:
```
SELECT DISTINCT title FROM titles;

SELECT DISTINCT last_name FROM employees WHERE last_name LIKE '%E' AND last_name LIKE 'e%';
+-----------+
| last_name |
+-----------+
| Erde      |
| Eldridge  |
| Etalle    |
| Erie      |
| Erbe      |
+-----------+
5 rows in set (0.11 sec)

SELECT last_name FROM employees WHERE last_name LIKE '%E' AND last_name LIKE 'e%' GROUP BY last_name;

SELECT DISTINCT first_name, last_name FROM employees WHERE last_name LIKE '%E' AND last_name LIKE 'e%' GROUP BY last_name, first_name;

SELECT last_name FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%' GROUP BY last_name ;

SELECT COUNT(last_name),last_name FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%' GROUP BY last_na
me ;

 SELECT gender, COUNT(*) FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') GROUP BY gender;
```

## Aliases

```
SELECT MAX(DATEDIFF(hire_date, birth_date))/365 AS age_at_hire FROM employees;


SELECT CONCAT(first_name, ' ', last_name) AS name, DATEDIFF(hire_date, birth_date)/365 AS age_at_hire FROM employees ORDER BY DATEDIFF(hire_date, birth_date)/365 DESC LIMIT 10;
```
Exercises

```
SELECT CONCAT (last_name, ' ', first_name) AS full_name FROM employees LIMIT 10;

SELECT CONCAT (last_name, ' ', first_name) AS full_name, birth_date FROM employees LIMIT 10;

SELECT CONCAT (emp_no, ' - ', last_name, ', ', first_name) AS full_name, birth_date AS DOB FROM employees LIMIT 10;
```

# Relationships

## Indexes

Queries take time in the real world. In vast tables they can take an annoyingly long time.So in a real-life database we can create indexes on tables that enable the database server to look up rows more quickly. This pertains to a topic called Query Optimization. 

(SHOW INDEXES)[https://www.mysqltutorial.org/mysql-index/mysql-show-indexes/]

You can see indexes existing on a table as follows
```
SHOW INDEXES FROM employees;

SHOW INDEXES from departments;
```

Typically you create an index on a very-often used column in a big table with lots of columns and rows. Usually the database server will have to laboriously scan every single column of every single row one at a time. If you have an index on a column, the data is organized in sequential order and the server can apply an algorithm to finding exactly the right data to match your query, which can speed up your queries considerably on very large databases. Primary Keys are a sort of already-existing index.

The syntax is 
ALTER TABLE tbl_name ADD INDEX index_name (index_columns);

So for example you would want to do something like 
```
SELECT salary FROM salaries WHERE salary < 70000 AND salary > 50000;

1258705 rows in set (0.57 sec)

ALTER TABLE salaries ADD INDEX salary_index (salary);

SELECT salary FROM salaries WHERE salary < 70000 AND salary > 50000;

1258705 rows in set (0.34 sec)
```

An index is basically a behind-the-scenes table that puts the searchable data in an order that maximizes search speed. It takes up significant space, so it's usually done only on frequently searched columns with high column cardinality. Column cardinality is the total number of unique values in a column, is linked to index usefulness, if there are a lot of values in an index this will speed up retrieval, if not it is useless (like if you only have two or three values). Serious database tuning is a whole topic of its own though, that's as far as we go on this topic here.

You can also create a unique index. 

This creates an index on a table column but adds a constraint that means the values cannot be repeated. 

The syntax is 
ALTER TABLE tbl_name ADD UNIQUE (index_columns);

```
CREATE TABLE quotes (
    id INT NOT NULL AUTO_INCREMENT,
    content VARCHAR(240) NOT NULL,
    author VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE quotes ADD UNIQUE (content);

INSERT INTO quotes (content, author)
VALUES ('The real voyage of discovery consists not in seeking new landscapes, but in having new eyes.', 'Marcel Proust');

# the following now generates an error message
#ERROR 1062 (23000): Duplicate entry 'The real voyage of discovery consists not in seeking new landsca' for key 'quotes.content'

INSERT INTO quotes (content, author)
VALUES ('The real voyage of discovery consists not in seeking new landscapes, but in having new eyes.', 'Rando on Twitter');
```

Last but not least I can drop an index I've created

```
DROP INDEX salary_index ON salaries;
```

EXERCISE

```
ALTER TABLE albums ADD UNIQUE unique_artist_name (artist, name);

ALTER TABLE albums DROP INDEX unique_artist_name;
```

### keys

A subtopic here is keys. There are two types of keys, primary and foreign.

Primary keys are used to make every row in a table unique. It's a column of data in which each value has to be unique. Typically it's a simple auto-incremented number that is labeled as an id for the table. It make it so, for example, two people both called John Smith in New York, or two people named Zhang Wei in Beijing, cannot be easily distinguished, but when you add a primary key, each Zhang Wei or John Smith is clearly different.

The rules of primary keys are: 
All primary keys must have a unique value, the data can never be repeated; 
A primary key must have a value, it cannot be null; 
The primary key must be set when the new row is created, it cannot be added later; 
The primary key must be as efficient as possible, its sole purpose is to allow for uniqueness; Its value can never be changed because that risks accidentally setting it to a value you already used.

Then there are foreign keys. A foreign key is a column in one tab le that references the primary key of another table. It's used to connect two tables. Let's have an example.

In our codeup_test_db, we have our albums table. Let's create a second table

```
USE codeup_test_db;

CREATE TABLE persons (
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(25) NOT NULL,
    album_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (author_id) REFERENCES albums (id)
);
```

This sets up a connection between tables, which will be further discussed in the Database design lecture. It basically says, "each value in the album_id column of the persons table corresponds to the same value in the id column of the albums table."

You can take it one step further and set up a constraint. When you do this, the connection between tables is enforced and you get an error if the value you put in to album_id doesn't have a corresponding value in the id column of the albums table; and likewise you cannot delete an row from the albums table if it has a corresponding foreign key somewhere else in the database. 

```
DROP TABLE persons

CREATE TABLE persons (
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(25) NOT NULL,
    album_id INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT persons_album_id_fk FOREIGN KEY (album_id) REFERENCES albums (id)
);
```

The idea here is that the album_id represents the person's favorite album. We don't store the full album name in there as that would consume a lot more storage space.

## Joins

### Inner Join / Join

A join, aka inner join, is used to combine the records from two tables using comparison operators on some condition, most often an equality between a primary key and a foreign key. When the condition is that two things in the joined tables are equal, it is also called an equijoin, an inner join that tests for equality.

```
SELECT COUNT(emp_no) FROM salaries;
SELECT COUNT(emp_no) FROM employees;

SELECT employees.last_name AS name, salaries.salary AS salary FROM employees JOIN salaries ON salaries.emp_no = employees.emp_no;

2844047 rows in set (1.63 sec)

```

This is known as JOIN or INNER JOIN

We have here multiple tables in the FROM clause separated by the keyword JOIN. The MySQL server matches rows in one table with rows in the other table. So this means "select the last_name column from the employees table and the salary column from the salaries table." The rest of the query joins those two columns in a new results table, based on the knowledge that the employee number in each table matches rows.

The ON is similar to a WHERE. It tells the database server to look for matches between employee numbers and where it finds that match, line up the employee name from the employees table with the corresponding salary from the salaries table.

We can perfect it somewhat

```
SELECT CONCAT(employees.last_name, ' ', employees.first_name) AS name, salaries.salary AS salary FROM employees JOIN salaries ON salaries.emp_no = employees.emp_no GROUP BY CONCAT(employees.last_name, ' ', employees.first_name), salaries.salary;

SELECT CONCAT(employees.last_name, ' ', employees.first_name) AS name, salaries.salary AS salary, salaries.from_date AS startDate, salaries.to_date AS endDate FROM employees JOIN salaries ON salaries.emp_no = employees.emp_no LIMIT 20;

```

We could clean up the query itself with some table aliases.

### Left join

Then there is the LEFT JOIN

This joins tables but can also show rows on the left table that have no match in the right table. It will show NULL on the right table when there is no match. It forces the result set to contain a row for every row selected from the left table, whether or not there is a match for it in the right table. This can be useful for figuring out when something has not happened -- a product has no sales, a customer has no account representative, a student has no absences.

Create the join_test_db

```
CREATE DATABASE join_test_db;

USE join_test_db;

CREATE TABLE roles (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  role_id INT UNSIGNED DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (role_id) REFERENCES roles (id)
);

INSERT INTO roles (name) VALUES ('admin');
INSERT INTO roles (name) VALUES ('author');
INSERT INTO roles (name) VALUES ('reviewer');
INSERT INTO roles (name) VALUES ('commenter');

INSERT INTO users (name, email, role_id) VALUES
('bob', 'bob@example.com', 1),
('joe', 'joe@example.com', 2),
('sally', 'sally@example.com', 3),
('adam', 'adam@example.com', 3),
('jane', 'jane@example.com', null),
('mike', 'mike@example.com', null);
```

Now we can do a left join

```
USE join_test_db;

SELECT users.name AS user_name, roles.name AS role_name FROM users LEFT JOIN roles ON users.role_id = roles.id;
+-----------+-----------+
| user_name | role_name |
+-----------+-----------+
| bob       | admin     |
| joe       | author    |
| sally     | reviewer  |
| adam      | reviewer  |
| jane      | NULL      |
| mike      | NULL      |
+-----------+-----------+

```

Notice even though the MySQL server cannot find a match for jane or mike in the left table for role_name, it does go ahead and construct the result set anyway and inserts null for these rows.

Let's use the table we created earlier in our codeup_test_db.

```
USE codeup_test_db;

INSERT INTO persons (first_name, album_id) VALUES ('Olivia', 29), ('Santiago', 27), ('Tareq', 15), ('Anaya', 28);

 SELECT p.first_name, a.name FROM persons p JOIN albums a ON p.album_id = a.id;
```

On the join, we get all the columns where the album_id from persons matches up with the id from albums. 

A left outer join takes all the rows in the left table and matches them to rows in the right table.

```
 SELECT p.first_name, a.name FROM persons p LEFT JOIN albums a ON p.album_id = a.id;
```
No difference BUT swap the order of the tables and ...
```
SELECT p.first_name, a.name FROM albums a LEFT JOIN persons p ON p.album_id = a.id;
```

The first query takes all the rows in the left table ... the persons table ... and matches them to rows on the right table.

In the second query, every row in the left table - the albums table is compared to the persons table. If a match is found,it shows up as a result in the result set; otherwise we still get a row, but with NULL for the unmatched value. The order the columns show up is determined by the order in which we selected them. 

The RIGHT JOIN, aka RIGHT OUTER JOIN, is exactly the same except it starts on the right table comparing it to the left table. Which is why it is rarely used, because you can always do a left join and just reverse the order of the tables.

```
 SELECT p.first_name, a.name FROM persons p RIGHT JOIN albums a ON p.album_id = a.id;
```
```
SELECT p.first_name, a.name FROM albums a RIGHT JOIN persons p ON p.album_id = a.id;
```

## The Associative Table

Sometimes, for purposes of database design efficiency, we have tables related by associative tables. For example, our persons table is fine as long as we are only interested in the favorite album. But what if we want album preferences. Each cell should have atomic data, so how do we handle it? We create associative tables.

```
CREATE TABLE preferences (
    person_id INT NOT NULL,
    album_id INT NOT NULL
    );
```
These are in fact foreign keys and should probably be defined as such.

```
CREATE TABLE preferences (
    person_id INT UNSIGNED NOT NULL,
    album_id INT UNSIGNED NOT NULL,
    CONSTRAINT preferences_person_id_fk FOREIGN KEY (person_id) REFERENCES persons (id),
    CONSTRAINT preferences_album_id_fk FOREIGN KEY (album_id) REFERENCES albums (id)
    );
```

Let's populate our table a little bit.
```
INSERT INTO preferences (person_id, album_id) VALUES (1, 12), (1, 5), (1, 22), (1, 29), (2, 1), (2, 31), (2, 30), (3, 11), (3, 26), (3, 25);
```

and now how to we do the join?

```
SELECT p.first_name AS name, a.name AS album FROM persons p JOIN preferences pf ON p.person_id = pf.person_id JOIN albums a ON pf.album_id = a.id;
```

So, that is an associative table or junction table, containing foreign keys to two tables. We join one table to the junction table and then the junction table to the second table and that way we get a link between people and their preferences. We can drop the album_id from the persons table now, too, and leave that information in preferences.


## back to multi-table joins

Let's try to find the current salaries of everyone in the Research department

```
SELECT salary 
    FROM salaries s JOIN dept_emp de ON s.emp_no = de.emp_no 
    JOIN departments d ON de.dept_no = d.dept_no 
    WHERE d.dept_name = 'Research';
```

Now, let's list their salaries with their names

```
SELECT CONCAT(first_name, ' ', last_name), salary 
 FROM salaries s JOIN dept_emp de ON s.emp_no = de.emp_no 
 JOIN departments d ON de.dept_no = d.dept_no 
 JOIN employees e ON de.emp_no = e.emp_no
WHERE d.dept_name = 'Research';
```

Let's make the salaries current

```
SELECT CONCAT(first_name, ' ', last_name), salary FROM salaries s JOIN dept_emp de ON s.emp_no = de.emp_no JOIN departments d ON de.dept_no = d.dept_no JOIN employees e ON de.emp_no = e.emp_no WHERE d.dept_name = 'Research' AND s.to_date = '9999-01-01';
```

and list them in order from highest to lowest

```
SELECT CONCAT(first_name, ' ', last_name), salary FROM salaries s JOIN dept_emp de ON s.emp_no = de.emp_no JOIN departments d ON de.dept_no = d.dept_no JOIN employees e ON de.emp_no = e.emp_no WHERE d.dept_name = 'Research' AND s.to_date = '9999-01-01' ORDER BY salary DESC;
```

## Exercises

Problem 2: 

Show each department along with the name of the current manager for that department.

how I arrived at the answer:

```
# first gain an understanding of the structure of the required tables

DESCRIBE departments;

DESCRIBE dept_manager;

DESCRIBE employees;

SELECT CONCAT(e.first_name, ' ', e.last_name) FROM employees e LIMIT 10;

SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager' FROM employees e LIMIT 10;

SELECT d.dept_name AS 'Department Name', 
    CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager' 
FROM employees e JOIN dept_manager dm ON e.emp_no = dm.emp_no 
    JOIN departments d ON dm.dept_no = d.dept_no;

SELECT * FROM dept_manager;

```
The answer:
```
SELECT d.dept_name AS 'Department Name', 
    CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager' 
FROM employees e JOIN dept_manager dm ON e.emp_no = dm.emp_no 
    JOIN departments d ON dm.dept_no = d.dept_no 
WHERE to_date LIKE '9%';
```

Problem 3:
Find the name of all departments currently managed by women:
```
DESCRIBE employees;

SELECT d.dept_name AS 'Department Name', 
    CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager' 
FROM employees e JOIN dept_manager dm ON e.emp_no = dm.emp_no 
    JOIN departments d ON dm.dept_no = d.dept_no 
WHERE to_date LIKE '9%' 
    AND gender='F' ;
```

Problem 3:
Current titles of employees currently working in the Customer Service department

The tricky part here is realizing you have to include both de.to_date and t.to_date in your WHERE clause. The clue is current titles / currently working -- the word currently occurs twice, hinting

```
SELECT title, COUNT(title) AS Total
FROM titles t JOIN dept_emp de
    ON t.emp_no = de.emp_no
WHERE de.dept_no = 'd009'
  AND de.to_date LIKE '9%'
  AND t.to_date LIKE '9%'
GROUP BY title;
```

or

```
SELECT title, COUNT(title) AS Total 
FROM titles t JOIN dept_emp de ON de.emp_no = t.emp_no 
    JOIN departments d ON d.dept_no = de.dept_no 
WHERE dept_name = 'Customer Service' 
    AND t.to_date LIKE '9%' 
    AND de.to_date LIKE '9%' 
GROUP BY title;
```


How I arrived at the solution:

Start by getting all the titles for everyone in Customer Service:
```
SELECT title 
FROM titles t JOIN dept_emp de ON t.emp_no = de.emp_no
    JOIN departments d ON de.dept_no = d.dept_no 
WHERE d.dept_name = 'Customer Service';
```

Now I clearly have to aggregate all the titles so there are no duplicates. Group By is the way to go. Select Distinct title is another option, but this would lead to an error when I try to get the counts. I will get "In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column", which tells me that I need a group by.

```
SELECT title
FROM titles t JOIN dept_emp de ON t.emp_no = de.emp_no
              JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Customer Service'
    GROUP BY t.title;
```

Now I get the count -- again, this would not work if I had decided to go with SELECT DISTINCT title.

```
SELECT title, COUNT(title)
FROM titles t JOIN dept_emp de ON t.emp_no = de.emp_no
              JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Customer Service'
    GROUP BY t.title;
```

Now I have to narrow it down to current holders of titles.

```
SELECT title, COUNT(title)
FROM titles t JOIN dept_emp de ON t.emp_no = de.emp_no
              JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Customer Service'
    AND t.to_date LIKE '9%'
    GROUP BY t.title;
```

I've still got too many query results, and I think what's happening is some of these people once held a title in Customer Service but are no longer with Customer Service, so I have to narrow it down a little more

```
SELECT title, COUNT(title)
FROM titles t JOIN dept_emp de ON t.emp_no = de.emp_no
              JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Customer Service'
    AND t.to_date LIKE '9%'
    AND de.to_date LIKE '9%'
    GROUP BY t.title;
```




Current salary of all current managers

How to solve this

```
# I know I need department names, department manager names, and salaries
# So I know I have to join the departments table, the department managers table, and the salaries table.
# But I notice that the department managers table does not have the managers' names.
# Managers' names are in the employees table. Managers' identities, identified by employee number, are in the department managers table. Therefore I need to include the employees table in my join chain

# I can get all the salaries of all managers ever like this:

SELECT salary FROM salaries s JOIN dept_manager dm ON s.emp_no = dm.emp_no;

# I can add their names like this:

SELECT salary, CONCAT(first_name, ' ', last_name) 
    FROM salaries s JOIN dept_manager dm ON s.emp_no = dm.emp_no 
    JOIN employees e on e.emp_no = dm.emp_no;

# The problem here is, I get EVERY salary the department managers have ever had in their entire careers at The Company in addition, this includes people who used to be managers but no longer are so I add a WHERE clause restricting the results to current salaries and managers

SELECT salary, CONCAT(first_name, ' ', last_name)
    FROM salaries s JOIN dept_manager dm ON s.emp_no = dm.emp_no
        JOIN employees e on e.emp_no = dm.emp_no
    WHERE s.to_date LIKE '9%'
    AND dm.to_date LIKE '9%';

# Now I have the columns in the wrong order, and I need to add the department name. To do that, I need to go ahead and join to the departments table.

SELECT dept_name, CONCAT(first_name, ' ', last_name), salary
    FROM salaries s JOIN dept_manager dm ON s.emp_no = dm.emp_no
        JOIN employees e on e.emp_no = dm.emp_no
        JOIN departments d on dm.dept_no = d.dept_no
    WHERE s.to_date LIKE '9%'
    AND dm.to_date LIKE '9%';


# It looks like the desired output is for the departments to be listed in alphabetical order, so I will do that

SELECT dept_name, CONCAT(first_name, ' ', last_name), salary
    FROM salaries s JOIN dept_manager dm ON s.emp_no = dm.emp_no
        JOIN employees e on e.emp_no = dm.emp_no
        JOIN departments d on dm.dept_no = d.dept_no
    WHERE s.to_date LIKE '9%'
    AND dm.to_date LIKE '9%'
    ORDER BY dept_name;
```


Bonus

Find the names of all current employees, their department name, and their current manager's name.

One approach to solving it.

```
# First, get all current employees' names. I'll use a join on the dept_emp table and a WHERE clause to limit the results to all current employees. 


SELECT CONCAT(first_name, ' ', last_name)
    FROM employees e JOIN dept_emp de ON e.emp_no = de.emp_no
WHERE de.to_date LIKE '9%';

# I've got the 240124 results I'm supposed to get. Now I will list out their department 
# To do this, I've got to extend the join chain as far as the departments table


SELECT CONCAT(first_name, ' ', last_name), dept_name
    FROM employees e
        JOIN dept_emp de ON e.emp_no = de.emp_no
        JOIN departments d ON de.dept_no = d.dept_no
WHERE de.to_date LIKE '9%';

# Now, I know that I have to get the department managers. So I can extend the join chain as far as dept_manager. Be careful what you join with. Pick any old thing IntelliJ suggests and you could go way off base. We want to join dept_manager on the match between the employee's department number and the corresponding department number in the department manager table.

SELECT CONCAT(first_name, ' ', last_name), dept_name
    FROM employees e
        JOIN dept_emp de ON e.emp_no = de.emp_no
        JOIN departments d ON de.dept_no = d.dept_no
        JOIN dept_manager dm ON d.dept_no = dm.dept_no
WHERE de.to_date LIKE '9%'

# I'll test my code by outputting the department manager's employee number.

SELECT CONCAT(first_name, ' ', last_name), dept_name, dm.emp_no
    FROM employees e
        JOIN dept_emp de ON e.emp_no = de.emp_no
        JOIN departments d ON de.dept_no = d.dept_no
        JOIN dept_manager dm ON d.dept_no = dm.dept_no
WHERE de.to_date LIKE '9%'

# Eek, I've gone to over 600 thousand results and the employees are repeated. Looks like matching managers has resulted in some outdated results. I'll use another where clause on the managers table

SELECT CONCAT(first_name, ' ', last_name), dept_name, dm.emp_no
    FROM employees e
        JOIN dept_emp de ON e.emp_no = de.emp_no
        JOIN departments d ON de.dept_no = d.dept_no
        JOIN dept_manager dm ON d.dept_no = dm.dept_no
WHERE de.to_date LIKE '9%'
    AND dm.to_date LIKE '9%';

# OK, back to 240124 rows. Now all I have to do is get the managers' names. The key insight here is that a Self Join defines the employees table as an entirely different table and treats it as such. In other words, you just have to think, hey I need to join from department managers to an employees table. It's like this

SELECT CONCAT(e.first_name, ' ', e.last_name), dept_name, CONCAT(e2.first_name, ' ', e2.last_name)
    FROM employees e
        JOIN dept_emp de ON e.emp_no = de.emp_no
        JOIN departments d ON de.dept_no = d.dept_no
        JOIN dept_manager dm ON d.dept_no = dm.dept_no
        JOIN employees e2 ON dm.emp_no = e2.emp_no
WHERE de.to_date LIKE '9%'
    AND dm.to_date LIKE '9%'

# Now, to get the order just like in the curriculum exercise example output
# First, order by department name to get Customer Service employees first

SELECT CONCAT(e.first_name, ' ', e.last_name), dept_name, CONCAT(e2.first_name, ' ', e2.last_name)
    FROM employees e
        JOIN dept_emp de ON e.emp_no = de.emp_no
        JOIN departments d ON de.dept_no = d.dept_no
        JOIN dept_manager dm ON d.dept_no = dm.dept_no
        JOIN employees e2 ON dm.emp_no = e2.emp_no
WHERE de.to_date LIKE '9%'
    AND dm.to_date LIKE '9%'
ORDER BY dept_name;

# and then tack on an order by employee number to see if we can get Huan Lortz first

SELECT CONCAT(e.first_name, ' ', e.last_name), dept_name, CONCAT(e2.first_name, ' ', e2.last_name)
    FROM employees e
        JOIN dept_emp de ON e.emp_no = de.emp_no
        JOIN departments d ON de.dept_no = d.dept_no
        JOIN dept_manager dm ON d.dept_no = dm.dept_no
        JOIN employees e2 ON dm.emp_no = e2.emp_no
WHERE de.to_date LIKE '9%'
    AND dm.to_date LIKE '9%'
ORDER BY dept_name, e.emp_no;

# there it is
```

Here's a different way of explaining it

```
# The key here is to line up the employees table twice, but using a different condition on each time each time you give the MySQL database server a condition for joining, the server decides that it will line up the rows you have requested every time it finds that match

# The whole time I'm working out the solution I am using LIMIT 20, otherwise I'm wasting time and CPU resources. I only lift the limit near the end

# I know I need the concatenated last name and first name of every current employee
# that's from the employees table. I need the department name - that's in the departments table and I need the manager's name - that's in the employees table again - But how?

# think of joins as creating a great big temporary table that only lives while the query is being made
# so I want to line up an employee's name with the department they are working in. Well, the department name is in the departments table, and the number representing the department every employee works in is in the department employees table

# so I need a table that looks like
# employees.last_name | employees.first_name | employees.emp_no | dept_emp.emp_no | dept_emp.dept_no | departments.dept_name

# armed with this knowledge I can set up my first join chain

SELECT CONCAT(e.last_name, ' ', e.first_name) AS employee,
       d.dept_name AS Department
FROM employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    JOIN departments d on d.dept_no = de.dept_no
LIMIT 20;

# I've successfully built the first two thirds of the query
# Now I just need to tell the MySQL server "when you find a match between that department's manager and the department manager's name, line up the rows that have the matching value"
# Think of a JOIN clause as telling the server how to join up rows between columns from different tables. 
# you say, hey server, whenever a specified condition is true, like some column's value in one table matches a value in a column in another table, go ahead and line up the rows that have the matching value

# so we know each department, identified by number, has a manager, identified by the dept_no of the department they manage as well as by their employee number. So I have to link departments to dept_manager using dept_no match as the condition
# to test this, I'm going to give the manager's employee number as output

SELECT CONCAT(e.last_name, ' ', e.first_name) AS employee,
       d.dept_name AS Department,
       dm.emp_no AS 'Manager Employee Number'
FROM employees e
         JOIN dept_emp de ON e.emp_no = de.emp_no
         JOIN departments d on d.dept_no = de.dept_no
         JOIN dept_manager dm on d.dept_no = dm.dept_no
LIMIT 20;

# Now I just have to tell the server to line up the manager's name, based on an employee number match
# But this time I am not matching employee to dept_emp
# No, this time I want to match the manager's identity, which I just got, to their name
# that means Joining dept_manager to employees
# the server will get confused if I use the same alias for employees
# The server already has a representation of employees stored in the alias e, and that representation is linked to the employee in the first column
# we need a new representation linked to the manager's employee number
# so we create a new alias, e2
# we delete the employee number from our output and we try the new query

SELECT CONCAT(e.last_name, ' ', e.first_name) AS employee,
       dept_name AS Department,
       CONCAT(e2.last_name, ' ', e2.first_name) AS Manager
FROM employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    JOIN departments d ON de.dept_no = d.dept_no
    JOIN dept_manager dm ON d.dept_no = dm.dept_no
    JOIN employees e2 ON e2.emp_no = dm.emp_no;

# That's the right output, but 897570 rows ...
# I forgot to limit the results to only current employees

# I get duplicate results when I only limit to current employees,
# ... I investigate by using a query to one employee last name

SELECT CONCAT(e.last_name, ' ', e.first_name) AS employee,
       dept_name AS Department,
       CONCAT(e2.last_name, ' ', e2.first_name) AS Manager
FROM employees e
         JOIN dept_emp de ON e.emp_no = de.emp_no
         JOIN departments d ON de.dept_no = d.dept_no
         JOIN dept_manager dm ON d.dept_no = dm.dept_no
         JOIN employees e2 ON e2.emp_no = dm.emp_no
WHERE de.to_date LIKE '9%' AND e.last_name = 'Sichman';

# Ahhhh, now I see. Yes, the server is querying for the
# name of the manager of that department ... but the
# dept_manager table contains every person who has ever managed that department
# I need to limit my results to just the current person who manages the department

SELECT CONCAT(e.last_name, ' ', e.first_name) AS employee,
       dept_name AS Department,
       CONCAT(e2.last_name, ' ', e2.first_name) AS Manager
FROM employees e
         JOIN dept_emp de ON e.emp_no = de.emp_no
         JOIN departments d ON de.dept_no = d.dept_no
         JOIN dept_manager dm ON d.dept_no = dm.dept_no
         JOIN employees e2 ON e2.emp_no = dm.emp_no
WHERE de.to_date LIKE '9%' AND dm.to_date LIKE '9%';

# And I see the longed-for confirmation: 240124 rows in set (0.85 sec)
```

## Subqueries

A subquery is a query within a query. The most common use of a subquery is to find out if a query result is within the set of results of another query.

Let's use a different approach from joins to get our department managers' birth days. We could write a join but as we have seen these can get tricky and complicated. So we can use the strategy of getting a set of results that only refers to managers, and use an IN keyword to see what employees are within that set.

Let's say we know the employee numbers are both in the department manager and employees tables. They are the same in each. So we can select all the emp_no from dept_manager 

```
SELECT emp_no FROM dept_manager;
```

That's a nice set of results. Now remember the IN keyword? What if we did this

(WATCH OUT FOR THE SEMICOLON AFTER THE FIRST QUERY)

```
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
```

You can also use these subqueries in INSERT statements or UPDATE statements

Notice in the preferences table we have just person_id and album_id. If this gets big, it's a pain to have to look up everybody's person id and every album's id but if you can know just the plain English names, you can

```
USE codeup_test_db;

SELECT * FROM preferences;

INSERT INTO preferences (person_id, album_id) VALUES ((SELECT person_id FROM persons WHERE first_name = 'Tareq'), (SELECT id FROM albums WHERE name = '1'));

UPDATE preferences 
    SET album_id = (SELECT id FROM albums WHERE name = 'Led Zeppelin IV')
    WHERE album_id = (SELECT id FROM albums WHERE name = '1') 
    AND person_id = (SELECT person_id FROM persons WHERE first_name = 'Tareq')
    ; 
```

EXERCISES

```
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


SELECT title, COUNT(title)
FROM titles
WHERE emp_no IN (
    SELECT emp_no FROM employees WHERE first_name = 'Aamod'
)
GROUP BY title;


SELECT first_name, last_name
FROM employees
WHERE emp_no IN (

    SELECT emp_no
    FROM dept_manager
    WHERE to_date > NOW()

)
  AND gender = 'F';

# BONUS ######################

SELECT dept_name
FROM departments
WHERE dept_no IN (
    SELECT dept_no
    FROM dept_manager
    WHERE to_date LIKE '9999%' AND emp_no IN (
        SELECT emp_no
        FROM employees
        WHERE gender = 'F'
    )
)
ORDER BY dept_name;

--  https://stackoverflow.com/questions/1547125/sql-how-to-find-the-highest-number-in-a-column
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
WHERE emp_no IN (
    SELECT emp_no
    FROM salaries
    WHERE to_date LIKE '9999%' AND salary IN (
        SELECT MAX(salary) from salaries
    )
);
```



