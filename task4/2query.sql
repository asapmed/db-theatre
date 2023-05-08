--Подсчитать количество постановок для каждого режиссера
WITH directors(amount_of_performances, creator_id)
AS(
SELECT COUNT(creators_performance.performance_id) as amount_of_performances, creators_performance.creator_id
FROM person_general_information 
JOIN creators_performance
ON  creators_performance.creator_id = person_id
GROUP BY creators_performance.creator_id)

SELECT first_name, last_name, amount_of_performances
FROM directors
JOIN person_general_information
ON directors.creator_id = person_id