--�������� ����������������� ������ ����������� � ������� �� ������
SELECT city_name AS city_in_Ukrain
FROM city 
JOIN country
ON city.country_id = country.country_id
WHERE country.country_name = '�������'

UPDATE city
SET city.country_id = (
SELECT country_id
FROM country
WHERE country_name = '������')
FROM city 
JOIN country
ON city.country_id = country.country_id
WHERE country.country_name = '�������'
AND city.city_name = '�����������'

SELECT city_name city_in_Ukrain
FROM city 
JOIN country
ON city.country_id = country.country_id
WHERE country.country_name = '�������'

SELECT city_name city_in_Russia
FROM city 
JOIN country
ON city.country_id = country.country_id
WHERE country.country_name = '������'

/*SELECT country_id
FROM country
WHERE country_name = '������'*/