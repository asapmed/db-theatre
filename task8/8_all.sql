--1. ������� ����� ���� ������, �������� ������� ����������� ������������ ���� ������ 
SELECT name AS '�������' 
FROM sys.objects 
WHERE TYPE = 'U' 
AND schema_id = 
( 
SELECT sys.database_principals.principal_id 
FROM sys.database_principals 
WHERE sys.database_principals.name = user_name() 
) 
AND object_id NOT IN 
( 
SELECT major_id 
FROM sys.extended_properties 
WHERE name = 'microsoft_database_tools_support' 
) 

--2. ������� ��� �������, ��� ������� �������, ������� ����, ��������� �� ������ ������� null-��������, 
--�������� ���� ������ ������� �������, ������ ����� ���� ������ - ��� ���� ������, 
--��������� ����������� ������������� ���� ������ � ���� �� �������� 
SELECT a.name AS '�������', 
col.name AS '�������', 
nullble = CASE col.is_nullable 
WHEN 0 THEN 'YES' 
ELSE 'NO' 
END, 
tip.name AS '��� ������', 
tip.max_length AS '������' 
FROM sys.objects AS a 
JOIN sys.columns AS col ON a.object_id = col.object_id 
JOIN sys.types AS tip ON col.system_type_id = tip.system_type_id 
WHERE a.type = 'U' 
AND a.schema_id = 
( 
SELECT sys.database_principals.principal_id 
FROM sys.database_principals 
WHERE sys.database_principals.name = user_name() 
) 
AND a.object_id NOT IN 
( 
SELECT major_id 
FROM sys.extended_properties 
WHERE name = 'microsoft_database_tools_support' 
)

--3. ������� �������� ����������� ����������� (��������� � ������� �����), ��� �������, 
--� ������� ��� ���������, ������� ����, ��� ��� �� ����������� ('PK' ��� ���������� ����� � 'F' ��� 
--��������) - ��� ���� ����������� �����������, ��������� ����������� ������������� ���� ������ 
SELECT KEYS.name AS '��������', [TABLES].name AS '�������', KEYS.TYPE AS '���' 
FROM SYS.objects AS KEYS , SYS.objects AS [TABLES] 
WHERE KEYS.parent_object_id = [TABLES].object_id 
AND (KEYS.TYPE = 'PK' OR KEYS.TYPE = 'F') 
AND keys.schema_id = 
( 
SELECT sys.database_principals.principal_id 
FROM sys.database_principals 
WHERE sys.database_principals.name = user_name() 
) 
AND [TABLES].object_id NOT IN 
( 
SELECT major_id 
FROM sys.extended_properties 
WHERE name = 'microsoft_database_tools_support' 
) 


--4) ������� �������� �������� �����, ��� �������, ���������� ������� ����, ��� �������, ���������� ���
--������������ ���� - ��� ���� ������� ������, ��������� ����������� ������������� ���� ������. */

SELECT fk.name AS '��������',
       o1.name AS '���������� �',
	   o2.name AS '��������� ��'
FROM sys.foreign_keys fk
    JOIN sys.foreign_key_columns kc ON kc.constraint_object_id=fk.object_id
    JOIN sys.objects o1 ON o1.object_id=kc.parent_object_id
    JOIN sys.objects o2 ON o2.object_id=kc.referenced_object_id
WHERE fk.schema_id = 
( 
SELECT sys.database_principals.principal_id 
FROM sys.database_principals 
WHERE sys.database_principals.name = user_name() 
) 

--5) ������� �������� �������������, SQL-������, ��������� ��� ������������� - ��� ���� �������������,
--��������� ����������� ������������� ���� ������. */

SELECT o.name AS '�������������',
       m.definition AS '������, ��������� �������������'
FROM sys.objects o
    INNER JOIN sys.sql_modules m ON m.object_id=o.object_id
WHERE o.type='V'
AND o.schema_id = 
( 
SELECT sys.database_principals.principal_id 
FROM sys.database_principals 
WHERE sys.database_principals.name = user_name() 
)


--6) ������� �������� ��������, ��� �������, ��� ������� ��������� ������� -
--��� ���� ���������, ��������� ����������� ������������� ���� ������. */


SELECT tr.name AS '�������', 
       o.name AS '�������'
FROM sys.triggers tr
    JOIN sys.objects o on tr.parent_id=o.object_id
WHERE tr.type='TR'

