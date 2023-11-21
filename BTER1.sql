USE BT1_ER;
CREATE TABLE GiaoVien (
    GV# VARCHAR(30) PRIMARY KEY,
    HoTen VARCHAR(30),
    NamSinh INT,
    DiaChi VARCHAR(50)
);

CREATE TABLE DeTai (
    DT# VARCHAR(30) PRIMARY KEY,
    TenDT VARCHAR(50),
    TheLoai VARCHAR(20)
);

CREATE TABLE SinhVien (
    SV# VARCHAR(30) PRIMARY KEY,
    TenSV VARCHAR(30),
    NgaySinh DATE,
    QueQuan VARCHAR(20),
    Lop VARCHAR(20)
);

CREATE TABLE HuongDan (
    GV# VARCHAR(30),
    DT# VARCHAR(30),
    SV# VARCHAR(30),
    NamThucHien INT,
    KetQua DECIMAL(3, 1),
    PRIMARY KEY (GV#, DT#, SV#, NamThucHien),
    FOREIGN KEY (GV#) REFERENCES GiaoVien(GV#),
    FOREIGN KEY (DT#) REFERENCES DeTai(DT#),
    FOREIGN KEY (SV#) REFERENCES SinhVien(SV#)
);



--a. Đưa ra thông tin về giáo viên có mã là "GV001".
SELECT * FROM GiaoVien WHERE GV# = 'GV001';

--b. Cho biết có bao nhiêu đề tài thuộc thể loại "Ứng dụng".
SELECT COUNT(*) FROM DeTai WHERE TheLoai = 'Ứng dụng' or TheLoai = 'lMAO'

--c. Cho biết giáo viên có mã "GV012" đã hướng dẫn bao nhiêu sinh viên có quê quán ở "Hải Phòng".
SELECT COUNT(*) FROM HuongDan
JOIN SinhVien ON HuongDan.SV# = SinhVien.SV#
WHERE HuongDan.GV# = 'GV012' AND SinhVien.QueQuan = 'Hai Phong';

--d. Cho biết tên của đề tài chưa có sinh viên nào thực hiện.
SELECT TenDT FROM DeTai
LEFT JOIN HuongDan ON DeTai.DT# = HuongDan.DT#
WHERE HuongDan.DT# IS NULL;

--e. Do sơ xuất, thông tin về ngày sinh của sinh viên tên là "Nguyễn Xuân Dũng", 
--quê quán "Hà Nam" đã bị nhập chưa chính xác. 
--Ngày sinh chính xác là "12/11/1991". Hãy cập nhật thông tin này.
UPDATE SinhVien
SET NgaySinh = '1991-11-12'
WHERE TenSV = 'Nguyễn Xuân Dũng' AND QueQuan = 'Hà Nam';

--f. Vì lý do khách quan, sinh viên "Lê Văn Luyện", quê quán "Bắc Giang" đã xin thôi học. Hãy xóa toàn bộ thông tin liên quan đến sinh viên này.
DELETE 
FROM HuongDan
WHERE SV# = (SELECT SV# FROM SinhVien
			WHERE SinhVien.TenSV = 'Lê Văn Luyện' 
			AND SinhVien.QueQuan = 'Bắc Giang')




