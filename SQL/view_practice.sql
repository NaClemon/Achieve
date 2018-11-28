use employees;

create view emp_manager (mng_firstname, mng_lastname, mng_birth, mng_gender, mng_from, mng_to)
as select emp.first_name, emp.last_name, emp.birth_date, emp.gender, depmng.from_date, depmng.to_date
from employees as emp
join dept_manager as depmng on emp.emp_no = depmng.emp_no;

create view emp_in_dept (de_empno, de_firstname, de_lastname, de_gender, de_deptno)
as select emp.emp_no, emp.first_name, emp.last_name, emp.gender, de.dept_no
from employees as emp
join dept_emp as de on emp.emp_no = de.emp_no
where emp.first_name like 'A%'
with check option;

update emp_in_dept
set de_firstname = 'Brain'
where de_empno = 10033;

create view simple_emp (emp_first_name, emp_last_name, emp_gender)
as select first_name, last_name, gender
from employees;

create view dept_avg_salary (dept_no, dept_name, dept_salary)
as select dept.dept_no, dept.dept_name, avg(sl.salary)
from departments as dept
join dept_emp as de on dept.dept_no = de.dept_no
join employees as emp on emp.emp_no = de.emp_no
join salaries as sl on emp.emp_no = sl.emp_no
group by dept.dept_no;

create view emp_title (emp_no, birth_date, first_name, last_name, gender, hire_date, title, from_date)
as select emp.emp_no, emp.birth_date, emp.first_name, emp.last_name, emp.gender, emp.hire_date, tl.title, tl.from_date
from employees as emp
join titles as tl on emp.emp_no = tl.emp_no
where tl.from_date like '1997%';

create view sub_table (emp_no, title, from_date)
as select emp_no, title, from_date
from titles;

insert into sub_table values
(10002, 'Senior Engineer', '1988-02-22'),
(10008, 'Engineer', '2000-06-19');

create view manager_salary (emp_no, dept_no, salary, sl_from, sl_to, manager_from, manager_to)
as select dm.emp_no, dm.dept_no, sl.salary, sl.from_date, sl.to_date, dm.from_date, dm.to_date
from dept_manager as dm
join salaries as sl on dm.emp_no = sl.emp_no
where sl.from_date like '1995%';

update manager_salary
set salary = 96647
where emp_no = 110022;