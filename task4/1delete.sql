--удалить те постановки, на которые посещение меньше 60% от вместимости зала
SELECT CAST(show_date AS datetime2(0)), show_attendance, performance_name
FROM theatre
JOIN performance
ON performance.performance_id = theatre.theatre_id
JOIN show
ON show.performance_id = performance.performance_id
WHERE show.show_attendance < 0.6 * theatre.theatre_capacity 
AND DATEPART(month, show_date ) = 10

DELETE
FROM show
WHERE show_id in(
SELECT show_id 
FROM theatre
JOIN performance
ON performance.performance_id = theatre.theatre_id
JOIN show
ON show.performance_id = performance.performance_id
WHERE show_attendance < 0.6 * theatre.theatre_capacity
AND DATEPART(month, show_date) = 10)

SELECT CAST(show_date AS datetime2(0)), show_attendance, performance_name
FROM theatre
JOIN performance
ON performance.performance_id = theatre.theatre_id
JOIN show
ON show.performance_id = performance.performance_id
WHERE show.show_attendance < 0.6 * theatre.theatre_capacity 
AND DATEPART(month, show_date ) = 10