--Театр, список актеров, играющих в нем, их количество достижения 

USE master

IF OBJECT_ID('T4') IS NOT NULL 
DROP VIEW T4
GO 

CREATE VIEW T4 AS 
SELECT tmp1.Name, tmp2.Actor, tmp2.Achievement   
	FROM 
	(SELECT theatre.theatre_name AS Name
		FROM theatre) tmp1, 
	(SELECT DISTINCT theatre.theatre_name AS Name, CONCAT(first_name, ' ', last_name) AS Actor, COUNT(achievement_actor.actor_id) AS Achievement 
		FROM person_general_information 
		INNER JOIN achievement_actor 
		ON person_id = actor_id
		INNER JOIN performance 
		ON achievement_actor.performance_id = performance.performance_id
		INNER JOIN theatre 
		ON performance.theatre_id = theatre.theatre_id
		GROUP BY theatre.theatre_name, performance.performance_id, performance.performance_name, first_name, last_name) tmp2
		WHERE tmp1.Name = tmp2.Name 	
GO


SELECT * 
 FROM T4
 ORDER BY Name, Actor, Achievement;
 GO


 -- Топ 5 театров, отранжированных по количеству достижений у актеров
 SELECT TOP 5 WITH TIES SUM(Achievement) AS SUMM, Name
 FROM T4
 GROUP BY Name
 ORDER BY SUMM DESC