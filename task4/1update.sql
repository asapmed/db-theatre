--заменить месторасположение города Севастополь с Украины на Россию
SELECT city_name AS city_in_Ukrain
FROM city 
JOIN country
ON city.country_id = country.country_id
WHERE country.country_name = 'Украина'

UPDATE city
SET city.country_id = (
SELECT country_id
FROM country
WHERE country_name = 'Россия')
FROM city 
JOIN country
ON city.country_id = country.country_id
WHERE country.country_name = 'Украина'
AND city.city_name = 'Севастополь'

SELECT city_name city_in_Ukrain
FROM city 
JOIN country
ON city.country_id = country.country_id
WHERE country.country_name = 'Украина'

SELECT city_name city_in_Russia
FROM city 
JOIN country
ON city.country_id = country.country_id
WHERE country.country_name = 'Россия'

/*SELECT country_id
FROM country
WHERE country_name = 'Россия'*/