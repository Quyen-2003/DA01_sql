-- Ex1: https://datalemur.com/questions/laptop-mobile-viewership
SELECT 
sum(CASE
  when device_type = 'laptop' then 1 else 0
end) as laptop_views,
sum(CASE
  when device_type in ('tablet','phone') then 1 else 0
end) as mobile_views
FROM viewership;
-- Ex2: https://leetcode.com/problems/triangle-judgement/description/?envType=study-plan-v2&envId=top-sql-50
-- x+y>z and z+x>y and y+z>x
select *,
case
  when x+y>z and z+x>y and z+y>x then 'Yes' else 'No'
end as triangle
from Triangle
-- Ex3: https://datalemur.com/questions/uncategorized-calls-percentage
  SELECT
round(100.0 * count(
CASE
  when call_category is null or call_category ='n/a' then 1
END)/count(*),1) as uncategorised_call_pct
from callers
-- Ex4: https://leetcode.com/problems/find-customer-referee/description/?envType=study-plan-v2&envId=top-sql-50
select name
from Customer
where referee_id !=2 or referee_id is null
-- Ex5: https://platform.stratascratch.com/coding/9881-make-a-report-showing-the-number-of-survivors-and-non-survivors-by-passenger-class?code_type=1
SELECT survived,
       sum(CASE
               WHEN pclass = 1 THEN 1
               ELSE 0
           END) AS first_class,
       sum(CASE
               WHEN pclass = 2 THEN 1
               ELSE 0
           END) AS second_class,
       sum(CASE
               WHEN pclass = 3 THEN 1
               ELSE 0
           END) AS third_class
FROM titanic
GROUP BY survived
