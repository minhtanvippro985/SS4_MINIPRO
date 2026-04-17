CREATE DATABASE IF NOT EXISTS ELEARNING_MANAGEMENT;
USE ELEARNING_MANAGEMENT;

CREATE TABLE IF NOT EXISTS Students (
    StudentId INT AUTO_INCREMENT PRIMARY KEY,
    FullName NVARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    BirthDate DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Teachers (
    TeacherID INT AUTO_INCREMENT PRIMARY KEY,
    TeacherNAME NVARCHAR(50) NOT NULL,
    TeacherEmail VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Courses (
    CourseID INT AUTO_INCREMENT PRIMARY KEY,
    CourseName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    Duration INT CHECK(Duration > 0),
    TeacherID INT,
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID)
);

CREATE TABLE IF NOT EXISTS Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,		
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollDate DATE DEFAULT (CURRENT_DATE()),
    CONSTRAINT UC_Student_Course UNIQUE (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentId),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

CREATE TABLE IF NOT EXISTS Results (
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    MidtermScore DECIMAL(4,2) CHECK (MidtermScore >= 0 AND MidtermScore <= 10),
    FinalScore DECIMAL(4,2) CHECK (FinalScore >= 0 AND FinalScore <= 10),
    CONSTRAINT UC_Result_Student_Course UNIQUE (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentId),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);




INSERT INTO Teachers (TeacherNAME, TeacherEmail) VALUES  
('Nguyễn Văn A', 'anv@university.edu.vn'),
('Trần Thị B', 'btt@university.edu.vn'),
('Lê Hoàng C', 'clh@university.edu.vn'),
('Phạm Minh D', 'dpm@university.edu.vn'),
('Võ Thị E', 'evt@university.edu.vn');

INSERT INTO Courses (CourseName, Description, Duration, TeacherID) VALUES  
('Tập đánh đàn', 'Khóa học guitar cơ bản', 12, 1),
('Học hát', 'Luyện thanh nhạc online', 24, 2),
('Lập trình Java', 'Cơ bản đến nâng cao', 15, 3),
('Tán gái 101', 'Kỹ năng giao tiếp xã hội', 30, 1),
('Quản trị mạng', 'Hệ thống Cisco', 10, 5);

INSERT INTO Students (FullName, BirthDate, Email) VALUES  
('Lý Tiểu Long', '2004-05-10', 'longlt@student.com'),
('Trần Anh Thư', '2003-11-20', 'thuta@student.com'),
('Nguyễn Gia Bảo', '2005-01-15', 'baong@student.com'),
('Phan Thanh Bình', '2004-08-30', 'binhpt@student.com'),
('Đặng Mỹ Linh', '2004-02-14', 'linhdm@student.com');

-- Thêm Đăng ký học
INSERT INTO Enrollments (StudentID, CourseID, EnrollDate) VALUES  
(1, 1, '2026-04-01'),
(1, 2, '2026-04-01'),
(2, 1, '2026-04-02'),
(3, 3, '2026-04-03'),
(4, 4, '2026-04-05');

INSERT INTO Results (StudentID, CourseID, MidtermScore, FinalScore) VALUES  
(1, 1, 8.5, 9.0),
(1, 2, 7.0, 8.0),
(2, 1, 6.5, 7.5),
(3, 3, 9.0, 9.5),
(4, 4, 5.0, 6.0);




-- cập nhật email sinh viên
UPDATE Students SET Email = "giabao_new@gmail.com" WHERE StudentId = 3;

UPDATE Courses SET Description = "Học đàn chuyên sâu cho người mới" WHERE CourseID = 1;


UPDATE Results SET FinalScore = 9.5 WHERE StudentID = 1 AND CourseID = 1;


DELETE FROM Results WHERE StudentID = 4 AND CourseID = 4;

-- Xóa lượt đăng ký không hợp lệ
DELETE FROM Enrollments WHERE StudentID = 4 AND CourseID = 4;





SELECT * FROM Students;

SELECT * FROM Teachers;

SELECT c.CourseID, c.CourseName, t.TeacherNAME 
FROM Courses c 
LEFT JOIN Teachers t ON c.TeacherID = t.TeacherID;

SELECT e.EnrollmentID, s.FullName, c.CourseName, e.EnrollDate
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentId
JOIN Courses c ON e.CourseID = c.CourseID;

SELECT s.FullName, c.CourseName, r.MidtermScore, r.FinalScore
FROM Results r
JOIN Students s ON r.StudentID = s.StudentId
JOIN Courses c ON r.CourseID = c.CourseID;