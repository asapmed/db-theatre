--удалить выражение (в традициях времен Шекспира), если не всех женщин играют мужчины

USE master 

IF object_id('tr3') IS NOT NULL 
DROP TRIGGER tr3
GO

CREATE TRIGGER tr3
ON actor_character_information AFTER UPDATE
AS
IF EXISTS
	(SELECT performance.performance_id
	FROM performance
	JOIN character
	ON performance.performance_id = character.performance_id
	JOIN actor_character_information
	ON character.character_id = actor_character_information.character_id
	JOIN inserted
	ON inserted.actor_id = actor_character_information.actor_id
	JOIN person_general_information
	ON actor_character_information.actor_id = person_id
	JOIN sex
	ON character.sex_id = sex.sex_id
	WHERE ((character.sex_id = person_general_information.sex_id) 
	OR (character.sex_id <> person_general_information.sex_id AND sex = 'мужской'))
	AND performance_name LIKE '%(в традициях времен Шекспира)%')
BEGIN
UPDATE performance
SET performance_name = SUBSTRING(performance_name, 1, (SELECT LEN((SELECT performance_name from performance where performance_id = 10)) - 30))
WHERE performance_id in (SELECT performance.performance_id
                        FROM performance
						JOIN show
						ON performance.performance_id = show.performance_id
						JOIN actor_character_information
						ON show.show_id = actor_character_information.show_id
						JOIN inserted
						ON inserted.actor_id = actor_character_information.actor_id)
END

--триггер срабатывает, когда в спектакле на женскую роль поставлен мужчина
UPDATE actor_character_information
SET actor_id = 57
WHERE actor_character_information.character_id = 41
AND show_id in (28, 29, 30)

select performance_name from performance