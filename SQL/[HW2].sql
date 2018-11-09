use hw2;

create table RECompany (
	cmp_num int not null,
	cmp_name varchar(32) not null,
	si varchar(16),
	gu varchar(16),
	dong varchar(16),
	primary key (cmp_num)
);

create table Department (
	dept_num int not null,
	dept_name varchar(32),
	floor int,
	primary key (dept_num)
);

create table CMPEmployee (
	cmpemp_num int not null,
	emp_name varchar(32) not null,
	position varchar(16),
	cmp_salary int not null,
	cmp_email varchar(64),
	mentor_num int,
	cmp_num int,
	dept_num int,
	primary key (cmpemp_num),
	foreign key (mentor_num) references CMPEmployee(cmpemp_num) on delete set null on update cascade,
	foreign key (cmp_num) references RECompany(cmp_num) on delete cascade on update cascade,
	foreign key (dept_num) references Department(dept_num) on delete set null on update cascade
);

create table Branch (
	cmp_num int not null,
	br_num int not null,
	contact_num varchar(32),
	si varchar(16),
	gu varchar(16),
	dong varchar(16),
	foreign key (cmp_num) references RECompany(cmp_num) on delete cascade on update cascade,
	primary key (cmp_num, br_num)
);

create table BREmployee (
	bremp_num int not null,
	br_name varchar(32),
	br_salary int not null,
	br_email varchar(64),
	cmp_num int,
	br_num int,
	manager_num int,
	primary key (bremp_num),
	foreign key (cmp_num, br_num) references Branch(cmp_num, br_num) on delete cascade on update cascade,
	foreign key (manager_num) references BREmployee(bremp_num) on delete set null on update cascade
);

create table Customer (
	cus_num int not null,
	cus_name varchar(32),
	cus_birth date not null,
	cus_phonenum varchar(32),
	primary key (cus_num)
);

create table Realestate (
	re_num int not null,
	price_pyeong int not null,
	size int not null,
	si varchar(16),
	gu varchar(16),
	dong varchar(16),
	primary key (re_num)
);

create table Register (
	cmp_num int,
	br_num int,
	re_num int,
	regi_date date,
	foreign key (cmp_num, br_num) references Branch(cmp_num, br_num) on delete cascade on update cascade,
	foreign key (re_num) references Realestate(re_num) on delete cascade on update cascade,
	primary key (cmp_num, br_num, re_num)
);

create table Trade (
	re_num int,
	cmp_num int,
	br_num int,
	cus_num int,
	price int,
	trade_date date,
	foreign key (re_num) references Realestate(re_num) on delete cascade on update cascade,
	foreign key (cmp_num, br_num) references Branch(cmp_num, br_num) on delete set null on update cascade,
	foreign key (cus_num) references Customer(cus_num) on delete set null on update cascade,
	primary key (re_num)
);

create table BranchAccount (
	cmp_num int,
	br_num int,
	account_num varchar(64),
	foreign key (cmp_num, br_num) references Branch(cmp_num, br_num) on delete cascade on update cascade,
	primary key (cmp_num, br_num, account_num)
);