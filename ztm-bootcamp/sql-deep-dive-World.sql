/*
* DB: World
* Table: city
* Question: How many cities are in the district of Zuid-Holland, Noord-Brabant and Utrecht?
*/
select count(id) from city where district in ('Zuid-Holland', 'Noord-Brabant', 'Utretch');