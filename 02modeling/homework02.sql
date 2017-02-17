-- Karen Cudjoe
-- CS 342, Homework 02

-- 1. Exercise 5.14

--Drop current database
DROP TABLE Shipment;
DROP TABLE Order_Item;
DROP TABLE Item;
DROP TABLE Orders;
DROP TABLE Customer;
DROP TABLE Warehouse;

-- Create database schema
CREATE TABLE Customer (
	customerId integer, 
	name varchar(35),
	city varchar(35),
	PRIMARY KEY(customerId),
	CHECK (city IS NOT NULL) 
	-- because a package can't be shipped to an unknown city
	);
	
CREATE TABLE Orders (
	orderId integer,
	orderDate date,
	customerID integer,
	orderAmount float,
	PRIMARY KEY(orderId),
	FOREIGN KEY (customerID) REFERENCES Customer(customerId) ON DELETE CASCADE,
	-- I chose CASCADE so that all a customers records are deleted when the customer is deleted
	CHECK (orderAmount > 0)
	);

CREATE TABLE Item (
	itemID integer NOT NULL,
	unitPrice float,
	name varchar(35),
	PRIMARY KEY (itemID),
	CHECK (unitPrice > 0)
	);
	
CREATE TABLE Order_Item (
	orderID integer,
	itemID integer,
	quantity integer,
	FOREIGN KEY (orderID) REFERENCES Orders(orderID) ON DELETE CASCADE, --if an order is deleted, all its corresponding orders should also be deleted
	FOREIGN KEY (itemID) REFERENCES Item(itemID) ON DELETE CASCADE,
	CHECK (quantity > 0) --no need for an order if 0 items are bought
	);
	
CREATE TABLE Warehouse (
	warehouseID integer NOT NULL,
	city varchar (35),
	PRIMARY KEY(warehouseID)
	);
	
CREATE TABLE Shipment (
	orderID integer, 
	warehouseID integer,
	shipDate date,
	FOREIGN KEY (orderID) REFERENCES Orders(orderID) ON DELETE SET NULL,
	FOREIGN KEY (warehouseID) REFERENCES Warehouse(warehouseID) ON DELETE SET NULL
	);
	
-- Load sample database
INSERT INTO Customer VALUES (1, 'Karen Cudjoe', 'Accra');
INSERT INTO Customer VALUES (2, 'Frank Boye', 'Kumasi');
INSERT INTO Customer VALUES (3, 'Ewura Esi', 'Cape Coast');
INSERT INTO Customer VALUES (4, 'Ewurajoa Eshun', 'Elmina');
INSERT INTO Customer VALUES (5, 'Delali Zormelo', 'Ho');

INSERT INTO Orders VALUES (1, '01-Feb-2015', 1, 12);
INSERT INTO Orders VALUES (2, '11-Jan-2014', 2, 2);
INSERT INTO Orders VALUES (3, '01-July-2015', 1, 100);
INSERT INTO Orders VALUES (4, '30-Jan-2007', 3, 4);
INSERT INTO Orders VALUES (5, '23-Jan-2015', 2, 1.3);

INSERT INTO Item VALUES (1, 2, 'food');
INSERT INTO Item VALUES (2, 5, 'gold');
INSERT INTO Item VALUES (3, 2, 'boy');
INSERT INTO Item VALUES (4, 3, 'snack');
INSERT INTO Item VALUES (5, 1, 'cloth');

INSERT INTO Order_Item VALUES (1, 5, 23);
INSERT INTO Order_Item VALUES (2, 2, 2);
INSERT INTO Order_Item VALUES (3, 3, 5);
INSERT INTO Order_Item VALUES (4, 1, 23);
INSERT INTO Order_Item VALUES (5, 1, 6);

INSERT INTO Warehouse VALUES (1, 'Lagos');
INSERT INTO Warehouse VALUES (2, 'Leki');
INSERT INTO Warehouse VALUES (3, 'Abuja');
INSERT INTO Warehouse VALUES (4, 'Tamale');
INSERT INTO Warehouse VALUES (5, 'Takoradi');

INSERT INTO Shipment VALUES (1, 4, '11-July-2014');
INSERT INTO Shipment VALUES (2, 5, '23-Jan-2014');
INSERT INTO Shipment VALUES (3, 3, '11-Jan-2003');
INSERT INTO Shipment VALUES (4, 2, '11-April-2014');
INSERT INTO Shipment VALUES (5, 1, '22-Jan-2014');




-- 2. Exercise 5.20 a & c
-- a. Surrogate keys are acceptable and as such, I would advise CIT to keep them. 
-- The surrogate numbers are unique , constant and never change. 
-- These numbers don't have to mean and are not tied to any information about students which are likely to change over time or which will harm their privacy. 
-- Using a more meaningful number could result in some privacy issues or the need  to change the numbers as one's information changes. 
-- Example using SSN will result in privacy issues and using one's financial information or something will probably change over time. 
-- The surrogate number doesnt have to have a special meaning as it's purpose is to identify students uniquely, and that's exactly what it does. 
-- There is no need to change these as these numbers are successful in the work they were designed to do. 
-- The advantage of using the surrogate key is that it uniquely identifies students, and it never changes. 
-- A disadvantage of using the surrogate key is that due to its meaninglessness, it is hard to remember at first


-- 3. 
-- a. 
SELECT orderDate, orderAmount 
FROM Orders, Customer
WHERE Customer.customerID = Orders.customerID
AND Customer.name = 'Karen Cudjoe'
ORDER BY Orders.orderDate DESC;


-- b. 
SELECT DISTINCT Customer.customerID 
FROM Customer, Orders
WHERE Customer.customerID = Orders.customerID;

-- c. 
SELECT Customer.customerID, Customer.name
FROM Customer, Orders, Item, Order_Item
WHERE Customer.customerID = Orders.customerID
AND Item.itemID = Order_Item.itemID
AND Orders.orderID = Order_Item.orderID
AND Item.name = 'cloth';


