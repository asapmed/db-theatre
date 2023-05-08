--вывести постановки в которых пол исполнителя не совпадал с полом актера
SELECT DISTINCT performance_name
FROM performance
JOIN character
ON character.performance_id = performance.performance_id
JOIN actor_character_information
ON actor_character_information.character_id = character.character_id
JOIN person_general_information
ON actor_character_information.actor_id = person_general_information.person_id
WHERE character.sex_id <> person_general_information.sex_id