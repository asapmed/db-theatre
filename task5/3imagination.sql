--персонаж, количество показов постановки, в которых он учавтувует, пол актера, исполняющего этого персонажа
USE master

IF OBJECT_ID('T3') IS NOT NULL 
DROP VIEW T3
GO 

CREATE VIEW T3 AS
SELECT tmp1.Name, tmp1.[amount of shows], tmp1.[actor gender]
FROM(
SELECT character.character_name AS Name, sex.sex AS [actor gender], performance.performance_name, COUNT(show.show_id) AS [amount of shows]
FROM character
JOIN actor_character_information
ON actor_character_information.character_id = character.character_id
JOIN show
ON actor_character_information.show_id = show.show_id
JOIN performance
ON performance.performance_id = show.performance_id
JOIN person_general_information
ON actor_id = person_id
JOIN sex
ON person_general_information.sex_id = sex.sex_id
WHERE DATEPART(year, show_date) > DATEPART(year, GETDATE()) - 5
GROUP BY character.character_name, sex, performance.performance_name) tmp1

GO 

SELECT * 
FROM T3
ORDER BY Name

--выбрать персонажа пол которого не совпадает с полом актера, исполняющего этого персонажа
SELECT Name
FROM T3
JOIN character
ON T3.Name = character.character_name
JOIN sex
ON character.sex_id = sex.sex_id
WHERE T3.[actor gender] <> sex

