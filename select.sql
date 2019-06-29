# 1.查询同时存在1课程和2课程的情况
SELECT student.* FROM student, student_course
WHERE student.id = student_course.studentId AND student_course.courseId = 1
AND EXISTS
(SELECT 1 FROM student_course stuc
WHERE student_course.studentId = stuc.studentId AND stuc.courseId = 2);

# 2.查询同时存在1课程和2课程的情况
SELECT student.* FROM student, student_course
WHERE student.id = student_course.studentId AND student_course.courseId = 1
AND EXISTS
(SELECT 1 FROM student_course stuc
WHERE student_course.studentId = stuc.studentId AND stuc.courseId = 2);

# 3.查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
select  stu.id,stu.name,AVG(stuc.score)  from student stu,student_course stuc 
where stu.id = stuc.studentId
GROUP BY stu.id HAVING AVG(stuc.score) > 60

# 4.查询在student_course表中不存在成绩的学生信息的SQL语句
select stu.id, stu.name, ifnull(cast(avg(stuc.score) as decimal(18,2)),0) avg_score
from student stu left join student_course stuc
on stu.id = stuc.studentId
group by stu.id , stu.name
having ifnull(cast(avg(stuc.score) as decimal(18,2)),0) = 0

# 5.查询所有有成绩的SQL
select stu.id, stu.name, count(stuc.courseId), sum(score)
from student stu , student_course stuc
where stu.id = stuc.studentId
group by stu.id, stu.name
order by sum(score) desc

# 6.查询学过编号为1并且也学过编号为2的课程的同学的信息
SELECT student.* FROM student, student_course
WHERE student.id = student_course.studentId AND student_course.courseId = 1
AND EXISTS
(SELECT 1 FROM student_course stuc
WHERE student_course.studentId = stuc.studentId AND stuc.courseId = 2);

# 7.检索1课程分数小于60，按分数降序排列的学生信息
select stu.* , stuc.courseId , stuc.score from student stu, student_course stuc
where stu.id = stuc.studentId and stuc.score < 60 and stuc.courseId = 1
order by stuc.score desc

# 8.查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列
select c.id , c.name , cast(avg(stuc.score) as decimal(18,2)) avg_score
from course c, student_course stuc
where c.id = stuc.courseId
group by c.id , c.name
order by avg_score desc, c.id asc

# 9.查询课程名称为"数学"，且分数低于60的学生姓名和分数
select stu.name , score
from student stu, student_course stuc, course c
where stuc.studentId = stu.id and stuc.courseId = c.id and c.name = '数学' and score < 60