use hw2;

create view company_emp (company, emp_name, emp_email)
as select cmp.cmp_name, emp.emp_name, emp.cmp_email
from cmpemployee as emp
join recompany as cmp on cmp.cmp_num = emp.cmp_num;

create view emp_dept (emp_name, posit, salary, dept_num, dept)
as select emp.emp_name, emp.position, emp.cmp_salary, dept.dept_num, dept.dept_name
from cmpemployee as emp
join department as dept on dept.dept_num = emp.dept_num
where emp.dept_num = 0
with check option;

update emp_dept
set dept_num = 1
where emp_name = 'Gil';

create view simple_custom (name, phone)
as select cus_name, cus_phonenum
from customer;

create view cmp_avg_salary (company, avg_salary)
as select rec.cmp_name, avg(cmpe.cmp_salary)
from recompany as rec
join cmpemployee as cmpe on cmpe.cmp_num = rec.cmp_num
group by cmpe.cmp_num;

create view simple_RE (re_num, price_pyeong, size)
as select re_num, price_pyeong, size
from realestate;

create view manage_branch (company_num, branch_num)
as select cmp_num, br_num
from branch;

select * from company_emp where company like '%o%';