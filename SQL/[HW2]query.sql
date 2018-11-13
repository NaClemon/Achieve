# Riot, Ubisoft, Nexon의 지점에 근무하는 매니저가 아닌 직원들의 정보
# Informations of employees(except manager) working at Riot or Ubisoft or Nexon
select bre.*
from bremployee as bre
join bremployee as brem on bre.manager_num = brem.bremp_num
where bre.cmp_num in (select cmp_num
						from recompany
                        where cmp_name in ('Riot', 'Ubisoft', 'Nexon'));

# 부동산이 등록된 지점의 회사, 해당 지점의 매니저, 부동산 번호, 등록 날짜 출력
# Print company of branch where properties are registered, branch's manager, property's number, registered date
select rec.cmp_name, brem.br_name as branch_manager, re.re_num, regi.regi_date as registered_date
from recompany as rec
join register as regi on regi.cmp_num = rec.cmp_num
join bremployee as brem on brem.cmp_num = rec.cmp_num
join realestate as re on re.re_num = regi.re_num
where brem.manager_num is null;

# 회사, 회사의 주소, 회사 직원들의 평균 월급을 출력. 평균 월급의 내림차순으로 정렬
# Print company's name, company's address, and employee's average salary of company.
# Sort by average salary in descending order
select rec.cmp_name as company, rec.si, rec.gu, rec.dong, avg(cmpe.cmp_salary) as avg_salary
from recompany as rec
join cmpemployee as cmpe on cmpe.cmp_num = rec.cmp_num
group by cmpe.cmp_num
having avg(cmpe.cmp_salary)
order by avg(cmpe.cmp_salary) desc;

# 거래에 대해 거래 회사, 고객, 고객의 생년 출력. 시세와 거래가 및 그 차이를 확인
# Print company, customer, the year of customer's birth about the trade
# Check market price, trade price, and profit
select cmp.cmp_name as trading_company, cus.cus_name as customer,
	left(cus.cus_birth, 4) as cus_birth_year,
	(re.price_pyeong*re.size) as market_price, tr.price as trade_price,
    (tr.price - (re.price_pyeong*re.size)) as profit
from trade as tr
join realestate as re on tr.re_num = re.re_num
join recompany as cmp on tr.cmp_num = cmp.cmp_num
join customer as cus on tr.cus_num = cus.cus_num;

# 이름에 'e'가 들어가는 사원의 이름, 직책, 월급, 멘토 이름, 멘토 직책, 사원의 부서를 출력
# print employee's name with 'e' in the name, position, salary, mentor's name, mentor's position, and
# department where the employee is working
select cmpe.emp_name, cmpe.position as emp_position, cmpe.cmp_salary as emp_salary,
		mento.emp_name as metor_name, mento.position as metor_position,
        dept.dept_name as emp_department
from cmpemployee as cmpe
join cmpemployee as mento on mento.cmpemp_num = cmpe.mentor_num
join department as dept on cmpe.dept_num = dept.dept_num
where cmpe.mentor_num is not null and cmpe.emp_name like '%e%'
order by cmpe.cmp_salary desc;

# Check on update cascade
update Branch
set br_num = 0
where cmp_num = 1;

# Check on delete set null, cascade
delete
from Branch
where cmp_num = (select cmp_num
				from recompany
                where cmp_name = 'Temp');