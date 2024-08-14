create database if not exists manufacturerdb;
use manufacturerdb;

CREATE TABLE Manufacturers (
  Code INTEGER,
  Name VARCHAR(255) NOT NULL,
  PRIMARY KEY (Code)   
);

CREATE TABLE Products (
  Code INTEGER,
  Name VARCHAR(255) NOT NULL ,
  Price DECIMAL NOT NULL ,
  Manufacturer INTEGER NOT NULL,
  PRIMARY KEY (Code), 
  FOREIGN KEY (Manufacturer) REFERENCES Manufacturers(Code)
) ENGINE=INNODB;

INSERT INTO Manufacturers(Code,Name)
 VALUES(1,'Sony'),
(2,'Creative Labs'),
(3,'Hewlett-Packard'),
(4,'Iomega'),
(5,'Fujitsu'),
(6,'Winchester');

INSERT INTO Products(Code,Name,Price,Manufacturer)
 VALUES(1,'Hard drive',240,5),
(2,'Memory',120,6),
(3,'ZIP drive',150,4),
(4,'Floppy disk',5,6),
(5,'Monitor',240,1),
(6,'DVD drive',180,2),
(7,'CD drive',90,2),
(8,'Printer',270,3),
(9,'Toner cartridge',66,3),
(10,'DVD burner',180,2);

-- 1.1 Select the names of all the products in the store.
SELECT name FROM products;

-- 1.2 Select the names and the prices of all the products in the store.
SELECT name, price from products;

-- 1.3 Select the name of the products with a price less than or equal to $200.
SELECT name from products where price <= 200;

-- 1.4 Select all the products with a price between $60 and $120.
SELECT * FROM Products where Price >= 60 and price <= 120;

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
SELECT name,price *100 from Products;

-- 1.6 Compute the average price of all the products.
SELECT AVG(price) from Products;

-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
SELECT AVG(price) FROM Products WHERE code=2;

-- 1.8 Compute the number of products with a price larger than or equal to $180.
SELECT count(*) FROM Products WHERE price >=180;

-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
SELeCT name, price FROM Products where price >=180;

-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
SELECT * FROM Products LEFT JOIN Manufacturers on Products.Manufacturer = Manufacturers.Code;

-- 1.11 Select the product name, price, and manufacturer name of all the products.
SELECT Products.name, Products.price, Manufacturers.name from Products
INNER JOIN Manufacturers on Products.Manufacturer = Manufacturers.Code;

-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code
SELECT avg(price), Manufacturer from Products 
group by Manufacturer;

-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT AVG(Price), Manufacturers.Name
   FROM Products INNER JOIN Manufacturers
   ON Products.Manufacturer = Manufacturers.Code
   GROUP BY Manufacturers.Name;
   
-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
SELECT  Manufacturers.Name, price >=150 
from Products INNER JOIN Manufacturers
ON Products.Manufacturer = Manufacturers.Code;

-- 1.15 Select the name and price of the cheapest product.
SELECT name, price from Products
order by price ASC 
LIMIT 1;
-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.


-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
INSERT INTO Products(Code,Name,Price,Manufacturer)
VALUES (11, "Loudspeakers", 70, 2);

-- 1.18 Update the name of product 8 to "Laser Printer".
update Products 
set name = "laser Printer"
where code = 8;

-- 1.19 Apply a 10% discount to all products.
set sql_safe_updates = 0;
UPDATE Products
SET price = price - (price * 0.1);

-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
UPDATE Products
SET price = price - (price * 0.1)
where price >=120;

DROP TABLE Manufacturers, Products;