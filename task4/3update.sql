--������ ������ ��������� ������� ���� �������� � ������� ������� ������, ������� �������� ����� 1980 ����
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
WHERE theatre_name = '������� ������� �����'

UPDATE actor_character_information
SET actor_id = (
SELECT person_id
FROM person_general_information
WHERE first_name = '������'
AND last_name = '���������')
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
WHERE theatre_name = '������� ������� �����'
AND sex = '�������'
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
WHERE theatre_name = '������� ������� �����'