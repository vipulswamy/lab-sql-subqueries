USE SAKILA;

/*
1. How many copies of the film Hunchback Impossible exist in the inventory system?
*/
-- select * from Sakila.inventory;
-- select * from Sakila.film
-- where title in ("Hunchback Impossible");
SELECT count(title) as "total copies available"
FROM sakila.film as f
JOIN sakila.inventory as i
ON i.film_id = f.film_id
where title like ("Hunchback Impossible");

/*
2. List all films whose length is longer than the average of all the films.
*/
select avg(length) from sakila.film;
-- my attempt to make a subquery
select * from (
  select title, avg(length) as "average length of films" from sakila.film
  group by title
  having avg(length) > 115
  order by "average length of films"
) as sub1;

/*
3. Use subqueries to display all actors who appear in the film Alone Trip.
*/

-- select * from Sakila.actor; -- actor_id, firtsname,lastname
-- select * from Sakila.film;  -- film_id, title
-- select * from Sakila.film_actor; -- film_id,actor_id

select title, first_name, last_name from (
	select *
	from sakila.film as f
	JOIN sakila.film_actor as fa
	ON f.film_id = fa.film_id
	JOIN sakila.actor as a
	ON fa.actor_id = a.actor_id
) as sub1
where title like "Alone Trip";

-- SELECT CONCAT(FIRSTNAME, ' ', LASTNAME) AS 'CUSTOMER NAME' FROM customer;

/*
4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
   Identify all movies categorized as family films.
*/
-- normal query
select rating, title as "family movies" from Sakila.film
where rating like "PG";

-- sub query
select * from (select rating, title as "family movies" from Sakila.film
where rating like "PG")as sub2;

/* 
5. Get name and email from customers from Canada using subqueries. 
Do the same with joins. Note that to create a join, 
you will have to identify the correct tables with their primary keys and foreign keys, 
that will help you get the relevant information.
*/
-- select * from sakila.country; -- country_id 
-- select * from sakila.city; -- city_id, Country_id
-- select * from sakila.address; -- city_id, address_id
-- select * from sakila.customer; -- address_id, fistname, last name

select first_name as "customer name", email as "customer email", country from (
	select customer.first_name, customer.email,country.country
	from sakila.country as country
	INNER JOIN sakila.city as city
	ON  country.country_id = city.country_id
	INNER JOIN sakila.address as address
	ON city.city_id = address.city_id
	INNER JOIN sakila.customer as customer
	ON address.address_id = customer.address_id
-- where country = 'canada'
-- order by country
)as sub3
where country = 'canada'
order by country;-- order by country;

-- Example : https://www.navicat.com/en/company/aboutus/blog/1948-nested-joins-explained

/*
6. Which are films starred by the most prolific actor? 
Most prolific actor is defined as the actor that has acted in the most number of films. 
First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
*/
-- actor --> max number of films
-- select * from sakila.film_actor; -- film_id,actor_id
-- select * from sakila.actor; -- actor_id, first_name

select count(actor_id), first_name, last_name from(
	select a.actor_id, a.first_name, a.last_name 
	from sakila.film_actor as fa
	JOIN sakila.actor as a
	ON fa.actor_id = a.actor_id
) as subQ1;



/*
7. Films rented by most profitable customer. 
You can use the customer table and payment table to find the most profitable customer
 ie the customer that has made the largest sum of payments
*/

-- profitable customer is the one who largets sum of payments

select * from sakila.customer; -- customer_id, first_name
select * from sakila.payment;  -- customer_id, amount

select c.customer_id, c.amount
from sakila.customer as c
JOIN sakila.payment as p
ON c.customer_id = p.customer_id;
 




/*
Customers who spent more than the average payments.
*/
