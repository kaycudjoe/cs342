-- Karen Cudjoe
-- CS 342
-- Homework 03_3
-- Exercise 9.11 — Implement the schema by hand for this exercise, based on the model from the previous question. No automatic schema generation is required. 

-- drop tables
drop table PartOrder;
drop table Part;
drop table CustomerOrder;
drop table Customer;
drop table Employee;

-- create tables
create table Employee (
	ID integer PRIMARY KEY,
	firstName varchar(15),
	lastName varchar(15), 
	zipCode integer
	);
	
create table Customer (
	ID integer PRIMARY KEY, 
	firstName varchar(15), 
	lastName varchar(15), 
	zipCode integer
	);
	
create table CustomerOrder (
	ID integer PRIMARY KEY, 
	quantity integer,
	customerID integer,
	employeeID integer,
	receiptDate date,
	expectedshipDate date,
	actualshipDate date,
	FOREIGN KEY (customerID) REFERENCES Customer (ID) ON DELETE CASCADE, 
	FOREIGN KEY (employeeID) REFERENCES Employee (ID) ON DELETE SET NULL
	);
	
create table Part (
	ID integer PRIMARY KEY, 
	partName varchar(15), 
	price float,
	quantity integer
	);
	
create table PartOrder (
	customerOrderID integer, 
	partID integer, 
	quantity integer, 
	FOREIGN KEY (PartID) REFERENCES Part(ID) ON DELETE CASCADE, 
	FOREIGN KEY (CustomerOrderID) REFERENCES CustomerOrder (ID) ON DELETE CASCADE, 
	check (quantity > 0)
	);

-- insert data
insert into Employee VALUES (1, 'Karen', 'Cudjoe', 49546);
insert into Employee VALUES (2, 'Frank', 'Boye', 48858);
insert into Employee VALUES (3, 'EwuraEsi', 'Brookman', 61615);
insert into Employee VALUES (4, 'Ewuradjoa', 'Eshun', 12345);
insert into Employee VALUES (5, 'Bolu', 'Olayemi', 35653);

insert into Customer VALUES (1, 'Keziah', 'Benson', 60612);
insert into Customer VALUES (2, 'Francesca', 'Asare', 76454);
insert into Customer VALUES (3, 'Lilly', 'Awuah', 42334);
insert into Customer VALUES (4, 'Andrea', 'Annan', 34343);
insert into Customer VALUES (5, 'Perez', 'Annang', 56477);

insert into CustomerOrder VALUES (1, 232, 1, 2, '22-Jan-2016', '12-June-2016', '12-June-2016');
insert into CustomerOrder VALUES (2, 3, 2, 1, '21-Jan-2016', '23-June-2016', '12-May-2016');
insert into CustomerOrder VALUES (3, 23, 3, 4, '22-May-2016', '12-June-2016', '4-August-2016');
insert into CustomerOrder VALUES (4, 1, 4, 3, '5-Jan-2015', '12-June-2016', '12-September-2016');
insert into CustomerOrder VALUES (5, 454, 5, 5, '2-May-2016', '12-June-2016', '23-June-2016');

insert into Part VALUES (1, 'book', 5.56, 2445);
insert into Part VALUES (2, 'pen', 6.767, 23);
insert into Part VALUES (3, 'girl', 67, 1);
insert into Part VALUES (4, 'boy', 67.454, 343);
insert into Part VALUES (5, 'food', 0.5, 3);

insert into PartOrder VALUES (1, 5, 343);
insert into PartOrder VALUES (2, 3, 2);
insert into PartOrder VALUES (3, 4, 34);
insert into PartOrder VALUES (4, 2, 3);
insert into PartOrder VALUES (5, 1, 5);