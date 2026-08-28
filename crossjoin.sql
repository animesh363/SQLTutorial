CREATE TABLE Students (
    student_id INT,
    student_name VARCHAR(50)
);

CREATE TABLE Courses (
    course_id INT,
    course_name VARCHAR(50)
);

INSERT INTO Students VALUES
(1, 'Animesh'),
(2, 'Rahul'),
(3, 'Priya');

INSERT INTO Courses VALUES
(101, 'SQL'),
(102, 'Java');

SELECT * FROM Courses;
SELECT * FROM Students;

SELECT * 
FROM Courses
CROSS JOIN Students;


-- Output

-- | student_id | student_name | course_id | course_name |
-- | ---------: | ------------ | --------: | ----------- |
-- |          1 | Animesh      |       101 | SQL         |
-- |          1 | Animesh      |       102 | Java        |
-- |          2 | Rahul        |       101 | SQL         |
-- |          2 | Rahul        |       102 | Java        |
-- |          3 | Priya        |       101 | SQL         |
-- |          3 | Priya        |       102 | Java        |
