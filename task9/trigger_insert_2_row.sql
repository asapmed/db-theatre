--при добавлении информации об актерах, играющих в спектаклях, если на женскую роль назначают актера мужского пола,
--то к названию спектакля добавляется надпись "в традициях времен Шекспира"
USE master

IF object_id('tr2') IS NOT NULL 
DROP TRIGGER tr2
GO

CREATE TRIGGER tr2
ON actor_character_information AFTER INSERT
AS
IF
     (

 (SELECT count(actor_character_information.actor_id)
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
     AND sex = 'женский') = (SELECT count(actor_character_information.character_id)
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
     AND sex = 'женский')))
BEGIN
UPDATE performance
SET performance_name = CONCAT(performance_name, ' (в традициях времен Шекспира)')
WHERE performance_id in (SELECT performance.performance_id
                        FROM performance
						JOIN show
						ON performance.performance_id = show.performance_id
						JOIN actor_character_information
						ON show.show_id = actor_character_information.show_id
						JOIN inserted
						ON inserted.actor_id = actor_character_information.actor_id)
AND performance_name NOT LIKE'%(в традициях времен Шекспира)%'
END

begin tran 
--триггер срабатывает, когда в спектакле на женскую роль поставлен мужчина
INSERT INTO actor_character_information VALUES(30, 42, 29)
INSERT INTO actor_character_information VALUES(30, 42, 30)

--триггер не срабатывает в других случаях
INSERT INTO actor_character_information VALUES (64, 2, 1)

select performance_name from performance
rollback