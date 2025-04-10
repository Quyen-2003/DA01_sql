--Ex1: https://www.hackerrank.com/challenges/weather-observation-station-3/problem?isFullScreen=true
SELECT DISTINCT city from station where ID%2=0
--Ex2: https://www.hackerrank.com/challenges/weather-observation-station-4/problem
SELECT COUNT(CITY) - COUNT(DISTINCT CITY) FROM STATION
--Ex4: https://datalemur.com/questions/alibaba-compressed-mean
SELECT ROUND(CAST(SUM(item_count*order_occurrences)/SUM(order_occurrences) AS DECIMAL),1) AS mean FROM items_per_order;
--Ex5:https://datalemur.com/questions/matching-skills
SELECT candidate_id FROM candidates where skill in('Python','Tableau','PostgreSQL') group by candidate_id having count(skill)=3 ORDER BY candidate_id;
--Ex6:https://datalemur.com/questions/sql-average-post-hiatus-1
SELECT user_id, 
DATE(MAX(post_date))-DATE(MIN(post_date)) as days_between
FROM posts
WHERE post_date >='2021-01-01'and post_date <'2022-01-01'
GROUP BY user_id
having count(post_id)>=2;
--Ex7: https://datalemur.com/questions/cards-issued-difference
SELECT card_name, max(issued_amount)-min(issued_amount) AS difference FROM monthly_cards_issued GROUP BY card_name ORDER BY max(issued_amount)-min(issued_amount) DESC;
--Ex8: https://datalemur.com/questions/non-profitable-drugs
SELECT manufacturer, 
count(drug) as drug_count,
ABS(SUM(cogs - total_sales)) as total_loss
FROM pharmacy_sales
where total_sales<cogs
GROUP BY manufacturer
ORDER BY SUM(cogs-total_sales) DESC;
--Ex9: https://leetcode.com/problems/not-boring-movies/description/
select*from Cinema where ID%2 <>0 AND description <> 'boring' ORDER BY rating DESC
--Ex10: https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/
select teacher_id, count(distinct subject_id) as cnt from Teacher group by teacher_id
--Ex11: https://leetcode.com/problems/find-followers-count/description/
select user_id ,count(follower_id) as followers_count from Followers group by user_id order by user_id 
--Ex12: https://leetcode.com/problems/classes-more-than-5-students/description/
select class from Courses group by class having count(student) >=5
