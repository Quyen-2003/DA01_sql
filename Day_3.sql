-- Ex1: Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.
select name from city where countrycode='USA' and population >120000
-- Ex2: Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
select*from city where countrycode = 'JPN' 
-- Ex3: Query a list of CITY and STATE from the STATION table.
select city, state from station
-- Ex4: Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
select distinct city from station where city like 'A%' or city like 'E%'OR city like 'I%' OR city like 'O%' OR city like 'U%'
-- Ex5: Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
select distinct city from station where city like '%A' or city like '%E'OR city like '%I' OR city like '%O' OR city like '%U'
-- Ex6: Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
select distinct city from station where city not like 'A%' and city not like 'E%' and city not like 'I%' and city not like 'O%' and city not like 'U%'
-- Ex7: Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.
select name from Employee ORDER BY name ASC
-- Ex8: Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than $2000 per month who have been employees for less than 10 months. Sort your result by ascending employee_id.
select name from Employee where salary > 2000 and months <10 ORDER BY employee_id ASC
-- Ex9: Write a solution to find the ids of products that are both low fat and recyclable. Return the result table in any order.
select product_id from products where low_fats ='Y' and recyclable = 'Y'
-- Ex10: Find the names of the customer that are not referred by the customer with id = 2.
select name from customer where referee_id != 2 OR referee_id IS NULL
-- Ex11: A country is big if: 
-- it has an area of at least three million (i.e., 3000000 km2), or it has a population of at least twenty-five million (i.e., 25000000). Write a solution to find the name, population, and area of the big countries.
select name, population, area from world where area >=3000000 or population >=25000000
-- Ex12: Write a solution to find all the authors that viewed at least one of their own articles. the table may have duplicate rows. Each row of this table indicates that some viewer viewed an article (written by some author) on some date. Note that equal author_id and viewer_id indicate the same person.
select distinct author_id as id from views where author_id=viewer_id order by author_id
-- Ex13: Write a query to determine which parts have begun the assembly process but are not yet finished.
SELECT part, assembly_step FROM parts_assembly where finish_date is NULL ;
-- Ex14: Find all Lyft drivers who earn either equal to or less than 30k USD or equal to or more than 70k USD. 
select * from lyft_drivers where yearly_salary <=30000 or yearly_salary >=70000;
-- Ex15: Find the advertising channel(s) where Uber spent more than 100k USD in 2019
select advertising_channel from uber_advertising where money_spent > 100000 and  year=2019;
