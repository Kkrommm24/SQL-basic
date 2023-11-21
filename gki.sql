CREATE TABLE TheLoai (
	TheLoai_id varchar(20) not null,
	TheLoai_name nvarchar(50),
	CONSTRAINT pkTheloai PRIMARY KEY(TheLoai_id),
)

CREATE TABLE Book (
	Book_id varchar(20) not null,
	TheLoai_id varchar(20) not null,
	Book_name nvarchar(50),
	Nam_xb INT,
	Book_price INT,
	book_amount INT,
	CONSTRAINT pkBook PRIMARY KEY(Book_id),
	FOREIGN KEY(TheLoai_id) REFERENCES TheLoai(TheLoai_id),
)

CREATE TABLE Khach (
	Ma_khach varchar(20) not null,
	Khach_name nvarchar(50) not null,
	PhoneNumber varchar(10),
	Diachi nvarchar(50),
	Email varchar(20),
	MST INT,
	PRIMARY KEY(Ma_khach),
)

CREATE TABLE DonHang (
	Ma_don varchar(20),
	Ma_khach varchar(20),
	NgayMua date not null
	PRIMARY KEY(Ma_don),
	FOREIGN KEY(Ma_khach) REFERENCES Khach(Ma_khach),
)

CREATE TABLE Sell (
	Ma_don varchar(20),
	Book_id varchar(20),
	Sell_quantity INT,
	PRIMARY KEY(Ma_don, Book_id),
	FOREIGN KEY(Ma_don) REFERENCES DonHang(Ma_don),
	FOREIGN KEY(Book_id) REFERENCES Book(Book_id),
)

--1
SELECT * FROM Book
WHERE book_amount < 10;

--2
SELECT COUNT(*) AS CountSach FROM Sell s
JOIN Book b ON s.Book_id = b.Book_id
WHERE Book_name LIKE '%Tâm lý dân tộc An Nam%';

--3
SELECT SUM(b.Book_price* s.Sell_quantity) AS Total FROM Sell s
JOIN Book b ON b.Book_id = s.Book_id
JOIN DonHang d ON s.Ma_don = d.Ma_don
WHERE d.Ma_khach = '01231' AND d.NgayMua <= GETDATE()

SELECT SUM(b.Book_price * s.Sell_quantity) AS TongGiaTri
FROM Sell s
JOIN Book b ON s.Book_id = b.Book_id
JOIN DonHang d ON s.Ma_don = d.Ma_don
JOIN Khach k ON d.Ma_khach = k.Ma_khach
WHERE k.Ma_khach = '01231' AND d.NgayMua <= GETDATE();

--4
CREATE PROCEDURE GetSellIn4
	@bookId varchar(20)
AS
BEGIN 
		SELECT b.book_amount, s.sell_quantity FROM Sell s
		JOIN Book b ON b.Book_id = s.Book_id
		WHERE b.Book_id = @bookId ;
END;

EXEC GetSellIn4 @bookId = '12345';

--5
DELETE FROM DonHang WHERE NgayMua = '25/06/2023'
DELETE FROM Sell
WHERE Ma_don IN (SELECT Ma_don FROM DonHang WHERE NgayMua = '2023-06-25');

