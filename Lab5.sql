CREATE DATABASE lab4;
DROP DATABASE lab4;

CREATE TABLE Warehouses(
    code integer not null primary key,
    location varchar(255) not null,
    capacity integer not null
);

CREATE TABLE Boxes(
    code character(4) not null primary key,
    contents character varying(255) not null,
    value real not null,
    warehouses integer not null,
    foreign key (warehouses) references Warehouses(code)
);

4
SELECT * from Warehouses;

5
SELECT * from Boxes where value>150;

6
SELECT DISTINCT on(contents) * from Boxes;

7
SELECT warehouses, count(code) from boxes group by warehouses;

8
SELECT warehouses, count(code) from boxes group by warehouses having count(code)>2;

9
INSERT INTO Warehouses(code, location, capacity) VALUES (6, 'New York', 3);

SELECT * from Warehouses order by asc;

10
INSERT INTO Boxes(code, contents, value, warehouses) VALUES ('H5RT', 'Papers', 200, 2);

11
UPDATE boxes SET value = (value*0.85) where code = (SELECT code FROM boxes where value = (select distinct on(value) from boxes ));

12
DELETE FROM boxes WHERE value < 150;

13
DELETE FROM boxes WHERE warehouses in (select code from warehouses where location = 'New York') returning *;