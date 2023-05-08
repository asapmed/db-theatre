--вывести шоу, на которых купило билеты меньше 60% от вместимости театра
SELECT CAST(show_date AS datetime2(0)), show_attendance, performance_name, city_name, country_name
FROM country 
JOIN city
ON city.country_id = country.country_id
JOIN theatre
ON theatre.theatre_city_id = city.city_id
JOIN performance
ON performance.performance_id = theatre.theatre_id
JOIN show
ON show.performance_id = performance.performance_id
WHERE show.show_attendance < 0.6 * theatre.theatre_capacity 
AND DATEPART(month, show_date ) = 10
AND country_name = 'Австрия'