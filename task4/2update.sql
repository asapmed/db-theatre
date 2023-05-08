--отменить все спектакли в Мариинском театре в ноябре 
SELECT performance_name, CAST(show_date AS datetime2(0)) AS date_of_show
FROM show
JOIN performance
ON show.performance_id = performance.performance_id
JOIN theatre
ON performance.theatre_id = theatre.theatre_id
WHERE theatre.theatre_name = 'Мариинский театр'
AND DATEPART(month, show_date) = 10
ORDER BY show_date

UPDATE SHOW
SET show_date = NULL
FROM show
WHERE show.performance_id in (
SELECT performance.performance_id
FROM performance
JOIN theatre
ON performance.theatre_id = theatre.theatre_id
WHERE theatre_name = 'Мариинский театр')
AND DATEPART(month, show_date) = 10

SELECT performance_name, CAST(show_date AS datetime2(0)) AS date_of_show
FROM theatre
JOIN performance
ON performance.theatre_id = theatre.theatre_id
LEFT JOIN show
ON show.performance_id = performance.performance_id
WHERE theatre.theatre_name = 'Мариинский театр'
AND DATEPART(month, show_date) = 10
ORDER BY show_date