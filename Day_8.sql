-- 1) CASE WHEN
-- cú pháp
SELECT 
CASE
 WHEN codition1 THEN result1
 WHEN codition2 THEN result2
 ..
 ELSE resultn
FROM table_nm

/* Hãy phân loại các bộ phim theo thời lượng short-medium-long
cụ thể:
- short: <60 phút
- medium: 60-120 phút
- long: >120 phút
*/
select
case
   when length<60 then 'short'
   when length between 60 and 120 then 'medium'
   -- when length>120 then 'long'
   else 'long'
end category,
count(*) as so_luong
from film
group by category

/* bộ film có tag là 1 nếu trường hợp là G hoặc PG
tag là 0 trong các trường hợp còn lại*/

select FILM_ID,
case
  when rating in ('G','PG') then 1
  else 0
end TAG
from film

-- challenge 1
/*Bạn cần tìm hiểu xem công ty đã bán bao nhiêu vé trong các danh mục sau
•  Low price ticket: total_amount < 20,000
•  Mid price ticket: total_amount between 20,000 and 150,000
•  High price ticket: total_amount >= 150,000*/
select
CASE 
   when amount<20000 then 'Low price ticket'
   when amount between 20000 and 150000 then 'Mid price ticket'
   else 'High price ticket'
 end as category,
 count(*) as so_luong
FROM bookings.ticket_flights
group by category
-- challenge 2
/*Bạn cần biết có bao nhiêu chuyến bay đã khởi hành vào các mùa sau:

Mùa xuân: Tháng 2,3,4
Mùa hè: Tháng 5,6,7
Mùa thu: Tháng 8,9,10
Mùa đông: 11,12,1
*/
select
CASE
  when extract(month from scheduled_departure) in(2,3,4) then 'mua_xuan'
  when extract(month from scheduled_departure) in(5,6,7) then 'mua_he'
  when extract(month from scheduled_departure) in(8,9,10) then 'mua_thu'
  else 'mua_dong'
 end season,
 count(*) as so_luong
from flights
group by season
--challenge 3
/*Bạn muốn tạo danh sách phim phân cấp độ theo cách sau:
1. Xếp hạng là 'PG' hoặc 'PG-13' hoặc thời lượng hơn 210 phút: 'Great rating or long (tier 1)
2. Mô tả chứa 'Drama' và thời lượng hơn 90 phút: 
Long drama (tier 2)'
3. Mô tả có chứa 'Drama' và thời lượng không quá 90 phút: 
'Shcity drama (tier 3)
4. Giá thuê thấp hơn $1: 'Very cheap (tier 4)'

Nếu một bộ phim có thể thuộc nhiều danh mục, nó sẽ được chỉ định ở cấp cao hơn. Làm cách nào để bạn có thể chỉ lọc những phim xuất hiện ở một trong 4 cấp độ này?
*/
select film_id,
case
   when rating in ('PG', 'PG-13') OR length>210 then 'Great rating or long (tier 1)'
   when description like '%Drama%' and length>90 then 'Long drama (tier 2)'
   when description like '%Drama%' and length<=90 then 'Shcity drama (tier 3)'
   when rental_rate<1 then 'Very cheap (tier 4)'
end tier
from film
where
case
   when rating in ('PG', 'PG-13') OR length>210 then 'Great rating or long (tier 1)'
   when description like '%Drama%' and length>90 then 'Long drama (tier 2)'
   when description like '%Drama%' and length<=90 then 'Shcity drama (tier 3)'
   when rental_rate<1 then 'Very cheap (tier 4)'
end is not NULL
  --2) PIVOT BY CASE-WHEN
/*Tính tổng số tiền theo từng loại hoá đơn high-medium-low
- high: amount>10
- medium : 5<=amount<=10
- low: amount<5*/
select customer_id,
SUM(case
   when amount>10 then amount
   else 0
end) as high,
SUM(case
   when amount between 5 and 10 then amount
   else 0
end) as medium,
SUM(case
   when amount < 5 then amount
   else 0
end) as low
from payment
GROUP BY customer_id
order by customer_id

