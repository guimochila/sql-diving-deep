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

-- GROUP BY keyword
select dept_no, count(emp_no) 
from dept_emp
group by dept_no;

/*
*  How many people were hired on any given hire date?
*  Database: Employees
*  Table: Employees
*/

SELECT count(e.emp_no), e.hire_date as "amount"
FROM employees as e
group by hire_date 
order by "amount";

/*
*   Show me all the employees, hired after 1991 and count the amount of positions they've had
*  Database: Employees
*/

SELECT e.emp_no, count(t.title) as "Amount of title"
FROM employees as e
inner join titles t ON t.emp_no = e.emp_no 
where extract('year' from e.hire_date) > 1991
group by e.emp_no 
order by e.emp_no;


/*
*  Show me all the employees that work in the department development and the from and to date.
*  Database: Employees
*/

select e.emp_no, de.from_date , de.to_date 
FROM employees as e
inner join dept_emp de on de.emp_no = e.emp_no 
where de.dept_no = 'd005'
group by e.emp_no, de.from_date , de.to_date
order by e.emp_no, de.to_date;

-- HAVING keyword
-- Amount of employees per department
select d.dept_name , count(e.emp_no) as "# of employees"
from employees e 
inner join dept_emp de on de.emp_no = e.emp_no 
inner join departments d on d.dept_no = de.dept_no
where e.gender = 'F'
group by d.dept_name
having count(e.emp_no) > 25000;


/*
*  Show me all the employees, hired after 1991, that have had more than 2 titles
*  Database: Employees
*/
select e.emp_no , count(t.title) as "titles"
from employees e 
inner join titles t on t.emp_no = e.emp_no
where extract ('year' from e.hire_date) > 1991
group by e.emp_no
having count(t.title) > 2
order by e.emp_no;



/*
*  Show me all the employees that have had more than 15 salary changes that work in the department development
*  Database: Employees
*/
select e.emp_no , count(s.from_date)
from employees e 
inner join dept_emp de on de.emp_no  = e.emp_no 
inner join salaries s on s.emp_no  = e.emp_no 
where de.dept_no = 'd005'
group by e.emp_no
having count(s.from_date) > 15
order by e.emp_no;


/*
*  Show me all the employees that have worked for multiple departments
*  Database: Employees
*/
select e.emp_no, count(de.dept_no)  
from employees e
inner join dept_emp de on de.emp_no = e.emp_no
group by e.emp_no 
having count(de.dept_no) > 1;
