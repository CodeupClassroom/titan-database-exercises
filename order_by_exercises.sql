USE employees;

# 1. Create a new file called order_by_exercises.sql and copy in the contents of your where_exercises.sql.


# 2. Modify your first query to order by first name. The first result should be Irena Flexer and the last result should be Vidya Awdeh.

SELECT * FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;

# 3. Update the query to order by first name and then last name. The first result should now be Irena Acton and the last should be Vidya Zweizig.

SELECT * FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;


# 4. Change the order by clause so that you order by last name before first name. Your first result should still be Irena Acton but now the last result should be Maya Zyda.

SELECT * FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;


# 5. Update your queries for employees with 'e' in their last name to sort the results by their employee number. Make sure the employee numbers are in the correct order.

SELECT * FROM employees
WHERE last_name LIKE '%e%'
ORDER BY emp_no DESC;