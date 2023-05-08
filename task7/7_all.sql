--� ����� Microsoft Enterprise Manager ��� ������ ������������ test/test. 
--���������� ���� ��� ������ � ��������� ���� ������ (��������� ��� ���� ������ ���� ������ public). 
--��� ����� ���� � ����� Microsoft Query Analyzer ��������� ��������� ������� T-SQL: exec sp_grantdbaccess 'test'

USE master;

GO

DROP LOGIN testo
DROP USER testo

CREATE LOGIN testo WITH PASSWORD = '150102'
CREATE USER testo FOR LOGIN testo

--��������, � ���� ������ ����� ������ ��������� ������������

EXECUTE AS USER = 'testo';

SELECT * FROM person_general_information; -- �� ����� ������ �� �������

SELECT genre_name FROM genres; 

SELECT * FROM theatre
UPDATE theatre
	SET theatre_city_id = 2
	WHERE theatre_id = 1; --�� ����� ���������

INSERT INTO person_general_information VALUES ((SELECT MAX(person_id)+1 FROM person_general_information),'������','����',1,'04.03.1991', 2); --�� ����� ���������
DELETE FROM show
	WHERE performance_id = 3; --�� ����� �������

REVERT

--��������� ������ ������������ ����� SELECT, INSERT, UPDATE � ������ ������ �� ���� �������

GRANT INSERT, SELECT, UPDATE, DELETE ON person_general_information TO testo;

EXECUTE AS USER = 'testo';

SELECT * FROM person_general_information; --����� ������

BEGIN TRAN
UPDATE person_general_information
	SET first_name = '��������' 
	WHERE first_name = '������'
	AND last_name = '������'; --����� ���������
ROLLBACK

INSERT INTO person_general_information VALUES ((SELECT MAX(person_id)+1 FROM person_general_information),'������','����',1,'04.03.1991', 2); --����� ���������

DELETE FROM person_general_information
	WHERE person_id = 3; --����� �������

REVERT

REVOKE SELECT ON person_general_information TO testo

--��� ����� ������� ������ ������������ �������� ����� SELECT � UPDATE ������ ��������� ��������.

GRANT SELECT, UPDATE ON person_general_information (person_id, first_name, sex_id) TO testo;

EXECUTE AS USER = 'testo';

SELECT * FROM person_general_information; --�� �� ����� ������

SELECT person_id, sex_id FROM person_general_information; --���������� ���� ������� �����

UPDATE person_general_information
	SET first_name = '��������' 
	WHERE first_name = '������'
	AND last_name = '������'; --��� ������� � ������� last_name, ������� �� ����� ��������

BEGIN TRAN
UPDATE person_general_information
 	SET first_name = '��������' 
	WHERE person_id =29; --����� ���������
ROLLBACK

REVERT;

REVOKE SELECT ON person_general_information (person_id, first_name, sex_id) TO testo

--��� ����� ������� ������ ������������ �������� ������ ����� SELECT.

GRANT SELECT ON performance  TO testo;

EXECUTE AS USER = 'testo';

SELECT * FROM person_general_information; --��� ���� �� ��� �������, �� ������

SELECT * FROM performance; --����� ������

UPDATE performance
	SET theatre_id = 4
	WHERE performance_name = '��������� �����'    --��� ���� �� ����������

REVERT;

REVOKE SELECT ON performance TO testo

--�������� ������ ������������ ����� ������� (SELECT) � �������������, ���������� � ������������ ������ �5.

GRANT SELECT ON T2 TO testo;

EXECUTE AS USER = 'testo';

SELECT * FROM T2;

REVERT;

REVOKE SELECT ON T2 TO testo

--�������� ����������� ���� ������ ���� ������.

EXEC sp_addrole 'testorole';

--�������� �� ����� ������� SELECT

GRANT SELECT ON T2 TO testorole;

--�������� ������ ������������ ��������� ����.

EXEC sp_addrolemember 'db_owner', 'testo';

EXEC sp_changeobjectowner 'person_general_information', 'testo'; -- 

--�������� ����������� ��������.

EXECUTE AS USER = 'testo';

SELECT directors, Name FROM T2;

REVERT;

--�������� ������.

EXEC sp_droprolemember 'db_owner', 'testo';

EXEC sp_droprole 'testorole';

EXEC sp_dropuser 'testo';

EXEC sp_droplogin 'testo';

--������� ��������� �������
--����������� ����� tcp, ip








------------











/*DENY SELECT ON person_general_information TO testorole
GRANT SELECT ON person_general_information TO testo
SELECT * FROM person_general_information 

REVOKE SELECT ON person_general_information TO testo

DENY SELECT ON person_general_information TO testo
GRANT SELECT ON person_general_information TO testorole

EXECUTE AS USER = 'testo';
REVERT*/

/*������� ������������, � �������� ���� � deny � ���� � dbowner
����� ���� �������������, �������� ����, ����� ����� ���������*/

