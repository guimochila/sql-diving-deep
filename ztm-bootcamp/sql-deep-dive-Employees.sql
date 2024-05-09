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

/*
 * IN Keyword
 */
select * from employees where emp_no in (10001, 10006, 11008);

/*
 * LIKE, ILIKE, CAST Keyword and PATTERN MATCH
 * */
select * from employees
where first_name like 'G%er';

select * from employees e 
where e.first_name ilike 'g%ger';

/*
* DB: Employees
* Table: employees
* Question: Find the age of all employees who's name starts with M.
*/
select emp_no, first_name, extract (year from age(birth_date)) as "age" from employees e 
where e.first_name like 'M%';

/*
* DB: Employees
* Table: employees
* Question: How many people's name start with A and end with R?
* Expected output: 1846
*/
select count(emp_no) from employees e where e.first_name ilike 'A%R';


