SELECT name, database_id, create_date
FROM sys.databases;

SELECT name FROM master.dbo.sysdatabases

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'

SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME ='GiangVien'

EXEC sp_help 'Sach'

select * from sys.all_columns where object_id = OBJECT_ID('TacGia')

SELECT s.name as schema_name, t.name as table_name,c.* FROM sys.columns AS c

INNER JOIN sys.tables AS t ON t.object_id = c.object_id
INNER JOIN sys.schemas AS s ON s.schema_id = t.schema_id
WHERE t.name = 'Lecturers' AND s.name = 'dbo';