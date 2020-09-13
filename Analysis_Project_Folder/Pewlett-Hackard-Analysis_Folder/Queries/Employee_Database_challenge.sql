SELECT e.emp_no,
    e.first_name,
e.last_name,
    ti.title,
   	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles


--number employees by recent title
SELECT COUNT(*), title 
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT DESC;




-- Deliverable 2

DROP TABLE mentorship_eligibilty

SELECT DISTINCT ON (e.emp_no)  e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
ti.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

SELECT * FROM mentorship_eligibilty

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) *
INTO unique_titles
FROM mentorship_eligibilty
ORDER BY emp_no;


-- -- -- -- -- -- 
SELECT DISTINCT ON (emp_no) emp_no,
title,
from_date,
to_date
INTO total_employees
FROM titles
ORDER BY emp_no, to_date DESC;




--number employees by recent title
SELECT COUNT(*), title 
INTO all_titles
FROM total_employees
GROUP BY title
ORDER BY COUNT DESC;

SELECT ae.title AS unique_titles, 
rt.count AS retire_count, 
ae.count AS all_count,
100.0*rt.count/ae.count AS Percent_retiring
INTO percent_retiring
FROM all_titles AS ae
INNER JOIN unique_titles AS rt
ON (ae.title = rt.title)
GROUP BY ae.count,ae.title
ORDER BY ae.count;

