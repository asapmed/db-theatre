--актеры, которые более 3-х раз принимали участие в постановке оперы
WITH opera_participants (amount_of_shows, actor_id)
AS(
SELECT COUNT (actor_character_information.show_id) as amount_of_shows,actor_id
FROM person_general_information 
JOIN actor_character_information
ON actor_character_information.show_id = person_id
JOIN show 
ON  actor_character_information.show_id = show.show_id
JOIN performance
ON show.performance_id = performance.performance_id
JOIN genres_performance 
ON genres_performance.performance_id = performance.performance_id
JOIN genres
ON genres_performance.genre_id = genres.genre_id
WHERE genre_name = 'опера'
GROUP BY actor_id)

SELECT  first_name, last_name, amount_of_shows
FROM opera_participants JOIN person_general_information 
ON actor_id = person_id
WHERE amount_of_shows >=3
ORDER BY amount_of_shows DESC 