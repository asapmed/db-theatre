--������� ���c����� ��������� ��� ���������� ��������� ����� � ���������� ������
SELECT character_id, character_name, theatre_name
FROM character
JOIN performance
ON character.performance_id = performance.performance_id
JOIN theatre
ON performance.theatre_id = theatre.theatre_id
WHERE performance_name = '��������� �����'
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
WHERE performance_name = '��������� �����'
AND theatre_name = '���������� �����')
AND character_name = '���������'

SELECT character_id, character_name, theatre_name
FROM character
JOIN performance
ON character.performance_id = performance.performance_id
JOIN theatre
ON performance.theatre_id = theatre.theatre_id
WHERE performance_name = '��������� �����'
ORDER BY theatre_name