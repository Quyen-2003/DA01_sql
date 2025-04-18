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
-- Ex3: 
