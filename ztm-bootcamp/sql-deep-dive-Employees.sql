-- Select
select * from employees where employees.emp_no = 10006;
select * from titles where emp_no = 10006;

-- Renaming Columns
select  emp_no as "Employee #", birth_date as "Birthday", first_name  as "First Name" from employees;

-- Concatenation
select concat(emp_no, ' is a ', title)  as "Employee Title" from titles; 
select emp_no, concat(first_name, ' ', last_name) as "Full Name" from employees;

/*
 * Functions
 * Aggregate functions
 */
select count(emp_no) from employees;

-- Get the highest salary available
select max(salary) from salaries;
-- Get the total amount of salaries paid
select sum(salary) from salaries;

/*
 * Filtering Data
 */
select * from employees where gender = 'F';
select * from employees e 
	where (e.first_name = 'Bezalel' and e.gender = 'F')
	or (e.first_name = 'Georgi' and e.gender = 'M');
