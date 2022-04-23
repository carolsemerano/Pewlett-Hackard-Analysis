-- Select employees eligible for the mentorship program with department and title info, and save into a new table
SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	d.dept_name,
	t.title
INTO mentorship_eligibilty_dept
FROM employees AS e
INNER JOIN dept_emp AS de
	ON e.emp_no = de.emp_no
INNER JOIN departments AS d
	ON d.dept_no = de.dept_no
INNER JOIN titles AS t
	ON e.emp_no = t.emp_no
WHERE de.to_date = '9999-01-01'
	AND t.to_date = '9999-01-01'
	AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no;

-- Count mentorship eligible by title 
SELECT COUNT(title), 
    title  
FROM mentorship_eligibilty_dept
GROUP BY title
ORDER BY 2, 1 DESC;

-- Count mentorship eligible by department 
SELECT COUNT(dept_name), 
    dept_name  
FROM mentorship_eligibilty_dept
GROUP BY dept_name
ORDER BY 2, 1 DESC;

-- Count retirement ready by department 
SELECT COUNT(*), 
    d.dept_name
FROM unique_titles AS ut 
INNER JOIN dept_emp AS de
    ON ut.emp_no = de.emp_no
INNER JOIN departments AS d
    ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01'
GROUP BY d.dept_name
ORDER BY 1 DESC;