SELECT c.customer_id,SUM(p.amount) sum
FROM customer c
JOIN payment p USING(customer_id)
GROUP BY customer_id
HAVING sum > 100;