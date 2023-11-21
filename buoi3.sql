CREATE TABLE Person(
PersonID int,
LastName varchar(255),
FirstName varchar(255),
Age int,
Gender char(1),
City varchar(255)
);

INSERT INTO Person
VALUES(1,'Hiddleston','Tom',23,'F','Florida'),(2,'Watson','Angela',18,'F','Texas'),
(3,'Clooney','Pandora',34,'U','Arizona'),
(4,'Crane','Amory',52,'M','California'),
(5,'Clooney','Bush',67,'M','Arizona'),
(6,'Schwimmer','Geoffrey',19,'U','Hawaii')

--CREATE TABLE TestTable AS
	--SELECT FirstName, LastName
	--FROM Person; (không chạy được trong sql server)

SELECT FirstName, LastName INTO TestTable From Person;

SELECT * INTO Person2 FROM Person;

DROP TABLE Person2;

TRUNCATE TABLE Person;

ALTER TABLE Person ADD Email varchar(255);

ALTER TABLE Person DROP COLUMN Email;

ALTER TABLE Person ALTER COLUMN LastName varchar(50);
ALTER TABLE Person ALTER COLUMN FirstName varchar(50);

DROP TABLE Person
CREATE TABLE Person(
PersonID int NOT NULL,
LastName varchar(50) NOT NULL,
FirstName varchar(50) NOT NULL,Age int,
Gender char(1),
City varchar(255)
);

ALTER TABLE Person ALTER COLUMN Age int NOT NULL;

DROP TABLE Person
CREATE TABLE Person(
PersonID int NOT NULL UNIQUE,
LastName varchar(50) NOT NULL,FirstName varchar(50) NOT NULL,Age int,
Gender char(1),
City varchar(255)
);

DROP TABLE Person
CREATE TABLE Person(
PersonID int NOT NULL,
LastName varchar(50) NOT NULL,
FirstName varchar(50) NOT NULL,
Age int,
Gender char(1),
City varchar(255),
CONSTRAINT UC_Person UNIQUE (PersonID,LastName));

ALTER TABLE Person ADD CONSTRAINT UC_PersonID UNIQUE (PersonID);

ALTER TABLE Person DROP CONSTRAINT UC_PersonID;

DROP TABLE Person
CREATE TABLE Person(
PersonID int NOT NULL PRIMARY KEY,
LastName varchar(50) NOT NULL, --không được viết primary key vào đây, nếu muốn nhiều primary key thì phải dòng đoạn code dưới
FirstName varchar(50) NOT NULL,
Age int,
Gender char(1),
City varchar(255),
);

DROP TABLE Person
CREATE TABLE Person(
PersonID int NOT NULL,
LastName varchar(50) NOT NULL,
FirstName varchar(50) NOT NULL,
Age int,
Gender char(1),
City varchar(255),
CONSTRAINT PK_Person PRIMARY KEY(PersonID,LastName));

ALTER TABLE Person ADD PRIMARY KEY(PersonID);

ALTER TABLE Person
ADD CONSTRAINT PK_Person PRIMARY KEY(PersonID,LastName);

ALTER TABLE Person DROP CONSTRAINT PK_Person;

CREATE TABLE Orders (
OrderID int NOT NULL PRIMARY KEY,
OrderNumber int NOT NULL,
PersonID int FOREIGN KEY REFERENCES Person(PersonID));

DROP TABLE Orders
CREATE TABLE Orders(
OrderID int NOT NULL,
OrderNumber int NOT NULL,
PersonID int,
PRIMARY KEY(OrderID),
CONSTRAINT FK_PersonOrder FOREIGN KEY (PersonID)REFERENCES Person(PersonID)
);

ALTER TABLE Orders ADD FOREIGN KEY (PersonID)REFERENCES Person(PersonID);

ALTER TABLE Orders ADD CONSTRAINT FK_PersonOrder FOREIGN KEY (PersonID) REFERENCES Person(PersonID);

ALTER TABLE Orders DROP CONSTRAINT FK_PersonOrder;

DROP TABLE Person
CREATE TABLE Person(
PersonID int NOT NULL PRIMARY KEY,
LastName varchar(50) NOT NULL,
FirstName varchar(50) NOT NULL,
Age int CHECK (Age>=1 AND Age<=130),Gender char(1),
City varchar(255)
);

DROP TABLE Person
CREATE TABLE Person(
PersonID int NOT NULL PRIMARY KEY,
LastName varchar(50) NOT NULL,
FirstName varchar(50) NOT NULL,
Age int,
Gender char(1),
City varchar(255),
CONSTRAINT CHK_Person CHECK (Age>=1 AND City='Florida'));

ALTER TABLE Person ADD CHECK (Age>=1);

ALTER TABLE Person
ADD CONSTRAINT CHK_PersonAge
CHECK (Age>=1 AND City='Florida');

ALTER TABLE Person DROP CONSTRAINT CHK_PersonAge;

DROP TABLE Person
CREATE TABLE Person(
PersonID int NOT NULL PRIMARY KEY,
LastName varchar(50) NOT NULL,
FirstName varchar(50) NOT NULL,
Age int,
Gender char(1),
City varchar(255) DEFAULT 'California'
);

DROP TABLE Orders
CREATE TABLE Orders(
ID int NOT NULL,
OrderNumber int NOT NULL,
OrderDate date DEFAULT GETDATE()
);

ALTER TABLE Person ADD CONSTRAINT df_City
DEFAULT 'California' FOR City;

ALTER TABLE Person DROP CONSTRAINT df_City

DROP TABLE Person
CREATE TABLE Person(
PersonID int identity(1,1) PRIMARY KEY,
LastName varchar(50) NOT NULL,
FirstName varchar(50) NOT NULL,
Age int,
Gender char(1),
City varchar(255)
);


CREATE TABLE Lecturers(
LID char(4) NOT NULL,
FullName nchar(30) NOT NULL,
Address nvarchar(50) NOT NULL,
DOB date NOT NULL,
CONSTRAINT pkLecturers PRIMARY KEY (LID)
)
CREATE TABLE Projects(
PID char(4) NOT NULL,
Title nvarchar(50) NOT NULL,
Level nchar(12) NOT NULL,
Cost integer,
CONSTRAINT pkProjects PRIMARY KEY (PID)
)
CREATE TABLE Participation(
LID char(4) NOT NULL,
PID char(4) NOT NULL,
Duration smallint,
CONSTRAINT pkParticipation PRIMARY KEY (LID, PID),
CONSTRAINT fk1 FOREIGN KEY (LID) REFERENCES Lecturers (LID),CONSTRAINT fk2 FOREIGN KEY (PID) REFERENCES Projects (PID) )
INSERT INTO Lecturers VALUES('GV01',N'Vũ Tuyết Trinh',N'Hoàng Mai, Hà Nội','1975/10/10'), ('GV02',N'Nguyễn Nhật Quang',N'Hai Bà Trưng, Hà Nội','1976/11/03'),
('GV03',N'Trần Đức Khánh',N'Đống Đa, Hà Nội','1977/06/04'), ('GV04',N'Nguyễn Hồng Phương',N'Tây Hồ, Hà Nội','1983/12/10'),
('GV05',N'Lê Thanh Hương',N'Hai Bà Trưng, Hà Nội','1976/10/10')
INSERT INTO Projects VALUES ('DT01',N'Tính toán lưới',N'Nhà nước','700'),('DT02',N'Phát hiện tri thức',N'Bộ','300'),
('DT03',N'Phân loại văn bản',N'Bộ','270'),
('DT04',N'Dịch tự động Anh Việt',N'Trường','30')
INSERT INTO Participation VALUES ('GV01','DT01','100'),
('GV01','DT02','80'),
('GV01','DT03','80'),
('GV02','DT01','120'),
('GV02','DT03','140'),
('GV03','DT03','150'),
('GV04','DT04','180')