--название постановки, ее режиссеры и актеры
USE master;

IF OBJECT_ID('T1') IS NOT NULL 
DROP VIEW T1
GO 
 
CREATE VIEW T1 AS 
SELECT DISTINCT tmp1.performance_id, tmp1.Name, tmp1.directors, STRING_AGG(actors, ', ') as actors
FROM 
(SELECT STRING_AGG(CONCAT (first_name,' ', last_name), ', ') AS directors, performance.performance_id, performance.performance_name AS Name
			FROM person_general_information 
			INNER JOIN creators_performance 
			ON person_id = creator_id
			INNER JOIN performance 
			ON creators_performance.performance_id=performance.performance_id
			GROUP BY performance.performance_id, performance.performance_name) tmp1,

(SELECT DISTINCT CONCAT (first_name, ' ', last_name) AS actors, performance.performance_id, performance.performance_name AS Name
FROM person_general_information
JOIN actor_character_information
ON person_id = actor_id
JOIN show
ON actor_character_information.show_id = show.show_id
JOIN performance
ON show.performance_id = performance.performance_id
GROUP BY actor_character_information.show_id, first_name, last_name, performance.performance_id, performance.performance_name) tmp2
WHERE tmp1.performance_id = tmp2.performance_id
GROUP BY tmp1.performance_id, tmp1.Name, tmp1.directors
GO

SELECT * 
FROM T1
ORDER BY performance_id