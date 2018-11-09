use practice;

DROP TABLE employee;
DROP TABLE department;

create table department(
	deptno int,
    deptname varchar(32),
    floor int,
    primary key(deptno)
);

create table employee(
	empno int not null,
    empname varchar(32) unique,
    title varchar(32) default '사원',
    manager int,
    salary int check(salary<600000),
    dno int default 1 check(dno in (1,2,3,4,5,6)),
    primary key(empno),
    constraint fk1 foreign key(manager) references employee(empno) on update cascade on delete set null,
    constraint fk2 foreign key(dno) references department(deptno)    
);

INSERT INTO department VALUES (1, '영업', 5), 
(2, '기획', 10),
(3, '개발1부', 9),
(4, '총무', 7),
(5, '연구', 6),
(6, '개발2부', 8);


INSERT INTO employee VALUES (4377, '이성래', '사장', NULL, 5000000, 2),
(3426, '박영권', '과장', 4377, 3000000, 1),
(3011, '이수민', '부장', 4377, 4000000, 3),
(1003, '조민희', '과장', 4377, 3000000, 2),
(2106, '김창섭', '대리', 1003, 2500000, 2),
(3427, '최종철', '사원', 3011, 1500000, 3),
(1365, '김상원', '사원', 3426, 1500000, 1),
(1468, '김철수', '사원', 3426, 1500000, 1),
(1324, '장정현', '사원', 3426, 1500000, 1),
(1158, '김정훈', '사원', 3426, 1500000, 1);

select empname, dno, salary
from employee as e
where salary > (select avg(salary)
				from employee
                where dno = e.dno);

select *
from employee
where empname = '박영권';

select distinct manager
from employee;

select empno as No, empname as Name, title as Position
from employee;

select *
from employee
where empname like '__훈%';

select *
from employee
where empname like '박%' or empname like '_성%';

select *
from employee
where salary >= 2000000 and (dno in (2, 3)) and manager is not null;

select empno, empname, salary
from employee
where title = '과장'
order by salary asc;

DROP TABLE IF EXISTS udepart;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS professor;

CREATE TABLE udepart(
	dno INT NOT NULL,
    dname VARCHAR(20) NOT NULL,
    dean INT,
    PRIMARY KEY (dno)
);

INSERT INTO udepart VALUES 
(1, '소프트웨어', 100100),
(2, '경영', 100110),
(3, '전자', 100125),
(4, '전기', 100108),
(5, '통계', 100200),
(6, '교육', 100350);

CREATE TABLE professor(
	prof_id INT NOT NULL,
    prof_name VARCHAR(20) NOT NULL,
    prof_phone VARCHAR(30),
    prof_salary INT NOT NULL,
    prof_dept INT,
    PRIMARY KEY (prof_id)
);

INSERT INTO professor VALUES 
(100100, '구인영', 01057842139, 6000000, 1),
(100105, '강규희', 01077523944, 5000000, 1),
(100108, '서경배', 01044357710, 5500000, 4),
(100109, '여환준', 01059344953, 5300000, 4),
(100110, '유은규', 01059623496, 3500000, 2),
(100117, '박해련', 01086940398, 3000000, 2),
(100122, '천남준', 01038495293, 3800000, 2),
(100125, '이규진', 01069540384, 4200000, 3),
(100128, '마윤주', 01089494203, 4000000, 3),
(100200, '도성원', 01069843945, 3500000, 5),
(100220, '이보민', 01023185395, 5750000, 5),
(100280, '소규성', 01039852984, 4320000, 5),
(100350, '심진', 01048234955, 3700000, 6),
(100365, '변진일', 01023943956, 3250000, 6),
(100372, '김혜수', 01022324563, 3330000, 6);

CREATE TABLE student(
	std_id INT NOT NULL,
    std_name VARCHAR(20) NOT NULL,
    std_grade INT DEFAULT 1,
    std_age INT NOT NULL,
    std_dept INT,
    std_tutor INT,
    PRIMARY KEY (std_id)
);

INSERT INTO student VALUES
(2015046002, '서의섭', 3, 22, 1, 2014046029),
(2015046008, '손효민', 3, 22, 1, 2014046029),
(2014046029, '도민석', 4, 23, 1, null),
(2014046004, '강성호', 4, 23, 1, null),
(2016046001, '배민설', 2, 21, 1, 2015046002),
(2014044005, '구준혁', 4, 23, 2, null),
(2015044011, '김수전', 3, 22, 2, 2014044005),
(2016044055, '탁규호', 2, 21, 2, 2014044005),
(2016044057, '신민정', 2, 21, 2, 2014044005),
(2014048004, '심미성', 4, 23, 4, null),
(2017048011, '구민하', 1, 20, 4, 2014048004),
(2015055028, '한수중', 3, 22, 6, null),
(2017055020, '장수아', 1, 20, 6, 2015055028),
(2017055033, '구혜인', 1, 20, 6, 2015055028),
(2017055035, '유한별', 1, 20, 6, 2015055028),
(2017055038, '임주상', 1, 20, 6, 2015055028);

SELECT std_id, std_name, std_grade 
 FROM student
 WHERE std_id IN
	(SELECT std_id
	 FROM student
	 WHERE std_tutor IS NOT NULL);
     
select *
from student as s
where s.std_dept in (select d.dno
					from udepart as d
                    join professor as p on d.dean = p.prof_id
					where p.prof_salary > 5000000);
                    
select s.*
from student as s, udepart as d, professor as p
where d.dean = p.prof_id and d.dno = s.std_dept and p.prof_salary > 5000000;