--удалить перcонажа Вольфганг для постановки Лебединое озеро в Мариинском театре
SELECT character_id, character_name, theatre_name
FROM character
JOIN performance
ON character.performance_id = performance.performance_id
JOIN theatre
ON performance.theatre_id = theatre.theatre_id
WHERE performance_name = 'Лебединое озеро'
ORDER BY theatre_name

DELETE
FROM character 
WHERE performance_id in (
SELECT character.performance_id
FROM character
JOIN performance
ON character.performance_id = performance.performance_id
JOIN theatre
ON performance.theatre_id = theatre.theatre_id
WHERE performance_name = 'Лебединое озеро'
AND theatre_name = 'Мариинский театр')
AND character_name = 'Вольфганг'

SELECT character_id, character_name, theatre_name
FROM character
JOIN performance
ON character.performance_id = performance.performance_id
JOIN theatre
ON performance.theatre_id = theatre.theatre_id
WHERE performance_name = 'Лебединое озеро'
ORDER BY theatre_name