# Pewlett-Hackard-Analysis

### Overview
The following is an analysis of eligble employee retirements. Eligibility was determined based on birth year and hire date. Subjects born between 1952 and 1952 and hired between 1985 and 1988 are projected to be eligible for retirement.

### Resources
- Data Source: Company employee data
- Software: PostgreSQL 11

### Database Diagram
![EmployeeDBD](https://github.com/arodriguez82/Pewlett-Hackard-Analysis/blob/master/EmployeeDB.png?raw=true)

### Challenge Queries

1. Number of titles retiring:

SELECT t.emp_no,  ei.first_name, ei.last_name, t.title, t.from_date, ei.salary
INTO titles_retiring
FROM titles AS t 
RIGHT JOIN emp_info AS ei
ON (t.emp_no = ei.emp_no);
![titles_retiring](https://github.com/arodriguez82/Pewlett-Hackard-Analysis/blob/master/titles_retiring.png?raw=true)
- This query created a table that combined a list of retirement eligible employees and their titles. 

2. Only The Most Recent Title:

SELECT emp_no, first_name, last_name, from_date, title  INTO mentor_list  FROM  (SELECT emp_no, first_name, last_name, from_date, title, ROW_NUMBER() OVER  (PARTITION BY (emp_no) ORDER BY from_date DESC) rn 	FROM titles_retiring) tmp WHERE rn = 1  ORDER BY from_date DESC;

![mentor_list](https://github.com/arodriguez82/Pewlett-Hackard-Analysis/blob/master/mentor_list.png?raw=true)
- This query and table retained only the most recent title held by employees eligible for retirement. There were 33,118 employees.



