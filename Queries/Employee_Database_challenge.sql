-- Retrieve info from employees born between 1952 and 1955 and save into a new table
SELECT e.emp_no, 
    e.first_name, 
    e.last_name, 
    t.title, 
    t.from_date, 
    t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- Use Dictinct with Order by to remove duplicate rows and save into a new table
SELECT DISTINCT ON (emp_no) 
	emp_no, 
	first_name, 
	last_name, 
	title, 
	from_date, 
	to_date
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC, 
	to_date DESC;

-- Select the number of retiring employees by title and save into a new table
SELECT COUNT(title),
	title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

-- Select employees eligible for the mentorship program
SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees AS e
INNER JOIN dept_emp AS de
	ON e.emp_no = de.emp_no
INNER JOIN titles AS t
	ON e.emp_no = t.emp_no
WHERE de.to_date = '9999-01-01'
	AND t.to_date = '9999-01-01'
	AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no;