use test;

create table Bank (
	code int not null,
    name varchar(50),
    address varchar(100),
    primary key(code)
);

create table Customer (
	ssn int not null,
    name varchar(50),
    phone varchar(50),
    address varchar(50),
    primary key(ssn)
);

create table BankBranch (
	code int,
    branchno int not null,
    address varchar(50),
    foreign key(code) references Bank(code) on delete set null,
    primary key(branchno, code)
);

create table Loan (
	ssn int,
    loanno int not null,
    amount int,
    type varchar(50),
    foreign key(ssn) references Customer(ssn) on delete set null,
    primary key(loanno, ssn)
);

create table Account (
	ssn int,
    acctno int not null,
    balance varchar(50),
    type varchar(50),
    foreign key(ssn) references Customer(ssn) on delete set null,
    primary key(acctno, ssn)
);

create table take (
	ssn int,
    loanno int,
    foreign key(ssn) references Customer(ssn) on delete set null,
    foreign key(loanno) references Loan(loanno) on delete set null,
    primary key(ssn, loanno)
);

create table associate (
	ssn int,
    acctno int,
    foreign key(ssn) references Customer(ssn) on delete set null,
    foreign key(acctno) references Account(acctno) on delete set null,
    primary key(ssn, acctno)
);