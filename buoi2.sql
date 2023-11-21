CREATE TABLE kids(
id CHAR(6),
race SMALLINT,
age DECIMAL(6,3),
height DECIMAL(7,3),
weight DECIMAL(7,3),
sex SMALLINT);

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
