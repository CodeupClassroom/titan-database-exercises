USE employees;

# WHERE EXERCISES ----- PART 1

# 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya' — 709 rows (Hint: Use IN).
SELECT *
FROM employees
where first_name IN ('Irena', 'Vidya', 'Maya');

# 3. Find all employees whose last name starts with 'E' — 7,330 rows.
SELECT * FROM employees WHERE last_name LIKE 'e%';

# 4. Find all employees with a 'q' in their last name — 1,873 rows.
SELECT * FROM employees WHERE last_name LIKE '%q%';



# WHERE EXERCISES ----- PART 2

# 1. Update your query for 'Irena', 'Vidya', or 'Maya' to use OR instead of IN — 709 rows.
SELECT *
FROM employees
WHERE first_name = 'Irena'
    OR first_name = 'Vidya'
    OR first_name = 'Maya';

# 2. Add a condition to the previous query to find everybody with those names who is also male — 441 rows.

SELECT *
FROM employees
WHERE (first_name = 'Irena'
   OR first_name = 'Vidya'
   OR first_name = 'Maya')
   AND gender = 'M';

# 3. Find all employees whose last name starts or ends with 'E' — 30,723 rows.
SELECT *
FROM employees
WHERE last_name LIKE 'E%' OR last_name LIKE '%E';

# 4. Duplicate the previous query and update it to find all employees whose last name starts and ends with 'E' — 899 rows.
SELECT *
FROM employees
WHERE last_name LIKE 'e%e';

# 5. Find all employees with a 'q' in their last name but not 'qu' — 547 rows.
select *
FROM employees
WHERE last_name LIKE '%q%'
  AND last_name NOT LIKE '%qu%';

