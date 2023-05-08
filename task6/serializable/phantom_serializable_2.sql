SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRAN	

INSERT INTO person_general_information VALUES ((SELECT MAX(person_id)+1 FROM person_general_information),'Бобров','Петр',1,'04.03.1991', 2);

COMMIT