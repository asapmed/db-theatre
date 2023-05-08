--при добавлении информации об актерах, играющих в спектаклях, если на женскую роль назначают актера мужского пола,
--то к названию спектакля добавляется надпись "в традициях времен Шекспира"
USE master

IF object_id('tr2') IS NOT NULL 
DROP TRIGGER tr2
GO

CREATE TRIGGER tr2
ON actor_character_information AFTER INSERT
AS
IF EXISTS 
     (SELECT inserted.actor_id
     FROM inserted
     JOIN person_general_information
     ON inserted.actor_id = person_general_information.person_id
	 JOIN character
	 ON inserted.character_id = character.character_id
     JOIN sex
     ON character.sex_id = sex.sex_id
	 JOIN performance
	 ON performance.performance_id = character.performance_id
     WHERE character.sex_id <> person_general_information.sex_id
     AND sex = 'женский'
	 AND performance_name NOT LIKE'%(в традициях времен Шекспира)%')
IF EXISTS (SELECT performance.performance_id
                        FROM performance
						JOIN show
						ON performance.performance_id = show.performance_id
						JOIN actor_character_information
						ON show.show_id = actor_character_information.show_id
						JOIN inserted
						ON inserted.actor_id = actor_character_information.actor_id
						AND performance_name NOT LIKE'%(в традициях времен Шекспира)%')
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
END
go

IF object_id('tr4') IS NOT NULL 
DROP TRIGGER tr4
GO

CREATE TRIGGER tr4
ON actor_character_information AFTER INSERT
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
	OR (character.sex_id <> person_general_information.sex_id AND sex = 'мужской'
	AND performance_name LIKE '%(в традициях времен Шекспира)%')))
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
						ON inserted.actor_id = actor_character_information.actor_id
						AND performance_name LIKE '%(в традициях времен Шекспира)%')
END

		   

begin tran

--триггер срабатывает, когда в спектакле на женскую роль поставлен мужчина
INSERT INTO actor_character_information VALUES(30, 41, 28)

INSERT INTO actor_character_information VALUES (31, 2, 1), (31, 41, 28)

--триггер не срабатывает в других случаях
--INSERT INTO actor_character_information VALUES (64, 2, 1)

select performance_name from performance
where performance_id = 10;

rollback
