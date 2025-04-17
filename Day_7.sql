--Ex1: https://www.hackerrank.com/challenges/more-than-75-marks/problem?isFullScreen=true
select name from STUDENTS where Marks>75 
order by right(name,3), ID
-- Ex2: https://leetcode.com/problems/fix-names-in-a-table/description/?envType=study-plan-v2&amp;envId=top-sql-50
select user_id , concat(UPPER(LEFT(name,1)), lower(right(name,length(name)-1))) as name 
from Users order by user_id

select user_id , concat(UPPER(LEFT(name,1)), lower(substring(name,2))) as name 
from Users order by user_id
-- Ex3: https://datalemur.com/questions/total-drugs-sales
SELECT manufacturer, concat('$',round(sum(total_sales)/1000000,0), ' million') as sales_mil
FROM pharmacy_sales
group by manufacturer
order by sum(total_sales) desc,  manufacturer
-- Ex4: https://datalemur.com/questions/sql-avg-review-ratings
SELECT extract(month from submit_date) as mth, 
product_id as product,
round(avg(stars),2) as avg_stars
 FROM reviews
group by extract(month from submit_date), product_id
order by extract(month from submit_date), product_id
-- Ex5: https://datalemur.com/questions/teams-power-users
SELECT sender_id, count(message_id) as message_count FROM messages
where to_char(sent_date,'mm-yyyy')='08-2022'
group by sender_id order by count(message_id) desc
limit 2
-- Ex6: https://leetcode.com/problems/invalid-tweets/submissions/1606737259/?envType=study-plan-v2&amp;envId=top-sql-50
select tweet_id from Tweets where length(content)>15
-- Ex7: 
-- Ex8: https://platform.stratascratch.com/coding/2151-number-of-hires-during-specific-time-period?code_type=1
select count(id) as number_of_employees_hired
from employees
where extract(month from joining_date) between 1 and 7
and extract(year from joining_date)=2022
-- Ex9: https://platform.stratascratch.com/coding/9829-positions-of-letter-a?code_type=1
select position ('a' in first_name)
from worker
where first_name='Amitah';
-- Ex10: https://platform.stratascratch.com/coding/10039-macedonian-vintages?code_type=1
select substring(title, length(winery)+2, 4) as the_vintage_years
from winemag_p2
where country = 'Macedonia'
