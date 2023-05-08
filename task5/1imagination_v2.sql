--название постановки, ее режиссеры и актеры
USE master;

IF OBJECT_ID('T1') IS NOT NULL 
DROP VIEW T1
GO 
 
CREATE VIEW T1 AS 
SELECT DISTINCT tmp1.Name, tmp1.directors, actors
FROM 
(SELECT STRING_AGG(CONCAT (first_name,' ', last_name), ', ') AS directors, performance.performance_id, performance.performance_name AS Name
			FROM person_general_information 
			INNER JOIN creators_performance 
			ON person_id = creator_id
			INNER JOIN performance 
			ON creators_performance.performance_id=performance.performance_id
			GROUP BY performance.performance_id, performance.performance_name) tmp1,

(SELECT DISTINCT STRING_AGG(CONCAT (first_name,' ', last_name), ', ') AS actors, performance.performance_id, performance.performance_name AS Name
        FROM person_general_information 
		INNER JOIN actor_character_information 
		ON person_general_information.person_id = actor_character_information.actor_id
		INNER JOIN character
		ON actor_character_information.character_id = character.character_id
		INNER JOIN performance
		ON character.performance_id = performance.performance_id
		GROUP BY performance.performance_id, performance.performance_name) tmp2
WHERE tmp1.performance_id = tmp2.performance_id
GO

SELECT * 
FROM T1
ORDER BY Name
