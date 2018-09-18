use test;

create table major(
	deptid int,
    deptname varchar(30) not null,
    floor int,
    primary key(deptid)
);

create table student(
	stdid int,
    stdname varchar(30) not null,
    stdphone varchar(30),
    dno int,
    primary key(stdid),
    foreign key(dno) references major(deptid) on delete set null
);

create table professor(
	profid int,
    profname varchar(30) not null,
    salary int default 1000000,
    dno int,
    primary key(profid),
    foreign key(dno) references major(deptid) on delete set null
);

insert into major values
(1, '소프트웨어학과', 7),
(2, '물리학과', 5),
(3, '경영학과', 3),
(4, '국어국문학과', 11),
(5, '의예과', 2),
(6, '간호학과', 6),
(7, '컴퓨터공학과', 1),
(8, '건축학과', 4),
(9, '안전공학과', 6),
(10, '공업화학과', 9);

insert into student values
(1, 'sam', '01047296738', 3),
(2, 'john', '01070383057', 5),
(3, 'may', '01038571029', 1),
(4, 'kanya', '01057102948', 7),
(5, 'lee', '010634023812', 1),
(6, 'megan', '01067192384', 3),
(7, 'dominic', '01067102938', 8),
(8, 'arno', '01060932447', 6),
(9, 'cornor', '01067081209', 2),
(10, 'tim', '01012905892', 7);

insert into professor values
(1, 'dumble', 4000000, 2),
(2, 'yoon', 2400000, 1),
(3, 'resting', 5200000, 5),
(4, 'colin', 3500000, 5),
(5, 'agem', 4700000, 7),
(6, 'miranda', 2900000, 6),
(7, 'justin', 3300000, 10),
(8, 'ariana', 2100000, 1),
(9, 'harry', 3600000, 5),
(10, 'clony', 2900000, 8);

select * from student;

select * from major;

delete from major where deptid=5;

select * from major;

select * from student;

select * from professor;

select profname from professor where salary >=3000000;

select * from student where stdname like 'm%';

select * from professor where dno is null;

select stdid, stdname, stdphone from student where dno=1 or dno=3 or dno=5 order by stdid desc;