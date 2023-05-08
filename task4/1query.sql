--Вывести имя актрисы, которая чаще всего играла роль 'Блондхен'.
SELECT TOP(1) COUNT (actor_character_information.character_id) as amount_of_roles, first_name, last_name
FROM sex 
JOIN person_general_information 
ON person_general_information.sex_id = sex.sex_id               
JOIN actor_character_information 
ON actor_character_information.actor_id = person_general_information.person_id
JOIN character
ON actor_character_information.character_id = character.character_id
WHERE sex.sex = 'Женский'
GROUP BY actor_character_information.character_id, character_name, first_name, last_name
HAVING character_name = 'Блондхен'
ORDER BY amount_of_roles DESC
