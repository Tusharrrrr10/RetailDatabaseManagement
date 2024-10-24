##1. Find the store with the highest customer grade.
select name,customerGrade
from store
order by customerGrade desc
limit 1;

## 2.Find the product that has been ordered the most times.

SELECT 
    name, COUNT(product.pid) AS product_ordered_most
FROM product
JOIN orderitem
ON product.pid = orderitem.pid
GROUP BY product.name , product.pid
order by product_ordered_most desc
limit 1;

##3.Find all the orders that were delivered to addresses in the city of Cornwall
select * from address
where city = "Cornwall";

##4.Find all the orders that were placed for products that are sold by stores in the city of Toronto.
select product.name,store.city from product
join store
using(sid)
where city = "Toronto";

##5.Find all the orders that were placed for products that have a customer review rating of at least 4 out of 5 stars.
select p.name,c.grade from product as p
join comments as c
using(pid)
where grade>=4;

##6.Find all the details of the buyers who have a phone number that starts with the contactnumber 91.
select * from address 
inner join buyer using(userid)
where contactPhoneNumber like "91%";

##7.Query the address, starttime and endtime of the servicepoints in the same city as userid 5.
select * from address
inner join users
using (userid)
join servicepoint
using (city)
where userid=5;

##8.Query the information of laptops
select *from product where type='laptop';

-- 20. Retrieve all products and their associated store information (if available)
select product.pid,product.brand,product.name as productname,product.type,product.modelnumber,store.name as storename
from product
inner join store on product.sid=store.sid;

-- 21. Retrieve all addresses and the users associated with them (if available)
SELECT address.streetaddr, Users.name, Users.phoneNumber
FROM Address
inner JOIN Users ON Address.userid = Users.userID;

##22.Retrieve all stores and their associated managers
SELECT Store.sid,manage.userid,Store.Name AS StoreName, Users.name AS ManagerName
FROM Store
LEFT JOIN Manage ON Store.sid = Manage.sid
LEFT JOIN Users ON Manage.sid = Users.userid;

##11.	Update the payment state of orders to unpaid which created after year 2017 and with total amount greater than 50.


SELECT * FROM ORDERS;
UPDATE orders
SET PAYMENTSTATE = 'UNPAID'
WHERE YEAR(CREATIONTIME) >= 2017 AND TOTALAMOUNT > 50;
SELECT * FROM ORDERS WHERE YEAR(ORDERNUMBER) >= 2017 AND TOTALAMOUNT > 50;

## 12.	Update the name and contact phone number of address where the provice is Quebec and city is montreal.

UPDATE address
SET name = 'tUSHAR', contactPhoneNumber = '123-456-1234'
WHERE province = 'Quebec' AND city = 'Montreal';

SELECT * FROM ADDRESS;


-- 13.	Delete the store which opened before year 2017


SET FOREIGN_KEY_CHECKS = 0;

DELETE FROM store
WHERE YEAR(STARTTIME) < 2017;

-- SET FOREIGN_KEY_CHECKS = 1;

select * FROM STORE;

-- 14.	Create view of all products whose price above average price.

SELECT * FROM PRODUCT;

CREATE VIEW products_above_average_price AS
SELECT pid, brand,name,type,price
FROM product
WHERE price > (SELECT AVG(price) FROM product);

SELECT * FROM onlineretail.products_above_average_price;


-- 15.	Create view of all products sales in 2016.
CREATE VIEW product_sales_2016 AS
SELECT o.ordernumber, o.totalAmount,o.creationTime
FROM orders o
JOIN payment p ON o.ordernumber = p.ordernumber
WHERE YEAR(o.creationtime) = 2016;

SELECT * FROM onlineretail.product_sales_2016;
