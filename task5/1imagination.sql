--спектакль, режиссер, актеры спектакля 
USE master;

IF OBJECT_ID('T1') IS NOT NULL 
DROP VIEW T1
GO 
 
CREATE VIEW T1 AS 
SELECT tmp1.Name, tmp1.[Director first name], tmp1.[Director last name], tmp2.[Actor first name], tmp2.[Actor last name]
	FROM 
	(SELECT DISTINCT performance.performance_name AS Name, person_general_information.first_name AS [Director first name], person_general_information.last_name AS [Director last name]
		FROM person_general_information 
		INNER JOIN creators_performance 
		ON person_id = creator_id 
		INNER JOIN performance
		ON creators_performance.performance_id = performance.performance_id) tmp1, 
	(SELECT DISTINCT performance.performance_name AS Name, person_general_information.first_name AS [Actor first name], person_general_information.last_name AS [Actor last name]
		FROM person_general_information 
		INNER JOIN actor_character_information 
		ON person_general_information.person_id = actor_character_information.actor_id
		INNER JOIN show
		ON actor_character_information.show_id = show.show_id
		INNER JOIN performance
		ON show.performance_id = performance.performance_id) tmp2
		WHERE tmp1.Name = tmp2.Name 		
GO

  
 SELECT Name, [Director first name], [Director last name], [Actor first name], [Actor last name]/*stuff((select ', ' + Actor from T1 for xml path('')), 1, 2, '')*/
 FROM T1
 GROUP BY Name, [Director first name], [Director last name], [Actor first name], [Actor last name]
 ORDER BY Name, [Director first name], [Director last name]
 GO