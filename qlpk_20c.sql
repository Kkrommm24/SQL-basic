
CREATE TABLE patients (
  patient_id VARCHAR(10) PRIMARY KEY,
  patient_name NVARCHAR(20),
  patient_address NVARCHAR(100),
  patient_phone NVARCHAR(15),
  patient_age INT,
  patient_gender VARCHAR(1),
  medical_history NVARCHAR(255)
);


CREATE TABLE doctors (
  doctor_id VARCHAR(10) PRIMARY KEY,
  doctor_name NVARCHAR(50),
  doctor_address NVARCHAR(100),
  doctor_phone VARCHAR(15),
  doctor_gender VARCHAR(1),
  doctor_age INT,
  specialty NVARCHAR(50)
);


CREATE TABLE Location (
  loc_id varchar(10) PRIMARY KEY,
  loc_name NVARCHAR(50),
  loc_address NVARCHAR(100)
)

CREATE TABLE appointments (
  appointment_id INT PRIMARY KEY,
  appointment_date DATE,
  appointment_time TIME(0),
  patient_id VARCHAR(10),
  doctor_id VARCHAR(10),
  loc_id VARCHAR(10),
  description NVARCHAR(255),
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
  FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
  FOREIGN KEY (loc_id) REFERENCES location(loc_id)
);


CREATE TABLE treatments (
  treatment_id varchar(10) PRIMARY KEY,
  patient_id VARCHAR(10),
  doctor_id VARCHAR(10),
  treatment_date DATE,
  treatment_notes NVARCHAR(255),
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
  FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- Thêm dữ liệu vào bảng patients
INSERT INTO patients (patient_id, patient_name, patient_address, patient_phone, patient_age, patient_gender, medical_history)
VALUES
    ('P001', 'John Doe', '123 Main St', '123-456-7890', 35, 'M', 'None'),
    ('P002', 'Jane Smith', '456 Elm St', '987-654-3210', 42, 'F', 'High blood pressure'),
    ('P003', 'Michael Johnson', '789 Oak St', '555-123-4567', 60, 'M', 'Diabetes'),
	('P005',  N'Hưng Gia', N'Mai Dịch, Cầu Giấy', '0915312332', 18, 'M', N'Nô');

-- Thêm dữ liệu vào bảng doctors
INSERT INTO doctors (doctor_id, doctor_name, doctor_address, doctor_phone, doctor_gender, doctor_age, specialty)
VALUES
    ('D001', 'Dr. Smith', '789 Park Ave', '555-111-2222', 'M', 40, 'Cardiology'),
    ('D002', 'Dr. Johnson', '456 Elm St', '555-222-3333', 'F', 35, 'Dermatology'),
    ('D003', 'Dr. Brown', '123 Main St', '555-444-5555', 'M', 50, 'Orthopedics');

-- Thêm dữ liệu vào bảng location
INSERT INTO Location (loc_id, loc_name, loc_address)
VALUES
    (1, 'Clinic A', '123 Main St'),
    (2, 'Clinic B', '456 Elm St');

-- Thêm dữ liệu vào bảng appointments
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, patient_id, doctor_id, loc_id, description)
VALUES
    (1, '2023-06-05', '09:00:00', 'P001', 'D001', 1, 'Regular check-up'),
    (2, '2023-06-05', '10:30:00', 'P002', 'D002', 2, 'Skin allergy'),
    (3, '2023-06-06', '14:00:00', 'P003', 'D003', 1, 'Fractured leg'),
	(5, '2023-06-06', '15:00:00', 'P005', 'D003', 1, N'Dạ dày');

-- Thêm dữ liệu vào bảng treatments
INSERT INTO treatments (treatment_id, patient_id, doctor_id, treatment_date, treatment_notes)
VALUES
    (1, 'P001', 'D001', '2023-06-05', 'Prescribed medication for common cold'),
    (2, 'P002', 'D002', '2023-06-05', 'Administered corticosteroid cream for skin allergy'),
    (3, 'P003', 'D003', '2023-06-06', 'Performed surgery to fix fractured leg'),
	(5, 'P005', 'D003', '2023-06-06', 'Performed surgery for stomach');



--DROP TABLE patients
--DROP TABLE doctors
--DROP TABLE Location
--DROP TABLE treatments
--DROP TABLE appointments
ALTER TABLE appointments ADD CONSTRAINT UC_appointments_date_time UNIQUE (appointment_date, appointment_time);

--1
SELECT * FROM patients;
--2
SELECT * FROM doctors;
--3
SELECT * FROM appointments;
--4
SELECT * FROM treatments;
--5
SELECT * FROM Location;
--6 
SELECT * FROM patients WHERE patient_id = 'P002';
--7
SELECT * FROM patients WHERE patient_age > 30;
--8
SELECT doctor_name, doctor_phone FROM doctors 
WHERE doctor_gender = 'M';
--9
SELECT * FROM appointments 
WHERE appointment_date = CONVERT(DATE, GETDATE());
--10
SELECT * FROM doctors 
WHERE specialty = 'Cardiology';
--11
SELECT * FROM appointments 
WHERE patient_id = (SELECT patient_id FROM patients 
					WHERE patient_name LIKE N'%Hưng Gia%');
--12 
SELECT * FROM appointments WHERE doctor_id LIKE 'D001';
--13
SELECT * FROM appointments WHERE appointment_id = 1;
--14
SELECT * FROM treatments WHERE patient_id LIKE 'P003';
--15
SELECT * FROM appointments 
WHERE loc_id = (SELECT loc_id FROM location 
				WHERE loc_name LIKE '%Clinic A%');
--16
SELECT COUNT(*) AS number_of_malepatients FROM patients 
WHERE patient_gender = 'M';
--17
SELECT * FROM appointments 
ORDER BY appointment_date, appointment_time;
--18
SELECT a.appointment_id, p.patient_name, d.doctor_name
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id;
--19
SELECT d.doctor_id, d.doctor_name, COUNT(a.appointment_id) AS total_appointments
FROM doctors d
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.doctor_name;
--20
SELECT a.appointment_id, a.appointment_date, a.appointment_time, p.patient_name
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
ORDER BY a.appointment_date DESC, a.appointment_time DESC;
--21
SELECT *
FROM patients
WHERE patient_age > (SELECT AVG(patient_age) FROM patients);
--22 lấy thứ trong tuần và số lượng cuộc hẹn của từng ngày
SELECT DATEPART(WEEKDAY, appointment_date) AS weekday, COUNT(*) AS appointment_count
FROM appointments
GROUP BY DATEPART(WEEKDAY, appointment_date);

INSERT INTO patients (patient_id, patient_name, patient_address, patient_phone, patient_age, patient_gender, medical_history)
SELECT 'P006', 'Tommi Xiaomi', '123 Main Street', '123456789', 30, 'M', 'Lung disease'
WHERE NOT EXISTS (SELECT * FROM patients WHERE patient_id = 'P006');

INSERT INTO appointments (appointment_id, appointment_date, appointment_time, patient_id, doctor_id, loc_id, description)
VALUES (4, '2023-06-05', '09:30:00', 'P006', 'D001', 2, 'General check-up');
--23
UPDATE a
SET a.doctor_id = 'D001'
FROM appointments AS a
JOIN patients AS p ON a.patient_id = p.patient_id
WHERE p.patient_id = 'P001' AND p.patient_name LIKE '%John Doe%';






