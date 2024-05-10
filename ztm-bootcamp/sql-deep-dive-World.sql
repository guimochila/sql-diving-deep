/*
* DB: World
* Table: city
* Question: How many cities are in the district of Zuid-Holland, Noord-Brabant and Utrecht?
*/
select count(id) from city where district in ('Zuid-Holland', 'Noord-Brabant', 'Utretch');

/*
* DB: World
* Table: country
* Question: Can I get a list of distinct life expectancy ages
* Make sure there are no nulls
*/

SELECT distinct c.lifeexpectancy FROM country c 
where c.lifeexpectancy is not null 
order by c.lifeexpectancy;