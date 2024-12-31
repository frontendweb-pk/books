-- create a view that will display the actor and its all films
CREATE OR REPLACE VIEW actor_film AS
SELECT a.first_name, a.last_name, f.title from actor a
JOIN film_actor fa USING(actor_id)
JOIN film f USING(film_id)
ORDER BY a.first_name, a.last_name, f.title;