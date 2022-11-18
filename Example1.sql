create table persons(
    personID int not null primary key,
    lastname varchar(255) not null,
    firstname varchar(255) not null,
    age int not null
);

create table orders(
    orderID int not null primary key,
    ordername char(5) not null,
    personID int not null,
    constraint fk_orders_person foreign key (personID) references persons(personID)
);

alter table persons
add email varchar(255);

alter table persons
modify firstname varchar(200);

alter table persons
rename column firstname to namadepan;

alter table persons

drop column email;

rename persons to orang;

desc orang;

desc orders;

create table test(
    id integer
);

desc test;

drop table test;

desc customer;

rename orang to customer;

insert into customer (
    personid, lastname, namadepan, age
) values (1, 'riski', 'ilyas', 19);

create view personss as select * from customer;

insert into customer values(2, 'iksir', 'sayli', 91);

create view cuss as select * from customer;

insert into cuss values (3, 'aa', 'bb', 19);

select * from customer;