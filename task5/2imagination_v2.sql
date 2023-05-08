--постанока, режиссеры, количество показов, количество персонажей
USE master

IF OBJECT_ID('T2') IS NOT NULL 
DROP VIEW T2
GO 

CREATE VIEW T2 AS
SELECT DISTINCT tmp1.directors, tmp1.performance_id, tmp1.Name, tmp2.[quantity of shows], tmp3.[quantity of characters]
FROM

(SELECT DISTINCT STRING_AGG(CONCAT (first_name,' ', last_name), ', ') AS directors, performance.performance_id, performance.performance_name AS Name
			FROM person_general_information 
			INNER JOIN creators_performance 
			ON person_id = creator_id
			INNER JOIN performance 
			ON creators_performance.performance_id=performance.performance_id
			GROUP BY performance.performance_id, performance.performance_name) tmp1,

(SELECT COUNT (show.show_id) AS [quantity of shows], performance.performance_id
FROM show
JOIN performance
ON show.performance_id = performance.performance_id
GROUP BY performance.performance_id)tmp2,

(SELECT  performance.performance_id, COUNT(character.character_id) AS [quantity of characters]
			FROM performance 
			INNER JOIN character 
			ON performance.performance_id = character.performance_id
			GROUP BY performance.performance_id, performance.performance_name) tmp3

WHERE tmp1.performance_id = tmp2.performance_id
AND tmp2.performance_id = tmp3.performance_id
GO

SELECT * 
 FROM T2
 ORDER BY performance_id
 GO

 --выбрать 3 самых популярных постановки
SELECT TOP 3 WITH TIES Name, directors, [quantity of shows]
	FROM T2
	ORDER BY [quantity of shows] DESC

--выбрать дату последнего показа постановки
SELECT Name, directors, CAST(MAX(show.show_date) AS datetime2(0))
FROM T2 
INNER JOIN show
ON show.performance_id = T2.performance_id
GROUP BY  Name, directors
