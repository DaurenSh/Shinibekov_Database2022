--1)

--a)
SELECT * FROM dealer FULL CROSS JOIN client c on dealer.id = c.dealer_id

--b)

SELECT dealer.id, dealer.name, dealer.location, client.name, client.city, client.priority, sell.id, sell.date, sell.amount FROM dealer join client on dealer.id = client.dealer_id join sell on dealer.id = sell.dealer_id and client.id = sell.client_id

--c)

SELECT * FROM dealer join client c on dealer.location=c.city

--d)

SELECT sell.id, sell.amount, c.name, c.city from sell join client c on c.id = sell.client_id where sell.amount between 100 and 500

--e)

SELECT Count(d.id) from dealer as d left outer join
    client as c on d.id = c.dealer_id group by d.id,d.name,d.location,d.charge,c.id,c.name having Count(d.id) > 2;
--f)

Select c.name, c.city, d.name, (sell.amount)*d.charge as "commission" from sell join client c on c.id = sell.client_id join dealer d on d.id = sell.dealer_id

--g)

Select c.name, c.city, d.name, (sell.amount)*d.charge as "commission" from sell join client c on c.id = sell.client_id join dealer d on d.id = sell.dealer_id where d.charge>0.12 --Азамата нет

--h)

SELECT c.name,c.city,s.id,s.date,s.amount,d.name,d.charge from client as c inner join dealer as d on d.id = c.dealer_id
inner join sell s on c.id = s.client_id;

--i)

SELECT c.name,c.priority,d.name,s.id,s.amount from client as c join dealer as d on d.id = c.dealer_id join
    sell as s on c.id = s.client_id where s.amount > 2000 and c.priority is not null;

--2)

--a)

--select avg(sell.amount), max(sell.amount) from sell group by sell.date

create view Av as select count(distinct(client_id)), avg(sell.amount), max(sell.amount) from sell group by sell.date

--b)

create view Bv as select sum(sell.amount) from sell group by sell.date order by sum(sell.amount) desc limit 5

--c)

create view Cv as select count(dealer_id), avg(sell.amount), sum(sell.amount), dealer_id from sell group by dealer_id

--d)

create view Dv as Select d.location, sum((sell.amount)*d.charge) as "commission" from sell join dealer d on d.id = sell.dealer_id group by d.location

--e)

create view Ev as Select d.location, count(dealer_id), avg((sell.amount)*d.charge), sum((sell.amount)*d.charge) as "commission" from sell join dealer d on d.id = sell.dealer_id group by d.location

--f)

create view Fv as Select c.city, count(c.city), avg(sell.amount), sum(sell.amount) from sell join client c on c.id = sell.client_id group by c.city

--g)
create view Gv as SELECT c.city from client as c join sell s on c.id = s.client_id where c.priority > s.amount;
select * from Gv;
