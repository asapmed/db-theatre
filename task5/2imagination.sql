--пьеса, ее режиссер,количество ролей в этой пьесе, количество различных постановок

USE master

IF OBJECT_ID('T2') IS NOT NULL 
DROP VIEW T2
GO 


CREATE VIEW T2 AS
SELECT DISTINCT tmp1.first_name, tmp1.last_name, tmp1.performance_id, tmp1.name, tmp1.quantity1, tmp2.quantity2
	FROM 
		(SELECT first_name, last_name, performance.performance_id, performance.performance_name AS Name, COUNT(show.show_id) AS quantity1
			FROM person_general_information 
			INNER JOIN creators_performance 
			ON person_id = creator_id
			INNER JOIN performance 
			ON creators_performance.performance_id=performance.performance_id
			INNER JOIN show ON performance.performance_id = show.performance_id
			GROUP BY performance.performance_id, performance.performance_name, first_name, last_name) tmp1,
		(SELECT  performance.performance_id, performance.performance_name AS Name, COUNT(character.character_id) AS quantity2
			FROM performance 
			INNER JOIN character 
			ON performance.performance_id = character.performance_id
			GROUP BY performance.performance_id, performance.performance_name) tmp2
	WHERE tmp1.name=tmp2.name
GO


SELECT * 
 FROM T2
 ORDER BY Name
 GO


 --выбрать 3 самых популярных постановки
SELECT TOP 3 WITH TIES Name, first_name, last_name, quantity1 AS Quantity
	FROM T2
	ORDER BY quantity1 DESC


--выбрать дату последнего показа постановки
SELECT Name, first_name, last_name, MAX(show.show_date)
FROM T2 
INNER JOIN show
ON show.performance_id = T2.performance_id
GROUP BY show.performance_id, Name, first_name, last_name