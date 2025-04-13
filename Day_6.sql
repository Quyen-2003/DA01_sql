-- 1) LOWER(), UPPER(), LENGTH()
SELECT 
email,
LOWER(email) AS lower_email, -- ký tự thường
UPPER(email) AS upper_email,-- ký tự hoa
LENGTH(email) AS length_email-- số lượng ký tự
FROM customer
-- challenge: Liệt kê các KH có họ hoặc tên nhiều hơn 10 ký tự, kết qủa trả ra chữ thường
SELECT
LOWER(first_name) AS TEN_KH,
LOWER(last_name) AS HO_KH
FROM customer
WHERE length(first_name)>10
OR ength(last_name)>10
-- 2) LEFT(), RIGHT()
SELECT
  LEFT(first_name,3)  -- hiển thị 3 ký tự đầu tiên của first_name
  RIGHT(first_name,3)  -- hiển thị 3 ký tự cuối cùng của first_name
  RIGHT(LEFT(first_name,3),2) -- lấy 2 ký tự ở giữa. VD: MARY => _AR_  
FROM customer 
/*challenge: Trích xuất 5 ký tự cuối cùng của địa chỉ email.
Làm thế nào để chỉ trích xuất dấu "." ở địa chỉ email*/
SELECT
RIGHT(LEFT((email)) AS TEN_KH,
FROM customer
-- 3) CONCATNATE (NỐI CHUỖI)
SELECT customer_id,
first_name ,
last_name,
first_name|| ' ' ||last_name AS full_name -- || dùng để nối chuỗi hoặc dùng CONCAT
CONCAT(first_name,' ', last_name) AS full_name
FROM customer
/*Giả sử bạn chỉ có địa chỉ email và họ của khách hàng.
Bạn cần trích xuất tên từ địa chỉ email và nối nó với họ. 
Kết quả phải ở dạng: "Họ, Tên"*/
SELECT email,
LEFT(email,3) ||'***'||RIGHT(email,20) as new_email
FROM customer
--4) REPLACE(): thay đổi ký tự thành ký tự mới
SELECT email,
REPLACE(email,'.org','.com') -- thay ký .org thành .com
FROM customer
--5) POSITION(): Tìm vị trí của ký tự trong chuỗi
SELECT
email,
POSITION ('@' IN email) -- tìm vị trí của @ trong email
LEFT(email, position('@' in email) - 1) -- tách phần thông tin họ & tên trong trường email
FROM customer 
-- 6) SUBSTRING()
-- lấy ra ký tự từ 2 đến 4 của first_name trong bảng customer
SELECT first_name,
SUBSTRING(first_name FROM 2 FOR 3)
FROM customer
-- lấy thông tin họ KH từ email
 SELECT email,
 SUBSTRING(email FROM POSITION ( '.' IN email) +1 FOR POSITION ( '@' IN email) - POSITION ( '.' IN email)-1) as HO_KH
FROM customer 
--challenge: trích xuất tên từ email và nối với họ. Kết quả phải ở dạng 'Họ, tên'
select email, 
substring(email from 1 for position('.'in email)-1) as first_name,
substring(email from 1 for position('.'in email)-1) || ' , ' || last_name as ho_ten 
FROM CUSTOMER
-- 7) EXTRACT() dùng để trích xuất thông tin Năm, tháng, ngày, giờ.. của 1 date/datetime kết quả trả ra dưới dạng number
SELECT * FROM rental
WHERE EXTRACT( 'year' FROM rental_date) =2020
-- năm 2020 có bao nhiêu đơn hàng cho thuê trong mỗi tháng
select extract(month from rental_date), count(*) from rental
where extract(year from rental_date)=2020
group by extract(month from rental_date)
/* challenge - tháng nào có tổng số tiền thanh toán cao nhất?
- ngày nào trong tuần có tổng số tiền thanh toán cao nhất? (0 là chủ nhật)
- số tiền cao nhất mà một khách hàng đã chi tiêu trong một tuần là bao nhiêu?*/
select extract(DOW/MONTH from payment_date) as day_of_week, 
SUM(amount) as total_amount
from payment 
group by extract(DOW/MONTH from payment_date)
order by sum(amount) desc
  
select customer_id, extract(week from payment_date),
sum(amount) as total_amount
from payment 
group by customer_id, extract(week from payment_date)
order by sum(amount) desc
-- 8) TO_CHAR () lấy thông tin datetime theo định dạng momg muốn(format) 
SELECT TO_CHAR(payment_date, 'year') 
FROM payment
-- 9) Intervals & Timestamp
SELECT current_date,--ngày hiện tại
current_timestamp, -- ngày giờ hiện tại
return_date - rental_date AS rental_time -- là 1 interval

select current_date, current_timestamp, 
customer_id,
rental_date,
return_date,
extract (day from return_date - rental_date)*24 + extract (hour from return_date - rental_date) || ' giờ'
from rental
  
/* -ds tất cả thời gian đã thuê của khách hàng với customer_id 35.
-Khách hàng nào có thời gian thuê trung bình dài nhất*/
select customer_id, rental_date, return_date,
return_date-rental_date as rental_time
from rental
where customer_id = 35

select customer_id,
AVG(return_date-rental_date) as avg_rental_time
from rental
group by customer_id
order by customer_id desc
