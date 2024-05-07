/*
 * How many female customers do we have from the state of Oregon(OR)
 * and New York (NY)
 * */ 
select count(*) from customers 
	where gender = 'F' 
	and (state = 'OR' or state = 'NY');
	
-- How many Customers are not of age 55
select count(*) from customers where not age = 55;

-- Who over the age 44 has an income of 100.000 or more?
select * from customers where age >= 44 and  income >= 100.000;

-- Who between the ages of 30 and 50 has an income of less than 50.000
select count(*) from customers 
where (age >=30 and age <= 50) 
and income <= 50000;

-- What is the averageincome between the ages of 20 and 50?
select avg(income) from customers
where age > 20 and age < 50;