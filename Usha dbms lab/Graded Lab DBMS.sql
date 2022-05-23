/*1) You are required to create tables for supplier,customer,category,
product,supplier_pricing,order,rating to store the data for 
the Ecommerce with the schema definition given below.*/


CREATE TABLE  supplier(
SUPP_ID int primary key,
SUPP_NAME varchar(50) NOT NULL,
SUPP_CITY varchar(50) NOT NULL,
SUPP_PHONE varchar(10) NOT NULL
);



CREATE TABLE  customer(
CUS_ID INT NOT NULL,
CUS_NAME VARCHAR(20) NOT NULL,
CUS_PHONE VARCHAR(10) NOT NULL,
CUS_CITY varchar(30) NOT NULL,
CUS_GENDER CHAR,
PRIMARY KEY (CUS_ID));


CREATE TABLE  category (
CAT_ID INT NOT NULL,
CAT_NAME VARCHAR(20) NOT NULL,
PRIMARY KEY (CAT_ID)
);


CREATE TABLE  product (
PRO_ID INT NOT NULL,
PRO_NAME VARCHAR(20) NOT NULL DEFAULT "Dummy",
PRO_DESC VARCHAR(60),
CAT_ID INT NOT NULL,
PRIMARY KEY (PRO_ID),
FOREIGN KEY (CAT_ID) REFERENCES CATEGORY (CAT_ID)
);


CREATE TABLE  supplier_pricing (
PRICING_ID INT NOT NULL,
PRO_ID INT NOT NULL,
SUPP_ID INT NOT NULL,
SUPP_PRICE INT DEFAULT 0,
PRIMARY KEY (PRICING_ID),
FOREIGN KEY (PRO_ID) REFERENCES PRODUCT (PRO_ID),
FOREIGN KEY (SUPP_ID) REFERENCES SUPPLIER(SUPP_ID)
);

CREATE TABLE  `order` (
ORD_ID INT NOT NULL,
ORD_AMOUNT INT NOT NULL,
ORD_DATE DATE,
CUS_ID INT NOT NULL,
PRICING_ID INT NOT NULL,
PRIMARY KEY (ORD_ID),
FOREIGN KEY (CUS_ID) REFERENCES CUSTOMER(CUS_ID),
FOREIGN KEY (PRICING_ID) REFERENCES SUPPLIER_PRICING(PRICING_ID)
);


CREATE TABLE  rating (
RAT_ID INT NOT NULL,
ORD_ID INT NOT NULL,
RAT_RATSTARS INT NOT NULL,
PRIMARY KEY (RAT_ID),
FOREIGN KEY (ORD_ID) REFERENCES `order`(ORD_ID)
);

-- 2) Insert the following data in the table created above

insert into product values(1, 'GTA V', 'Windows 7 and above with i5 processor and 8GB RAM', 2);
insert into product values(2, 'TSHIRT', 'SIZE-L with Black, Blue and White variations', 5);
insert into product values(3, 'ROG LAPTOP', 'Windows 10 with 15inch screen, i7 processor, 1TB SSD', 4);
insert into product values(4, 'OATS', 'Highly Nutritious from Nestle', 3);
insert into product values(5, 'HARRY POTTER', 'Best Collection of all time by J.K Rowling', 1);
insert into product values(6, 'Milk', '1L Toned MIlk', 3);
insert into product values(7, 'Boat Earphones', '1.5Meter long Dolby Atmos', 4);
insert into product values(8, 'Jeans', 'Stretchable Denim Jeans with various sizes and color', 5);
insert into product values(9, 'Project IGI', 'compatible with windows 7 and above', 2);
insert into product values(10, 'Hoodie', 'Black GUCCI for 13 yrs and above', 5);
insert into product values(11, 'Rich Dad Poor Dad', 'Written by RObert Kiyosaki', 1);
insert into product values(12, 'Train Your Brain', 'By Shireen Stephen', 1);
select * from product;


insert into supplier_pricing values(1, 1, 2, 1500);
insert into supplier_pricing values(2, 3, 5, 30000);
insert into supplier_pricing values(3, 5, 1, 3000);
insert into supplier_pricing values(4, 2, 3, 2500);
insert into supplier_pricing values(5, 4, 1, 1000);
insert into supplier_pricing values(6,12,2,780);
insert into supplier_pricing values(7,12,4,789);
insert into supplier_pricing values(8,3,1,31000);
insert into supplier_pricing values(9,1,5,1450);
insert into supplier_pricing values(10,4,2,999); 
insert into supplier_pricing values(11,7,3,549);
insert into supplier_pricing values(12,7,4,529);
insert into supplier_pricing values(13,6,2,105);
insert into supplier_pricing values(14,6,1,99);
insert into supplier_pricing values(15,2,5,2999);
insert into supplier_pricing values(16,5,2,2999);
select * from supplier_pricing;



insert into `order` values(101, 1500,  '2021-10-06', 2, 1);
insert into `order` values(102, 1000,  '2021-10-12', 3, 5);
insert into `order` values(103, 30000, '2021-09-16', 5, 2);
insert into `order` values(104, 1500,  '2021-10-05', 1, 1);
insert into `order` values(105, 3000,  '2021-08-16', 4, 3);
insert into `order` values(106, 1450,  '2021-08-18', 1, 9);
insert into `order` values(107, 789,   '2021-09-01', 3, 7);
insert into `order` values(108, 780,   '2021-09-07', 5, 6);
insert into `order` values(109, 3000,  '2021-09-10', 5, 3);
insert into `order` values(110, 2500,  '2021-09-10', 2, 4);
insert into `order` values(111, 1000,  '2021-09-15', 4, 5);
insert into `order` values(112, 789,   '2021-09-16', 4, 7);
insert into `order` values(113, 31000, '2021-09-16', 1, 8);
insert into `order` values(114, 1000,  '2021-09-16', 3, 5);
insert into `order` values(115, 3000,  '2021-09-16', 5, 3);
insert into `order` values(116, 99,    '2021-09-17', 2, 14);
SELECT     * FROM  `order`;

-- Queries →


/* 3) Display the total number of customers based on gender who have placed
 orders of worth at least Rs.3000.*/

select cus_gender, count(cus_gender)
from customer
where cus_id in (select distinct cus_id from `order` where ord_amount >= 3000)
group by cus_gender;

/* 4) Display all the orders along with product name ordered by a customer 
having Customer_Id=2 */

SELECT ORD.*,P.PRO_NAME  FROM `ORDER` ORD
JOIN SUPPLIER_PRICING SP
ON  ORD.PRICING_ID = SP.PRICING_ID
JOIN PRODUCT P
ON SP.PRO_ID = P.PRO_ID
WHERE ORD.CUS_ID = 2;

-- 5) Display the Supplier details who can supply more than one product
SELECT * FROM SUPPLIER 
WHERE SUPP_ID IN
(SELECT SUPP_ID 
FROM SUPPLIER_PRICING
GROUP BY SUPP_ID
HAVING COUNT(SUPP_ID) > 1);


/* 6) Find the least expensive product from each category and 
print the table with category id, name, 
product name and price of the product */

SELECT C.CAT_ID,C.CAT_NAME,P.PRO_NAME, MIN(SUPP_PRICE)
FROM SUPPLIER_PRICING SP
JOIN PRODUCT P
ON SP.PRO_ID = P.PRO_ID
JOIN CATEGORY C 
ON P.CAT_ID = C.CAT_ID
GROUP BY C.CAT_ID;

-- 7) Display the Id and Name of the Product ordered after “2021-10-05”.

SELECT ORD.*, P.PRO_ID,P.PRO_NAME FROM `ORDER` ORD
JOIN SUPPLIER_PRICING SP
ON ORD.PRICING_ID = SP.PRICING_ID
JOIN PRODUCT P
ON SP.PRO_ID = P.PRO_ID
WHERE ORD.ORD_DATE > '2021-10-05';


-- 8) Display customer name and gender whose names start or end with character 'A'
SELECT CUS_NAME, CUS_GENDER
FROM CUSTOMER
WHERE CUS_NAME LIKE 'A%' or CUS_NAME LIKE '%A';


/* 9) Create a stored procedure to display supplier id, name, rating and
 Type_of_Service. For Type_of_Service, If rating =5, print “Excellent
 Service”,If rating >4 print “Good Service”, If rating >2 print 
 “Average Service” else print “Poor Service”. */
 
DELIMITER $
CREATE PROCEDURE ServiceQuality ()
begin
SELECT  SUPP.SUPP_ID,SUPP.SUPP_NAME,R.RAT_RATSTARS,
CASE 
	WHEN R.RAT_RATSTARS = 5 THEN 'Excellent Service'
    WHEN R.RAT_RATSTARS >= 4 THEN 'Good Service'
     WHEN R.RAT_RATSTARS > 2 THEN 'Average Service'
    ELSE 'Poor Service'
END AS Type_Of_Service
from RATING R
JOIN `ORDER` ORD
ON R.ORD_ID = ORD.ORD_ID
JOIN SUPPLIER_PRICING SP
ON ORD.PRICING_ID = SP.PRICING_ID
JOIN SUPPLIER SUPP
ON SP.SUPP_ID = SUPP.SUPP_ID;
end$

DELIMITER ;
call ServiceQuality();