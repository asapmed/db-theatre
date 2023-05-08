/*EXEC sp_addrolemember 'testo', 'db_owner';
EXEC sp_changeobjectowner 'person_general_information', 'testo'; */


ALTER AUTHORIZATION ON OBJECT::person_general_information TO testo;    