USE SQL_E1;
CREATE TABLE Lecturers (
	LID varchar(5), --primary key,	
	FullName varchar(100) not null,
	Address varchar(100) not null,
	DOB date not null,
	CONSTRAINT pkLecturers PRIMARY KEY (LID)
)

CREATE TABLE Projects (
	PID varchar(5), --primary key,	
	Title varchar(100) not null,
	Level char(1) not null,
	Cost int
	CONSTRAINT pkProjects PRIMARY KEY (PID)
)

CREATE TABLE Participation (
	LID varchar(5),
	PID varchar(5),
	Duration int,
	PRIMARY KEY(LID, PID),
	FOREIGN KEY(LID) REFERENCES Lecturers(LID) ON DELETE CASCADE,
	FOREIGN KEY(PID) REFERENCES Projects(PID) ON DELETE CASCADE --,
	--CONSTRAINT fk1 FOREIGN KEY (LID) REFERENCES Lecturers (LID) UPDATE CASCADE ON DELETE CASCADE , 
	--CONSTRAINT fk2 FOREIGN KEY (PID) REFERENCES Projects (PID) UPDATE CASCADE ON DELETE CASCADE )

)

INSERT INTO Lecturers VALUES('GV01', 'Vu Tuyet Trinh', 'Hoang Mai, Hanoi', '10/10/1975'),
('GV02', 'Nguyen Nhat Quang', 'Hai Ba Trung, Hanoi', '03/11/1976'),
('GV03', 'Tran Duc Khanh', 'Dong Da, Hanoi', '04/06/1977'), 
('GV04', 'Nguyen Hong Phuong', 'Tay Ho, Hanoi', '10/12/1983'), 
('GV05', 'Le Thanh Huong', 'Hai Ba Trung, Hanoi', '10/10/1976')

INSERT INTO Projects VALUES ('DT01', 'Grid Computing','A','700'),
('DT02', 'Knowledge Discovery', 'B','300'),
('DT03', 'Text Classification', 'B','270'),
('DT04', 'Automatic English-Vietnamese Translation', 'C','30')

INSERT INTO Participation VALUES ('GV01','DT01','100'),
('GV01','DT02','80'),
('GV01','DT03','80'),
('GV02','DT01','120'),
('GV02','DT03','140'),
('GV03','DT03','150'),
('GV04','DT04','180')

--DROP TABLE Lecturers
--DROP TABLE Projects
--DROP TABLE Participation

-- 1.List lecturers' information whose address are in "Hai Ba Trung" district, 
--	order by full name descending.
SELECT *
FROM Lecturers
WHERE Address LIKE '%Hai Ba Trung%' --OR Address LIKE '%Dong Da%'
ORDER BY FullName DESC

-- 2.List {Full name, Address, DOB} information of lecturers who participated "Grid computing" project.
SELECT l.FullName, l.Address, l.DOB
FROM Lecturers l
INNER JOIN Participation p ON l.LID = p.LID
INNER JOIN Projects pr ON p.PID = pr.PID
WHERE pr.Title LIKE '%Grid Computing%';

-- 3.List {Full name, Address, DOB} information of lecturers 
-- who participated "Grid computing" project OR "Automatic English-Vietnamese Translation" project.
SELECT l.FullName, l.Address, l.DOB 
FROM Lecturers AS l
 JOIN Participation AS p ON l.LID = p.LID
 JOIN Projects AS pr ON p.PID = pr.PID
WHERE pr.Title IN ('Grid Computing', 'Automatic English-Vietnamese Translation')
-- WHERE pr.Title LIKE '%Grid Computing%' OR pr.Title LIKE '%Automatic English-Vietnamese Translation%' (cũng được)

-- 4.Find lecturers who joined at least in two projects
SELECT L.FullName, L.Address, L.DOB
FROM Lecturers L
WHERE (SELECT COUNT(*) FROM Participation P WHERE P.LID = L.LID) >= 2;

-- 5.Find the full name of the lecturers who took part in more projects than others did
SELECT FullName
FROM Lecturers
WHERE LID IN (
	SELECT LID
	FROM Participation
	GROUP BY LID
	HAVING COUNT(DISTINCT PID) = (
		SELECT MAX(ProjectCount)
		FROM (
			SELECT COUNT(DISTINCT PID) AS ProjectCount
			FROM Participation
			GROUP BY LID
		) AS ProjectCounts
	)
);

-- 6.Find the cheapest project.
SELECT *
FROM Projects
WHERE Cost = (SELECT MIN(Cost) FROM Projects)
-- SELECT *
--FROM Projects
--WHERE Cost = (SELECT TOP 1 * FROM Projects ORDER BY Cost ASC) (Cách 2 nếu muốn dùng TOP)
-- Không được SELECT TOP 1 * từ đầu tại vì sẽ chỉ trả về 1 giá trị nếu cùng có nhiều cái min

-- 7.Show the name and DOB of lecturers who live in "Tay Ho" district and their project's title
SELECT l.FullName, l.DOB, p.Title
FROM Lecturers l
JOIN Participation pr ON l.LID = pr.LID
JOIN Projects p ON pr.PID = p.PID
WHERE l.Address LIKE '%Tay Ho%'

-- 8.Find the name of lecturers who was born before 1980 and joined the "Text Classification" project.
SELECT l.FullName
FROM Lecturers AS l
JOIN Participation AS p ON l.LID = p.LID
JOIN Projects AS pr ON p.PID = pr.PID
WHERE l.DOB < '1980-01-01' AND pr.Title LIKE '%Text Classification%'
-- DATEPART(y,DOB) < 1980

-- 9.For each lecturers, list LID, full name and the total of duration. 
SELECT l.LID, l.FullName, ISNULL(SUM(p.Duration), 0) as TotalofDuration
FROM Lecturers AS l
LEFT JOIN Participation AS p ON l.LID = p.LID
GROUP BY l.LID, l.FullName

-- 10.Lecturer named Ngo Tuan Phong, born on 08/09/1986, lives in "Dong Da, Hanoi", 
--	join doing scientific research. Please insert this information into Lecturers table.
INSERT INTO Lecturers VALUES ('GV06', 'Ngo Tuan Phong', 'Dong Da, Hanoi', '08/09/1986')

-- 11.Lecturer named Vu Tuyet Trinh moved to "Tay Ho, Hanoi". Please update this information.
UPDATE Lecturers
SET Address = 'Tay Ho, Hanoi'
WHERE FullName = 'Vu Tuyet Trinh'

-- 12.Lecturer with LID "GV02" no longer participate any projects.
--	The information relating to this lecturer should be crossed out of database. Please complete this command.
DELETE FROM Participation WHERE LID = 'GV02'
DELETE FROM Lecturers WHERE LID = 'GV02'

--13.Cho biết số GV tham gia đề tài mã là DT01
SELECT COUNT(LID)
FROM Participation
WHERE PID = 'DT01'

--14.Có bao nhiêu GV tgia đề tài ít kinh phí nhất

SELECT COUNT(LID) as countgvmin
FROM Participation
WHERE PID IN (SELECT PID
			  FROM Projects
			  WHERE Cost = (SELECT MIN(Cost) FROM Projects))

SELECT * 
FROM Students
WHERE student_id IN (SELECT student_id FROM Enroll WHERE subject_id = 'IT3290');

SELECT st.student_id, st.student_fullName, (factor * final_score + (1 - factor) * midterm_score) AS subject_score
FROM Students st
JOIN Enroll e ON e.student_id = st.student_id
JOIN Subjects sj e ON e.subject_id = sj.subject_id
WHERE subject_id = 'IT3290E'
