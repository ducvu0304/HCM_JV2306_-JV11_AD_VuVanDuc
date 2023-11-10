CREATE DATABASE test;
USE test;

CREATE TABLE teacher(
	id  		INT AUTO_INCREMENT PRIMARY KEY,
    `name` 		VARCHAR(100) NOT NULL UNIQUE,
    phone		VARCHAR(50) NOT NULL UNIQUE,
	email		VARCHAR(50) NOT NULL UNIQUE,
    birthday	DATE NOT NULL
);

CREATE TABLE class_room(
	id  			INT AUTO_INCREMENT PRIMARY KEY,
    `name` 			VARCHAR(200) NOT NULL,
	total_student 	INT DEFAULT 0,
    start_date	 	DATE,
	end_date	 	DATE	
);

CREATE TABLE teacher_class(
	teacher_id  	INT,
    class_room_id	INT,
	start_date	 	DATE,
	end_date	 	DATE,	
    time_slot_star 	INT,
    time_slot_end	INT,
    PRIMARY KEY(teacher_id, class_room_id),
	CONSTRAINT fk_teacher_class FOREIGN KEY(teacher_id) REFERENCES teacher(id),
    CONSTRAINT fk_class_room FOREIGN KEY(class_room_id) REFERENCES class_room(id)
);


CREATE TABLE student(
	id  			INT AUTO_INCREMENT PRIMARY KEY,
    `name` 			VARCHAR(150) NOT NULL,
    email			VARCHAR(100) NOT NULL UNIQUE,
    phone			VARCHAR(50) NOT NULL UNIQUE,
    gender 			TINYINT NOT NULL CHECK (gender = 1 OR  gender=2),
    class_room_id 	INT,
	CONSTRAINT fk_student_class FOREIGN KEY(class_room_id) REFERENCES class_room(id),
    birthday	DATE NOT NULL
);

CREATE TABLE `subject`(
	id  		INT AUTO_INCREMENT PRIMARY KEY,
    `name` 		VARCHAR(200) NOT NULL UNIQUE
);

CREATE TABLE mark(
	student_id  INT,
    subject_id	INT,
    score 		INT NOT NULL CHECK (score >= 0 AND score <= 10),
    PRIMARY KEY(student_id, subject_id),
	CONSTRAINT fk_mark_student FOREIGN KEY(student_id) REFERENCES student(id),
    CONSTRAINT fk_mark_subject FOREIGN KEY(subject_id) REFERENCES `subject`(id)
);



INSERT INTO teacher(`name`, email, birthday, phone)
VALUES	("Nguyễn Minh Khôi"	, "khoi@gmail.com"	, "1981-12-21", "0955555555"), 
		("Nguyễn Khánh Linh", "linh@gmail.com"	, "1991-12-12", "0966666666"), 
        ("Nguyễn Khôi Minh ", "minh@gmail.com"	, "1981-12-21", "0977777777"), 
		("Nguyễn Linh Khánh ", "khanh@gmail.com", "1991-12-12", "0988888888"), 
        ("Đỗ Khánh Linh"	, "linh2@gmail.com"	, "1999-01-01", "0999999999");


INSERT INTO class_room 	(`name`, total_student, start_date, end_date)
VALUES	("JAV1503", 11, "2023-03-15", "2023-09-15"), 
		("JAV2004", 11, "2023-04-20", "2023-10-20"), 	
		("JAV2306", 11, "2023-06-15", "2023-12-15"), 
		("JAV1508", 11, "2023-08-15", "2024-02-15"), 	
		("JAV0510", 11, "2023-10-05", "2023-03-05");
        
INSERT INTO student (`name`, email, birthday, phone, gender, class_room_id)
VALUES				("Nguyễn Minh Khôi"	, "khoi@gmail.com"	, "1999-12-21", "0955555555", 1, 1), 
					("Nguyễn Khánh Linh", "linh@gmail.com"	, "1998-02-12", "0966666666", 2, 1), 
					("Nguyễn Khôi Minh ", "minh@gmail.com"	, "2000-12-21", "0977777777", 1, 1), 
					("Nguyễn Linh Khánh ", "khanh@gmail.com", "1998-04-01", "0988888888", 1, 2), 
					("Đỗ Khánh Linh"	, "linh2@gmail.com"	, "1999-08-15", "0999999999", 2, 2),
					("Nguyễn Minh"		, "mn@gmail.com"	, "1999-12-21", "0945555555", 1, 3),
					("Nguyễn Khánh"		, "kn@gmail.com"	, "1998-02-12", "0946666666", 2, 3),
					("Nguyễn Khôi"		, "khoin@gmail.com"	, "2000-12-21", "0947777777", 1, 3),
					("Nguyễn Linh"		, "ln@gmail.com"	, "1998-04-01", "0948888888", 1, 4),
					("Đỗ Khánh"			, "kd@gmail.com"	, "1999-08-15", "0949999999", 2, 4),
					("Minh Khôi"		, "km@gmail.com"	, "1999-12-21", "0935555555", 1, 1),
					("Khánh Linh"		, "kl@gmail.com"	, "1998-02-12", "0936666666", 2, 2),
					("Khôi Minh "		, "minhk@gmail.com"	, "2000-12-21", "0937777777", 1, 3),
					("Linh Khánh "		, "khanhl@gmail.com", "1998-04-01", "0938888888", 1, 4),
					("Khánh Linh"		, "linhk@gmail.com"	, "1999-08-15", "0939999999", 2, 2);
        
INSERT INTO `subject` 	(`name`)
VALUES	("Java"	), ("JavaScript"), ("Python"	);
        
INSERT INTO mark (student_id, subject_id, score)
VALUES	(1, 1, 10), (1, 2, 8), (2, 3, 1), (3, 1, 3), (4, 2, 5), 
		(5, 3, 7), (6, 1,	8), (7, 1, 9), (8, 1, 10), (9, 1, 10),
		(10, 2, 2), (11, 2, 6), (12, 2, 4), (13, 3, 10), (14, 3, 10),
		(15, 1, 10), (15, 2, 9), (12, 3, 7),  (2, 1, 6), (3, 2, 6);
        
-- 1. Lấy ra danh sách Student có sắp xếp tăng dần theo Name gồm các cột sau: 
-- Id, Name, Email, Phone, Address, Gender, BirthDay, Age (5đ)
SELECT id, `name`, email, phone, if(gender =1, "Nam", "Nữ") gender, (year(curdate()) - year(birthday)) age
FROM student;

-- 2. Lấy ra danh sách Teacher gồm: Id, Name, Phone, Email, BirthDay, Age, TotalCLass 
-- (Đề không yêu cầu thêm bảng teacher_class nên không truy xuất được TotalClass ) (5đ)
SELECT id, `name`,  phone, email, birthday, (year(curdate()) - year(birthday)) age
FROM teacher;

-- 3. Truy vấn danh sách class_room gồm: Id, Name, TotalStudent, StartDate, EndDate khai giảng năm 2023 (5đ)
SELECT * FROM test.class_room WHERE year(start_date) = 2023;

-- 4. Cập nhật cột ToalStudent trong bảng class_room = Tổng số Student của mỗi class_room theo Id của class_room(5đ)
UPDATE class_room SET total_student = 12 WHERE id = 1;

-- 5. Tạo View v_getStudentInfo thực hiện lấy ra danh sách Student gồm: Id, Name,
-- Email, Phone, Address, Gender, BirthDay, ClassName, MarksAvg, Trong đó cột
-- MarksAvg hiển thị như sau:
-- 0 < MarksAvg <=5 Loại Yếu
-- 5 < MarksAvg < 7.5 Loại Trung bình
-- 7.5 <= MarksAvg <= 8 Loại GIỏi
-- 8 < MarksAvg Loại xuất sắc(5đ)
CREATE VIEW v_getStudentInfo
AS
SELECT s.id, s.`name`, 
	CASE
		WHEN avg(m.score) <= 5 THEN "Yếu"
		WHEN avg(m.score) < 7.5 THEN "Trung bình"
		WHEN avg(m.score) <= 8 THEN "Giỏi"
		ELSE "Xuất sắc"
	END AS "Loại"
FROM mark m 
INNER JOIN student s ON s.id = m.student_id
GROUP BY m.student_id;

-- 6. View v_getStudentMax hiển thị danh sách Sinh viên có điểm trung bình >= 7.5 (5đ)
CREATE VIEW v_getStudentMax
AS
SELECT s.id, s.`name`, avg(m.score) `avg_score`
FROM mark m 
INNER JOIN student s ON s.id = m.student_id
GROUP BY m.student_id
HAVING `avg_score` >= 7.5;

-- 7. Tạo thủ tục thêm mới dữ liệu vào bảng class_room (5đ)
DELIMITER //

CREATE PROCEDURE InserClassRoom(
    IN p_name 		 	VARCHAR(200),
	IN p_total_student 	INT,
    IN p_start_date	 	DATE,
	IN p_end_date	 	DATE	
)
BEGIN
	INSERT INTO class_room 	(`name`, total_student, start_date, end_date)
	VALUES	(p_name, p_total_student, p_start_date, p_end_date);
END //

DELIMITER ;

CALL InserClassRoom	("JAV1512", 15, "2024-03-15", "2024-09-15");
SELECT * FROM test.class_room;

-- 8. Tạo thủ tục cập nhật dữ liệu trên bảng student (5đ)
DELIMITER //

CREATE PROCEDURE updateStudent(
	IN s_id 			INT,
    IN s_name 			VARCHAR(150),
    IN s_email	 	 	VARCHAR(100),
    IN s_phone		 	VARCHAR(50),
    IN s_gender 		TINYINT,
    IN s_class_room_id 	INT,
    IN s_birthday		DATE
)
BEGIN
	UPDATE student
    SET  `name`=s_name, email=s_email, phone=s_phone, gender=s_gender, class_room_id=s_class_room_id, birthday=s_birthday		
	WHERE id = s_id;
END //

DELIMITER ;
CALL updateStudent(1, 'Nguyễn Minh A', "khoi@gmail.com", "0955555555",  1, 1, '2000-01-01');
SELECT * FROM test.student;

-- 9. Tạo thủ tục xóa dữ liệu theo id trên bảng subject (5đ)
DELIMITER //

CREATE PROCEDURE deleteSubjectById(
	IN s_id 			INT
)
BEGIN
	DELETE FROM subject
	WHERE id = s_id;
END //

DELIMITER ;

ALTER TABLE mark DROP CONSTRAINT fk_mark_subject;
CALL deleteSubjectById(1);
SELECT * FROM subject;

-- 10.Tạo thủ tục getStudentPaginate lấy ra danh sách sinh viên có phân trang gồm:
-- Id, Name, Email, Phone, Address, Gender, BirthDay, ClassName, Khi gọi thủ tuc
-- truyền vào limit và page (15đ)
DELIMITER //

CREATE PROCEDURE getStudentPaginate(
	IN p_limit 	INT UNSIGNED,
    IN p_page	INT UNSIGNED
)
BEGIN
	SELECT s.id, s.`name`, s.email, s.phone, if(s.gender =1, "Nam", "Nữ") gender, birthday, c.`name`
	FROM student s
	INNER JOIN class_room c ON c.id = s.class_room_id
	ORDER BY id 
	LIMIT p_limit OFFSET p_page;
END //

DELIMITER ;

CALL getStudentPaginate(5,2);

