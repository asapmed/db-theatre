DECLARE @actors INT
DECLARE @all_actors INT

SET @actors = (SELECT count(actor_character_information.actor_id)
     FROM actor_character_information
     JOIN person_general_information
     ON actor_character_information.actor_id = person_general_information.person_id
	 JOIN character
	 ON actor_character_information.character_id = character.character_id
     JOIN sex
     ON character.sex_id = sex.sex_id
	 JOIN performance
	 ON performance.performance_id = character.performance_id
     WHERE character.sex_id <> person_general_information.sex_id
     AND sex = 'женский')

SET @all_actors = (SELECT count(actor_character_information.character_id)
FROM actor_character_information
JOIN character
ON actor_character_information.character_id = character.character_id
JOIN performance
ON performance.performance_id = character.performance_id
JOIN sex
ON character.sex_id = sex.sex_id
WHERE sex = 'женский'
AND performance.performance_id in (SELECT distinct performance.performance_id
                                     FROM actor_character_information
     JOIN person_general_information
     ON actor_character_information.actor_id = person_general_information.person_id
	 JOIN character
	 ON actor_character_information.character_id = character.character_id
     JOIN sex
     ON character.sex_id = sex.sex_id
	 JOIN performance
	 ON performance.performance_id = character.performance_id
     WHERE character.sex_id <> person_general_information.sex_id
     AND sex = 'женский'))
                           
SELECT @all_actors
SELECT @actors


SELECT * from actor_character_information
WHERE show_id in (28,29,30)
     ORDER BY character_id, show_id

UPDATE actor_character_information
SET actor_id = 30
WHERE character_id in (41,42)
AND show_id in (28,29,30)

