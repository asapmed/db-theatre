--�������� ��� ���� ��������� ��������� ��� ���������� ����������� ������
SELECT character.character_name, type_of_character.type_of_character_name
FROM type_of_character
JOIN character
ON character.type_of_character_id = type_of_character.type_of_character_id
JOIN performance
ON character.performance_id = performance.performance_id
JOIN theatre
ON performance.theatre_id = theatre.theatre_id
WHERE theatre_name = '��������������� �����'
AND performance_name = '��������� �����'

UPDATE character
SET type_of_character_id = (
SELECT type_of_character.type_of_character_id
FROM type_of_character
WHERE type_of_character_name = '������')
FROM type_of_character
JOIN character
ON character.type_of_character_id = type_of_character.type_of_character_id
JOIN performance
ON character.performance_id = performance.performance_id
JOIN theatre
ON performance.theatre_id = theatre.theatre_id
WHERE theatre_name = '��������������� �����'
AND performance_name = '��������� �����'
AND character.character_name = '���������'

SELECT character.character_name, type_of_character.type_of_character_name
FROM type_of_character
JOIN character
ON character.type_of_character_id = type_of_character.type_of_character_id
JOIN performance
ON character.performance_id = performance.performance_id
JOIN theatre
ON performance.theatre_id = theatre.theatre_id
WHERE theatre_name = '��������������� �����'
AND performance_name = '��������� �����'