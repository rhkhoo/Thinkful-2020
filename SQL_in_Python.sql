SELECT rating, COUNT (DISTINCT(film_id)) AS movie_count
FROM film
GROUP BY rating;

SELECT rating, ROUND(AVG(rental_duration), 2)  AS avg_rental_duration
FROM film
GROUP BY rating;

SELECT ROUND(AVG(length), 2)
FROM film;

SELECT ROUND(STDDEV(length), 2)
FROM film;