select *
from employees
where last_name = 'Peron';

create index tree
on employees (last_name);

drop index tree
on employees;

select emp_no, first_name, hire_date
from employees
where first_name like 'M%' and hire_date like '1995%'
limit 0, 300000;

create index tree1
on employees (first_name, hire_date);

drop index tree1
on employees;

select emp_no, last_name, birth_date, gender
from employees
where last_name like 'R%' and emp_no >= 50000
limit 0, 300000;

create index tree2
on employees (last_name, emp_no);

drop index tree2
on employees;

select emp_no, birth_date
from employees
where birth_date like '1959%'
limit 0, 300000;

create index tree3
on employees (birth_date);

drop index tree3
on employees;

select *
from employees
where gender = 'M'
limit 0, 300000;

create index tree4
on employees (emp_no);

drop index tree4
on employees;
