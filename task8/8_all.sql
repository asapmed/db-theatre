--1. Выбрать имена всех таблиц, которыми владеет назначенный пользователь базы данных 
SELECT name AS 'Таблицы' 
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

--2. Выбрать имя таблицы, имя столбца таблицы, признак того, допускает ли данный столбец null-значения, 
--название типа данных столбца таблицы, размер этого типа данных - для всех таблиц, 
--созданных назначенным пользователем базы данных и всех их столбцов 
SELECT a.name AS 'Таблица', 
col.name AS 'Столбец', 
nullble = CASE col.is_nullable 
WHEN 0 THEN 'YES' 
ELSE 'NO' 
END, 
tip.name AS 'Тип данных', 
tip.max_length AS 'Размер' 
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

--3. Выбрать название ограничения целостности (первичные и внешние ключи), имя таблицы, 
--в которой оно находится, признак того, что это за ограничение ('PK' для первичного ключа и 'F' для 
--внешнего) - для всех ограничений целостности, созданных назначенным пользователем базы данных 
SELECT KEYS.name AS 'Название', [TABLES].name AS 'Таблица', KEYS.TYPE AS 'Тип' 
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


--4) Выбрать название внешнего ключа, имя таблицы, содержащей внешний ключ, имя таблицы, содержащей его
--родительский ключ - для всех внешних ключей, созданных назначенным пользователем базы данных. */

SELECT fk.name AS 'Название',
       o1.name AS 'Содержится в',
	   o2.name AS 'Ссылается на'
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

--5) Выбрать название представления, SQL-запрос, создающий это представление - для всех представлений,
--созданных назначенным пользователем базы данных. */

SELECT o.name AS 'Представление',
       m.definition AS 'Запрос, создающий представление'
FROM sys.objects o
    INNER JOIN sys.sql_modules m ON m.object_id=o.object_id
WHERE o.type='V'
AND o.schema_id = 
( 
SELECT sys.database_principals.principal_id 
FROM sys.database_principals 
WHERE sys.database_principals.name = user_name() 
)


--6) Выбрать название триггера, имя таблицы, для которой определен триггер -
--для всех триггеров, созданных назначенным пользователем базы данных. */


SELECT tr.name AS 'Триггер', 
       o.name AS 'Таблица'
FROM sys.triggers tr
    JOIN sys.objects o on tr.parent_id=o.object_id
WHERE tr.type='TR'

