--������� ��������� ������ ������ � ������� ������ �������� ������
DELETE 
FROM nomination
WHERE achievement_id in (
SELECT achievement_id
FROM achievement
WHERE achievement_name = '������ �������� ������')
AND nomination_name = '������ ������'
