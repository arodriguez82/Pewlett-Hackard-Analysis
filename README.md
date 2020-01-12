# Pewlett-Hackard-Analysis

## Overview
The following is an analysis of eligble employee retirements. Eligibility was determined based on birth year and hire date. Subjects born between 1952 and 1952 and hired between 1985 and 1988 are projected to be eligible for retirement.

## Resources
- Data Source: Company employee data
- Software: PostgreSQL 11

## Database Diagram
![EmployeeDBD](https://github.com/arodriguez82/Pewlett-Hackard-Analysis/blob/master/EmployeeDB.png?raw=true)

## Challenge Queries

### 1. Number of titles retiring:

SELECT t.emp_no,  ei.first_name, ei.last_name, t.title, t.from_date, ei.salary
INTO titles_retiring
FROM titles AS t 
RIGHT JOIN emp_info AS ei
ON (t.emp_no = ei.emp_no);
![titles_retiring](https://github.com/arodriguez82/Pewlett-Hackard-Analysis/blob/master/titles_retiring.png?raw=true)
- This query created a table that combined a list of retirement eligible employees and their titles. (See: \Data\titles_retiring.csv)

### 2. Only The Most Recent Title:

SELECT emp_no, first_name, last_name, from_date, title  INTO mentor_list  FROM  (SELECT emp_no, first_name, last_name, from_date, title, ROW_NUMBER() OVER  (PARTITION BY (emp_no) ORDER BY from_date DESC) rn 	FROM titles_retiring) tmp WHERE rn = 1  ORDER BY from_date DESC;
![mentor_list](https://github.com/arodriguez82/Pewlett-Hackard-Analysis/blob/master/mentor_list.png?raw=true)
- This query and table retained only the most recent title held by employees eligible for retirement. There were 33,118 employees. (See: \Data\mentor_list.csv)

SELECT COUNT(emp_no), title INTO title_count  FROM mentor_list  GROUP BY title  ORDER BY title;
![title_count](https://github.com/arodriguez82/Pewlett-Hackard-Analysis/blob/master/title_count.png?raw=true)
- This table query and table collected the number of position titles of employees eligible to retire. (See: \Data\title_count.csv)

### 3.  Who's Ready for a Mentor?

SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date, e.birth_date   INTO mentor_ready FROM employees as e INNER JOIN titles as t  ON (e.emp_no = t.emp_no)  WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')  AND t.to_date = ('9999-01-01')  ORDER BY title;
![mentor_ready](https://github.com/arodriguez82/Pewlett-Hackard-Analysis/blob/master/mentor_ready.png?raw=true)
- This created a list of current employees born in the year 1965. (See: \Data\mentor_ready.csv) 
(Please Note: The challenge provided conflicting instructions for this part of the challenge and this is my best interpretation that would not be repeat information)
