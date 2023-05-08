--В среде Microsoft Enterprise Manager был создан пользователь test/test. 
--Необходимо дать ему доступ к локальной базе данных (назначить ему роль уровня базы данных public). 
--Для этого надо в среде Microsoft Query Analyzer выполнить следующую команду T-SQL: exec sp_grantdbaccess 'test'

USE master;

GO

DROP LOGIN testo
DROP USER testo

CREATE LOGIN testo WITH PASSWORD = '150102'
CREATE USER testo FOR LOGIN testo

--Проверим, к чему сейчас имеет доступ созданный пользователь

EXECUTE AS USER = 'testo';

SELECT * FROM person_general_information; -- не может читать из таблицы

SELECT genre_name FROM genres; 

SELECT * FROM theatre
UPDATE theatre
	SET theatre_city_id = 2
	WHERE theatre_id = 1; --не может обновлять

INSERT INTO person_general_information VALUES ((SELECT MAX(person_id)+1 FROM person_general_information),'Бобров','Петр',1,'04.03.1991', 2); --не может вставлять
DELETE FROM show
	WHERE performance_id = 3; --не может удалять

REVERT

--Присвоить новому пользователю права SELECT, INSERT, UPDATE в полном объеме на одну таблицу

GRANT INSERT, SELECT, UPDATE, DELETE ON person_general_information TO testo;

EXECUTE AS USER = 'testo';

SELECT * FROM person_general_information; --может читать

BEGIN TRAN
UPDATE person_general_information
	SET first_name = 'Владамир' 
	WHERE first_name = 'Андрей'
	AND last_name = 'Зайков'; --может обновлять
ROLLBACK

INSERT INTO person_general_information VALUES ((SELECT MAX(person_id)+1 FROM person_general_information),'Бобров','Петр',1,'04.03.1991', 2); --может вставлять

DELETE FROM person_general_information
	WHERE person_id = 3; --может удалять

REVERT

REVOKE SELECT ON person_general_information TO testo

--Для одной таблицы новому пользователю присвоим права SELECT и UPDATE только избранных столбцов.

GRANT SELECT, UPDATE ON person_general_information (person_id, first_name, sex_id) TO testo;

EXECUTE AS USER = 'testo';

SELECT * FROM person_general_information; --всё не может читать

SELECT person_id, sex_id FROM person_general_information; --выделенные мной столбцы может

UPDATE person_general_information
	SET first_name = 'Владамир' 
	WHERE first_name = 'Андрей'
	AND last_name = 'Зайков'; --нет доступа к столбцу last_name, поэтому не может обновить

BEGIN TRAN
UPDATE person_general_information
 	SET first_name = 'Владимир' 
	WHERE person_id =29; --может обновлять
ROLLBACK

REVERT;

REVOKE SELECT ON person_general_information (person_id, first_name, sex_id) TO testo

--Для одной таблицы новому пользователю присвоим только право SELECT.

GRANT SELECT ON performance  TO testo;

EXECUTE AS USER = 'testo';

SELECT * FROM person_general_information; --нет прав на эту таблицу, не читает

SELECT * FROM performance; --может читать

UPDATE performance
	SET theatre_id = 4
	WHERE performance_name = 'Лебединое озеро'    --нет прав на обновление

REVERT;

REVOKE SELECT ON performance TO testo

--Присвоим новому пользователю право доступа (SELECT) к представлению, созданному в лабораторной работе №5.

GRANT SELECT ON T2 TO testo;

EXECUTE AS USER = 'testo';

SELECT * FROM T2;

REVERT;

REVOKE SELECT ON T2 TO testo

--Создадим стандартную роль уровня базы данных.

EXEC sp_addrole 'testorole';

--Присвоим ей право доступа SELECT

GRANT SELECT ON T2 TO testorole;

--Назначим новому пользователю созданную роль.

EXEC sp_addrolemember 'db_owner', 'testo';

EXEC sp_changeobjectowner 'person_general_information', 'testo'; -- 

--Проверим выполненные действия.

EXECUTE AS USER = 'testo';

SELECT directors, Name FROM T2;

REVERT;

--Завершим работу.

EXEC sp_droprolemember 'db_owner', 'testo';

EXEC sp_droprole 'testorole';

EXEC sp_dropuser 'testo';

EXEC sp_droplogin 'testo';

--сменить владельца объекта
--подключение через tcp, ip








------------











/*DENY SELECT ON person_general_information TO testorole
GRANT SELECT ON person_general_information TO testo
SELECT * FROM person_general_information 

REVOKE SELECT ON person_general_information TO testo

DENY SELECT ON person_general_information TO testo
GRANT SELECT ON person_general_information TO testorole

EXECUTE AS USER = 'testo';
REVERT*/

/*создать пользователя, у которого роль с deny и роль с dbowner
зайти этим пользователем, добиться того, чтобы право появилось*/

