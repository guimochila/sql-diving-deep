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

-- Select people either under 30 or over 50 with an income above 50000
-- that are from either Japan or Australia
select * from customers 
where income > 50000
and (age < 30 or age >= 50)
and (country = 'Japan' or country = 'Australia');

-- What was our total sales in June of 2004 for orders over 100 dollars
select sum(totalamount) from orders
where (orders.orderdate >= '2004-06-01' and orderdate <= '2004-06-30')
and totalamount  > 100;

/*
 * Null Coalesce
 * Replace NULL keyword for operations
 * Returns the first NON-NULL value in a list
 * 
 * SELECT coalesce(
 * 	<column1>,
 * 	<column2>,
 * 	<column3>,
 * 	'Empty') as combined_columns
 * FROM table;
 */

-- Adjust the following query to display the null values as "No Address"
select coalesce(address2, 'No Address') as "Address" from customers; 

-- Fix the following query to apply proper 3VL
select * from customers where address2 is not null;
select coalesce (lastName, 'Empty'), * from customers where (age is null);

/*
 * BETWEEN AND
 * */
-- Who between the ages of 30 and 50 has an income less than 50 000?
-- (include 30 and 50 in the results)
select * from customers 
where income <= 50000
and age between 30 and 50;

-- What is the average income between the ages of 20 and 50? (Including 20 and 50)
select avg(income) from customers where age between 20 and 50; 