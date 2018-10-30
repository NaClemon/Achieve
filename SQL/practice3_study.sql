select prof_dept as department, count(*) as personal
from professor
group by prof_dept;

select std_dept as department, count(*) as std_count, min(std_age) as min_age
from student
group by std_dept
having min_age >= 21;

select prof_dept as department, min(prof_salary) as min_salary
from professor
group by prof_dept
having min_salary >= 3500000;

select prof_dept as department, max(prof_salary) as Max, min(prof_salary) as Min,
avg(prof_salary) as Avg
from professor
group by prof_dept
having Max <= 4000000;

select *
from department
join professor
on professor.prof_dept = department.dno;

select *
from professor as p, department as d
where p.prof_dept = d.dno;

select *
from student as s1
join student as s2
on s1.std_tutor = s2.std_id;

select *
from student as s1, student as s2
where s1.std_tutor = s2.std_id;

-- Practice 2
select std_id, std_name, dname, prof_name
from student as s, department as d, professor as p
where s.std_dept = p.prof_dept
and d.dname = '소프트웨어' and d.dean = p.prof_id;

select std_id, std_name, std_grade
from student
where std_id = (select std_id
				from student
                where std_name = '구민하');

select s.std_id, s.std_name, s.std_grade, s.std_dept
from student as s
join department as d on s.std_dept = d.dno
where d.dname = '소프트웨어' or d.dname = '전기';

-- Practice 3
select s.std_id, s.std_name, s.std_dept, d.dname
from student as s
join department as d on s.std_dept = d.dno
where s.std_name like '구%' and s.std_tutor is not null;

-- Practice 4
select s.*
from student as s
join department as d on s.std_dept = d.dno
join professor as p on d.dean = p.prof_id
where p.prof_salary > 5000000;

select *
from student as s
where s.std_dept in (select d.dno
					from department as d
                    join professor as p on d.dean = p.prof_id
					where p.prof_salary > 5000000);