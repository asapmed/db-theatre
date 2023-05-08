--список актеров, которые принимают участие в 3-х и более показах постановок
WITH shows_amount (actor_id, amount_of_shows)
AS(
     SELECT actor_id, COUNT (actor_character_information.show_id) as amount_of_shows
     FROM actor_character_information
     GROUP BY actor_id
   )

SELECT first_name, last_name, amount_of_shows
FROM shows_amount JOIN person_general_information
ON actor_id = person_id
WHERE amount_of_shows >=3
ORDER BY amount_of_shows DESC
