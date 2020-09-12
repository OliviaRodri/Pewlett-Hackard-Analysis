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

DROP TABLE mentorship_eligibilty;

-- Deliverable 2
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
ORDER BY e.emp_no;


SELECT * FROM mentorship_eligibilty

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) *
-- INTO unique_titles
FROM mentorship_eligibilty
ORDER BY emp_no;


SELECT * FROM titles

DROP TABLE e_ti_w_duplicates

DROP TABLE e_ti_unique

-- join empoyess and titles
SELECT e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
ti.title,
ti.to_date
INTO e_ti_w_duplicates
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

-- get rid of duplicates
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
birth_date,
title,
to_date
INTO e_ti_unique
FROM e_ti_w_duplicates
ORDER BY emp_no, to_date DESC;


-- join (empoyess and titles) and emp_dep
SELECT e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
e.title
INTO mentorship_eligibilty_duplicates
FROM e_ti_unique as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

-- ger rid of duplicates
SELECT (emp_no) emp_no,
first_name,
last_name,
birth_date,
from_date,
to_date,
title
--INTO mentorship_eligibilty_unique
FROM mentorship_eligibilty_duplicates
ORDER BY emp_no, to_date DESC;