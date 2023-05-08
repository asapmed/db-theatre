--солист Андрей Григорьев заменит всех солистов в Римском оперном театре, которые родились после 1980 года
SELECT DISTINCT first_name, last_name
FROM sex 
JOIN person_general_information
ON person_general_information.sex_id = sex.sex_id
JOIN actor_character_information
ON actor_id = person_id
JOIN show 
ON actor_character_information.show_id = show.show_id
JOIN performance
ON show.performance_id = performance.performance_id
JOIN theatre
ON performance.theatre_id = theatre.theatre_id
WHERE theatre_name = 'Римский оперный театр'

UPDATE actor_character_information
SET actor_id = (
SELECT person_id
FROM person_general_information
WHERE first_name = 'Андрей'
AND last_name = 'Григорьев')
FROM actor_character_information
WHERE actor_character_information.actor_id in (
SELECT person_general_information.person_id
FROM sex 
JOIN person_general_information
ON person_general_information.sex_id = sex.sex_id
JOIN actor_character_information
ON actor_id = person_id
JOIN show 
ON actor_character_information.show_id = show.show_id
JOIN performance
ON show.performance_id = performance.performance_id
JOIN theatre
ON performance.theatre_id = theatre.theatre_id
WHERE theatre_name = 'Римский оперный театр'
AND sex = 'Мужской'
AND DATEPART(year, date_of_birth) > 1980)

SELECT DISTINCT first_name, last_name
FROM sex 
JOIN person_general_information
ON person_general_information.sex_id = sex.sex_id
JOIN actor_character_information
ON actor_id = person_id
JOIN show 
ON actor_character_information.show_id = show.show_id
JOIN performance
ON show.performance_id = performance.performance_id
JOIN theatre
ON performance.theatre_id = theatre.theatre_id
WHERE theatre_name = 'Римский оперный театр'