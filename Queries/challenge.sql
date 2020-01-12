-- Challenge Part 1: Number of titles retiring
SELECT t.emp_no,
	ei.first_name,
	ei.last_name,
	t.title,
	t.from_date,
	ei.salary
INTO titles_retiring
FROM titles AS t
	RIGHT JOIN emp_info AS ei
	ON (t.emp_no = ei.emp_no);
	
-- Challenge Part 1: Most Recent Titles

-- This locates and gives count of duplicates based on first/last name 
SELECT first_name,
last_name,
COUNT (*)
FROM titles_retiring
GROUP BY first_name,
last_name
HAVING count(*) >1;

-- Part 1: Only Most Recent Titles a) Create mentor_list, remove duplicates, order by from date
SELECT emp_no, first_name, last_name, from_date, title 
INTO mentor_list
FROM
	(SELECT emp_no, first_name, last_name, from_date, title,
		ROW_NUMBER() OVER
(PARTITION BY (emp_no) ORDER BY from_date DESC) rn
	FROM titles_retiring
	) tmp WHERE rn = 1
ORDER BY from_date DESC;

-- Part 1: Only Most Recent Titles b) Frequency count of employee titles
SELECT COUNT(emp_no), title
INTO title_count
FROM mentor_list
GROUP BY title
ORDER BY title;

-- Part 1: Who's Ready for a Mentor?
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date,
	e.birth_date
INTO mentor_ready
FROM employees as e
	INNER JOIN titles as t
		ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND t.to_date = ('9999-01-01')
ORDER BY title;