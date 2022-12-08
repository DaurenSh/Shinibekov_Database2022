CREATE DATABASE lab7;
--1
create or replace function oneA(val integer) returns integer AS $$
    BEGIN
    return val+1;
    end;$$
language plpgsql;

select oneA(10);

create or replace function oneB(a integer, b integer) returns integer AS $$
    BEGIN
    return a+b;
    end;$$
language plpgsql;

select oneB(1,2);

create or replace function oneC(a integer) returns boolean AS $$
    BEGIN
        return a%2=0 and a!=0;
    end;$$
language plpgsql;

select oneC(0);

create or replace function oneD(a varchar) returns boolean AS $$
    BEGIN
        return a='Hello';
    end;$$
language plpgsql;

select oneD('Hello');

create or replace function oneE(a varchar, out word varchar, out letters integer) AS $$
    BEGIN
        select into word reverse(a);
        select into letters length(a);
    end;$$
language plpgsql;

select oneE('Hello');


--2
--A
create table forA(
  timeoftrig timestamp
);

create table person(
  name varchar
);


create or replace function twoA()
    returns trigger
    AS
$$
Begin
    if new.name <> old.name then
        insert into forA(timeoftrig)
        values(now());
    end if;
    return new;
end;
$$
language plpgsql;

create or replace trigger trigone
    before update
    on person
    for each row
    execute procedure twoA();

insert into person(name)
values('Bob');

select * from person;

update person
set name = 'Tom'
where name = 'Bob';

select * from forA;

--B

drop table ageofp;
drop table human;

create table ageofp(
      age interval
);
create table human(
      birth date
);


select * from human;
select * from ageofp;

insert into human(birth)
values(date '2001-12-12');


create or replace function twoB()
    returns trigger
    AS
$$
Begin
    insert into ageofp(age)
    values(age(now(),new.birth));
    return new;
end;
$$
language plpgsql;

create or replace trigger trigB
    before insert
    on human
    for each row
    execute procedure twoB();

--C
create table product(
    price integer
);

drop table product;

select *from product;

insert into product(price)
values (100);

create or replace function twoC()
    returns trigger
    AS
$$
Begin
    new.price=new.price*1.12;
    return new;
end;
$$
language plpgsql;

create or replace trigger trigC
    before insert
    on product
    for each row
    execute procedure twoC();

--d

create or replace function twoD()
    returns trigger
    AS
$$
Begin
    perform old.price+2;
    return new;
end;
$$
language plpgsql;

create or replace trigger prevent
    before delete
    on product
    for each row
    execute procedure twoD();

delete from product where price =112;

select *from product;

--e
create table forE(
    word varchar
);
drop table forE;

select *from forE;

insert into forE(word) values('Hello');

create or replace function twoE()
    returns trigger as $$
begin
    raise notice '%', oneD(new.word);
    raise notice '%', oneE(new.word);
    return new;
end; $$
language plpgsql;

create or replace trigger trigE
    after insert
    on forE
    for each row
    execute procedure twoE();

--3

create table ex3(
    id integer primary key ,
    name varchar,
    date_of_birth date,
    age integer,
    salary integer,
    workexperience integer,
    discount integer
);

drop table ex3;

create or replace procedure A(
    id integer ,
    name varchar,
    date_of_birth date,
    age integer,
    salary integer,
    workexperience integer,
    discount integer
)
language plpgsql
as $$
    begin
        update ex3
        set salary=salary*(workexperience/2)*1.1;
        update ex3
        set discount=discount*1.01
        where workexperience>5;
    end;
$$

create or replace procedure B(
    id integer ,
    name varchar,
    date_of_birth date,
    age integer,
    salary integer,
    workexperience integer,
    discount integer
)
language plpgsql
as $$
    begin
        update ex3
        set salary=salary*1.15
        where age>=40;
        update ex3
        set salary=salary*1.15
        where workexperience>=8;
        update ex3
        set discount=discount*1.2
        where workexperience>=8;
    end;
$$