--при обновлении информации об актерах, играющих в спектаклях, если на женскую роль назначают актера мужского пола,
--то к названию спектакля добавляется надпись "в традициях времен Шекспира"
USE master

IF object_id('tr1') IS NOT NULL 
DROP TRIGGER tr1
GO

CREATE TRIGGER tr1 
ON actor_character_information AFTER UPDATE
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


--триггер срабатывает, когда в спектакле на женскую роль поставлен мужчина
UPDATE actor_character_information
SET actor_id = 30
WHERE actor_character_information.character_id = 41
AND show_id in (28, 29, 30)

--триггер не срабатывает в других случаях
UPDATE actor_character_information
SET actor_id = (SELECT person_id 
                FROM person_general_information
				WHERE first_name  = 'Никита'
				AND last_name = 'Лучихин')
WHERE actor_character_information.character_id = (SELECT character_id
                                             FROM character
											 WHERE character_name = 'Фернандо Лопес')
AND show_id in (SELECT show_id 
               FROM show
			   JOIN performance
			   ON show.performance_id = performance.performance_id
			   AND performance_name = 'Юнона и Авось')

select performance_name from performance