USE employees;

SELECT employees.last_name AS name, salaries.salary AS salary FROM employees JOIN salaries ON employees.emp_no = salaries.emp_no;

SELECT CONCAT(employees.last_name, ' ', employees.first_name) AS name, salaries.salary AS salary, salaries.from_date AS startDate, salaries.to_date AS endDate FROM employees JOIN salaries ON employees.emp_no = salaries.emp_no WHERE salaries.emp_no = 14781;

SELECT CONCAT(e.last_name, ' ', e.first_name) AS name, s.salary AS salary, s.from_date AS startDate, s.to_date AS endDate FROM employees e JOIN salaries s ON e.emp_no = s.emp_no;



