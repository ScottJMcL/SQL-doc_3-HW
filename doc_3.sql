---------------------------------------------------------------------
-- 1. List all customers who live in Texas (use JOINs):  5  ---------
---------------------------------------------------------------------

select count(last_name)
from customer
inner join address
on customer.address_id = address.address_id 
where address.district = 'Texas';

---------------------------------------------------------------------
-- 2. Get all payments above $6.99 with the Customer's Full Name  ---
---------------------------------------------------------------------

select payment.payment_id, customer.first_name, customer.last_name, payment.amount 
from payment
inner join customer
on payment.customer_id = customer.customer_id
where payment.amount > 6.99;

---------------------------------------------------------------------
-- 3. Show all customers names who have made payments over $175(use subqueries)
---------------------------------------------------------------------

select first_name, last_name
from customer
where customer_id in (
	select customer_id
	from payment
	where amount > 175
)
group by first_name, last_name;

---------------------------------------------------------------------
-- 4. List all customers that live in Nepal (use the city table) ----
---------------------------------------------------------------------

select first_name, last_name
from customer
where address_id in (
	select address_id
	from address
	where city_id in(
		select city_id
		from city
		where country_id in (
			select country_id
			from country
			where country = 'Nepal'
		)
	)
);

-- was getting wrong answer: traced it down as below.
select * from customer where last_name = 'Cooper' -- address_id = 66
select * from address where address_id = 66 -- city_id = 441
select * from city where city_id = 441 -- country_id = 103
select * from country where country_id = 103 -- United States

-- individual querries working from inside out
select * from customer
where address_id = 326; -- Kevin Schuler = customer_id 321

select * from address
where city_id = 81; -- 470 Boksburg Street = address_id 326

select * from city
where country_id = 66; -- BIRGUNJ = city_id 81

select * from country
where country = 'Nepal'; -- NEPAL = country_id 66


---------------------------------------------------------------------
-- 5. Which staff member had the most transactions?  Jon Stephens ---
---------------------------------------------------------------------

select * from staff
select * from payment

select count(payment.payment_id), staff.first_name, staff.last_name
from payment
inner join staff
on payment.staff_id = staff.staff_id
group by staff.first_name, staff.last_name
order by count(payment.payment_id) DESC

---------------------------------------------------------------------
-- 6. How many movies of each rating are there?  --------------------
---------------------------------------------------------------------
-- I don't see any way to use JOINs or Subquerries.
select rating, count(title)
from film
group by rating
order by rating ASC

---------------------------------------------------------------------
-- 7.Show all customers who have made a single payment above $6.99 --
---------------------------------------------------------------------

select first_name, last_name
from customer
where customer_id in (
	select customer_id
	from payment
	where amount > 6.99
	group by customer_id having count(payment.amount) < 2
);

-- split querries up
select customer_id, count(amount)
from payment
where amount > 6.99
group by customer_id


select * from customer
where customer_id = 343 or customer_id = 467 or customer_id = 567;

---------------------------------------------------------------------
-- 8. How many free rentals did our stores give away? ---------------
---------------------------------------------------------------------
-- zero
select count(payment_id) from payment
where amount between -1 and 1;