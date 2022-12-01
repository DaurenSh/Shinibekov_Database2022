--1)

--a)
SELECT * FROM dealer FULL JOIN client c on dealer.id = c.dealer_id

--b)

SELECT dealer.id, dealer.name, dealer.location, client.name, client.city, client.priority, sell.id, sell.date, sell.amount FROM dealer join client on dealer.id = client.dealer_id join sell on dealer.id = sell.dealer_id and client.id = sell.client_id

--c)

SELECT * FROM dealer join client c on dealer.location=c.city

--d)

SELECT sell.id, sell.amount, c.name, c.city from sell join client c on c.id = sell.client_id where sell.amount between 100 and 500

--e)

--select * from dealer where dealer.id not in (SELECT dealer_id from client group by client.dealer_id having count(client.dealer_id)>0)

--Select * from sell full outer join client c on sell.client_id = c.id join dealer d on d.id = sell.dealer_id where sell.dealer_id not in (SELECT dealer_id from client group by client.dealer_id having count(client.dealer_id)>0) or not in (SELECT dealer_id from client group by client.dealer_id having count(client.dealer_id)=0)    --c.dealer_id is null or d.id is null

--f)

Select c.name, c.city, d.name, (sell.amount)*d.charge as "commission" from sell join client c on c.id = sell.client_id join dealer d on d.id = sell.dealer_id

--g)

--Select c.name, c.city, d.name, (sell.amount)*d.charge as "commission" from sell join client c on c.id = sell.client_id join dealer d on d.id = sell.dealer_id where d.charge>0.12 --Азамата нет

--h)

--Select * from sell full outer join client c on sell.client_id = c.id join dealer d on d.id = sell.dealer_id where sell.dealer_id not in (SELECT dealer_id from client group by client.dealer_id having count(client.dealer_id)>0) or (select sell.dealer_id where amount>2000) --or (SELECT dealer_id from client group by client.dealer_id having count(client.dealer_id)=0)

--i)


--2)

--a)

--select avg(sell.amount), max(sell.amount) from sell group by sell.date

select count(distinct(client_id)), avg(sell.amount), max(sell.amount) from sell group by sell.date

--b)

select sum(sell.amount) from sell group by sell.date order by sum(sell.amount) desc limit 5

--c)

select count(dealer_id), avg(sell.amount), sum(sell.amount), dealer_id from sell group by dealer_id

--d)

Select d.location, sum((sell.amount)*d.charge) as "commission" from sell join dealer d on d.id = sell.dealer_id group by d.location

--e)

Select d.location, count(dealer_id), avg((sell.amount)*d.charge), sum((sell.amount)*d.charge) as "commission" from sell join dealer d on d.id = sell.dealer_id group by d.location

--f)

Select c.city, count(c.city), avg(sell.amount), sum(sell.amount) from sell join client c on c.id = sell.client_id group by c.city

--g)
select * from sell

Select d.location, sum(sell.amount) from sell join dealer d on d.id = sell.dealer_id group by d.location

Select c.city, sum(sell.amount) from sell join client c on c.id = sell.client_id group by c.city
