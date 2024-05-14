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


-- Timestamp exercises
/*
* DB: Employees
* Table: employees
* Question: Get me all the employees above 60, use the appropriate date functions
*/

SELECT first_name, AGE(birth_date) FROM employees
where extract (year from age(birth_date)) > 60;

-- Alternative
select count(birth_date) from employees
where birth_date < now() - interval '61 years';

/*
* DB: Employees
* Table: employees
* Question: How many employees where hired in February?
*/

SELECT count(emp_no) FROM employees where extract (month from hire_date ) = 2;

/*
* DB: Employees
* Table: employees
* Question: How many employees were born in november?
*/

SELECT count(emp_no) FROM employees where extract (month from birth_date) = 11;

/*
* DB: Employees
* Table: employees
* Question: Who is the oldest employee? (Use the analytical function MAX)
*/

SELECT max(Age(birth_date)) FROM employees;

-- Distinct keyword
select distinct salary from salaries;

/*
* DB: Employees
* Table: titles
* Question: What unique titles do we have?
*/

SELECT distinct title FROM titles;


/*
* DB: Employees
* Table: employees
* Question: How many unique birth dates are there?
*/

SELECT count(distinct birth_date) FROM employees;

-- ORDER BY keyword
select first_name, last_name from employees e
order by first_name desc, last_name desc;

select first_name from employees e 
order by length(first_name) desc;

/*
* DB: Employees
* Table: employees
* Question: Sort employees by first name ascending and last name descending
*/
select first_name, last_name from employees e 
order by e.first_name asc, last_name desc;

/*
* DB: Employees
* Table: employees
* Question: Sort employees by age
*/
select first_name, last_name, extract('year' from AGE(birth_date)) as "Age" from employees e 
order by birth_date;


/*
* DB: Employees
* Table: employees
* Question: Sort employees who's name starts with a "k" by hire_date
*/
select * from employees e 
where e.first_name ilike 'k%'
order by hire_date;

-- INNER JOIN
select e.emp_no, concat(e.first_name, ' ', e.last_name) as "Name", s.salary
from employees as e
inner join salaries as s on s.emp_no = e.emp_no
order by e.emp_no asc;

select e.emp_no,
concat(e.first_name, ' ', e.last_name) as "Name",
s.salary,
t.title,
t.from_date as "Promoted on"
from employees e
inner join salaries as s on e.emp_no = s.emp_no
inner join titles as t on t.emp_no  = e.emp_no
and t.from_date = (s.from_date + interval '2 days')
order by e.emp_no asc, s.from_date asc;

-- SELF JOIN
-- Join a table to itself
-- Outer Join
-- Left outer join
-- Right outer join

-- How many employees aren't managers?
select count(e.emp_no)  
from employees as e
left join dept_manager as dm on e.emp_no = dm.emp_no
where dm.emp_no is null;

-- You want to know every salary raise and also know which ones
-- were a promotion
select e.emp_no,
concat(e.first_name, ' ', e.last_name) as "Name",
s.salary,
coalesce (t.title, 'No title change') as "Title",
coalesce (t.from_date::text, '-') as "Promoted on"
from employees e
inner join salaries as s on e.emp_no = s.emp_no
left join titles as t on t.emp_no  = e.emp_no
and t.from_date = (s.from_date + interval '2 days')
order by e.emp_no asc, s.from_date asc;

-- Cross Join
-- Create a combination of every row

-- Full Join
-- Return results from both tables whether they match or not

/*
* DB: Employees
* Table: employees
* Question: Show me for each employee which department they work in
*/
select e.emp_no, concat(e.first_name, ' ', e.last_name) as "Full Name", d.dept_name 
from employees e 
inner join dept_emp de ON e.emp_no = de.emp_no
inner join departments d on d.dept_no = de.dept_no;

-- Using Keyword
select e.emp_no, e.first_name, de.dept_no 
from employees e 
inner join dept_emp de using(emp_no);
