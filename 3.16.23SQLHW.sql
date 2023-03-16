--1. List all customers who live in Texas (use JOINs)
SELECT customer.first_name, customer.last_name
FROM customer
JOIN address 
ON customer.address_id = address.address_id 
WHERE address.district = 'Texas';

--2. List all payments of more than $7.00 with the customer’s first and last name
SELECT c.first_name, c.last_name, payment.amount 
FROM customer c
JOIN payment
ON payment.customer_id = c.customer_id
WHERE amount > 7;

--3. Show all customer names who have made over $175 in payments (use
--subqueries)


SELECT *
FROM customer
WHERE customer_id in (
	SELECT customer_id 
	FROM payment
	GROUP BY customer_id
	HAVING sum(amount) > 175
	);


--4. List all customers that live in Argentina (use the city table)

SELECT customer.first_name, customer.last_name, address.district, city.city, country.country 
FROM customer
JOIN address 
ON customer.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
JOIN country 
ON city.country_id = country.country_id 
WHERE country.country = 'Argentina';

	
	
--5. Show all the film categories with their count in descending order

SELECT category.name, count(film_category.film_id)
FROM category
JOIN film_category
ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY count(film_category.film_id) DESC;

--6. What film had the most actors in it (show film info)?
SELECT *
FROM film 
WHERE film_id IN (
	SELECT film_id
	FROM film_actor
	GROUP BY film_id
	ORDER BY count(actor_id) DESC
	LIMIT 1
);

--7. Which actor has been in the least movies?

SELECT *
FROM actor 
WHERE actor_id IN (
	SELECT actor_id
	FROM film_actor
	GROUP BY actor_id
	ORDER BY count(film_id) ASC
	LIMIT 1
	);

--8. Which country has the most cities?

SELECT *
FROM country
WHERE country_id IN (
SELECT country_id
FROM city
GROUP BY country_id
ORDER BY count(city) DESC
LIMIT 1);

--9. List the actors who have been in between 20 and 25 films.
SELECT *
FROM actor 
WHERE actor_id IN (
	SELECT actor_id
	FROM film_actor
	GROUP BY actor_id
	having count(film_id) BETWEEN 20 AND 25
	);

