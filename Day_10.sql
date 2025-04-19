-- 1/ INNER JOIN 
-- CÚ PHÁP (table1 INNER JOIN table 2)
SELECT t1.*,t2.*
from table1 as t1
inner join table2 as t2
on t1.key1=t2.key2;

select a.payment_id, a.customer_id, b.first_name, b.last_name
from payment as a
inner join customer as b
on a.customer_id=b.customer_id;

-- có bao nhiêu người ngồi business, economy, comfort 
-- expected output: fare_conditions col and count col
select b.fare_conditions,
count (a.flight_id) as so_luong
from boarding_passes as a
inner join seats as b
on a.seat_no=b.seat_no
group by b.fare_conditions
  
--2/ LEFT JOIN/RIGHT JOIN 
-- CÚ PHÁP (table1 LEFT JOIN table2)
select t1.*,t2.*
from table1 as t1
left/right join table2 as t2
on t1.key1=t2.key2;

-- tìm thông tin các chuyến bay của từng máy bay
-- b1: xác định bảng
-- b2: xác định key join >> aircraft_code
-- b3: chọn phương thức JOIN
select a.aircraft_code, b.flight_no
from bookings.aircrafts_data AS a
LEFT JOIN bookings.flights as b
on a.aircraft_code=b.aircraft_code
where b.flight_no is null;

/*Tìm hiểu ghế nào nào được chọn thường xuyên nhất.
Đảm bảo tất cả các ghế đều được liệt kê ngay cả khi chúng chưa bao giờ được đặt.
Có chỗ ngồi nào chưa bao giờ được đặt không?
Chỉ ra hàng ghế nào được đặt thường xuyên nhất (A,B,C...)*/
select a.seat_no,
count (flight_id) as so_luong
from seats as a
left join boarding_passes as b
on a.seat_no=b.seat_no
group by a.seat_no
order by count (flight_id)

select a.seat_no
from seats as a
left join boarding_passes as b
on a.seat_no=b.seat_no
where b.seat_no is null

select right(a.seat_no,1) as line,
count (flight_id) as so_luong
from seats as a
left join boarding_passes as b
on a.seat_no=b.seat_no
group by right(a.seat_no,1)
order by count (flight_id) desc

-- 3/ FULL JOIN
-- CÚ PHÁP (table1 FULL JOIN table 2)
select t1.*,t2.*
from table1 as t1
FULL JOIN table2 as t2
on t1.key1=t2.key2;


select count(*) 
from bookings.boarding_passes as a
full join bookings.tickets as b
on a.ticket_no=b.ticket_no
where a.ticket_no is NULL

-- 4/JOIN MULTIPLE CONDITIONS
-- Tính giá trung bình của từng số ghế máy bay
-- b1: xdinh output, input
-- số ghế; giá trung bình
-- key: ticket_no, flight_id

select a.seat_no, avg(b.amount) as avg_amount 
from bookings.boarding_passes as a
left join bookings.ticket_flights as b
on a.ticket_no=b.ticket_no
and a.flight_id=b.flight_id
group by a.seat_no
order by avg(b.amount) desc

-- 5/JOIN MULTIPLE TABLES
-- số vé, tên kh, giá vé, giờ bay, giờ kết thúc
select a.ticket_no, a.passenger_name, b.amount, c.scheduled_departure, c.scheduled_arrival
from tickets as a
INNER JOIN bookings.ticket_flights as b
on a.ticket_no=b.ticket_no
inner join bookings.flights as c
on b.flight_id=c.flight_id
  
/*challenge: những khách hàng nào đến từ Brazil?
Viết truy vấn để lấy first_name, last_name, email
và quốc gia từ tất cả khách hàng từ brazil.*/
select a.first_name, a.last_name, a.email,
d.country
from customer as a
join public.address as b on a. address_id=b.address_id
join public.city as c on b.city_id=c.city_id
join public.country as d on c.country_id=d.country_id
where d.country='Brazil'

-- 6/SELF JOIN
CREATE TABLE employee (
	employee_id INT,
	name VARCHAR (50),
	manager_id INT
);

INSERT INTO employee 
VALUES
	(1, 'Liam Smith', NULL),
	(2, 'Oliver Brown', 1),
	(3, 'Elijah Jones', 1),
	(4, 'William Miller', 1),
	(5, 'James Davis', 2),
	(6, 'Olivia Hernandez', 2),
	(7, 'Emma Lopez', 2),
	(8, 'Sophia Andersen', 2),
	(9, 'Mia Lee', 3),
	(10, 'Ava Robinson', 3);
	
select emp. employee_id, emp.name as emp_name, emp.manager_id, mng.name as mng_name
from employee as emp
LEFT join employee as mng on emp.manager_id=mng.employee_id

/*challenge: tìm những bộ phim có cùng thời lượng phim
output: title1, title2, length*/
select f1.title as title1, f2.title as title2, f1.length
from film as f1
join film as f2
on f1.length=f2.length
where f1.title!=f2.title

-- 7/UNION
-- UNION
select col1,col2,col3,... coln
from table1
UNION/UNION ALL
select col1, col2, col3,... coln
from table2
UNION/UNION ALL
select col1, col2, col3,... coln
from table3

select first_name, 'actor' as source from actor
UNION all
select first_name, 'customer' as source from customer
order by first_name
