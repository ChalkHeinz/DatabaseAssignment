CREATE DATABASE lincolngardencenter;

USE lincolngardencenter;

CREATE TABLE Customer (
	CustomerID mediumint unsigned NOT NULL AUTO_INCREMENT,
    CustomerEmail varchar(40) NOT NULL PRIMARY KEY,
	CustomerFirstName varchar(30) NOT NULL,
	CustomerLastName varchar(30) NOT NULL,
    CustomerAddress varchar(255) NOT NULL,
    CONSTRAINT UC_Customer UNIQUE (CustomerID, CustomerEmail)
);
CREATE TABLE CustomerOrder(
    CustomerOrderID mediumint unsigned NOT NULL AUTO_INCREMENT,
    COCustomerID mediumint unsigned NOT NULL,
    COOrderStatus enum('Pending', 'Sent', 'Received','Paid') NOT NULL,
    COItemOrderedID mediumint unsigned NOT NULL,
    ItemAdditionalInfo varchar(255),
    COQuantityOfItems smallint unsigned NOT NULL,
    COItemPrice float(10, 2) NOT NULL,
    CONSTRAINT PK_CustomerOrderID
    PRIMARY KEY (CustomerOrderID),
    CONSTRAINT UC_CustomerOrder UNIQUE (CustomerOrderID)
);
CREATE TABLE Staff(
    StaffID mediumint unsigned NOT NULL AUTO_INCREMENT,
    StaffEmail varchar(40) NOT NULL,
    StaffName varchar(60) NOT NULL,
    CONSTRAINT PK_StaffID
    PRIMARY KEY (StaffID),
    CONSTRAINT UC_Staff UNIQUE (StaffID, StaffEmail)
);
CREATE TABLE PurchaseOrder(
    PurchaseOrderID mediumint unsigned NOT NULL AUTO_INCREMENT,
    POStaffID mediumint unsigned NOT NULL,
    POSupplierID mediumint unsigned NOT NULL,
    POOrderStatus enum('Pending', 'Sent', 'Received','Paid') NOT NULL,
    POOrderDateTime DATETIME DEFAULT NOW() NOT NULL,
    POItemOrderedID varchar(50) NOT NULL,
    POQuantityOfItems smallint unsigned NOT NULL,
    POItemPrice fLoat(12, 2) NOT NULL,
    CONSTRAINT PK_PurchaseOrderID
    PRIMARY KEY (PurchaseOrderID),
    CONSTRAINT UC_PurchaseOrder UNIQUE (PurchaseOrderID)
);
CREATE TABLE Supplier(
    SupplierID mediumint unsigned NOT NULL AUTO_INCREMENT,
    SupplierEmail varchar(40) NOT NULL,
    SupplierName varchar(50) NOT NULL,
    SupplierBuilding varchar(50) NOT NULL,
    SupplierStreet varchar(50) NOT NULL,
    SupplierCity varchar(50) NOT NULL,
    SupplierPostCode varchar(4) NOT NULL,
    CONSTRAINT PK_SupplierID
    PRIMARY KEY (SupplierID),
    CONSTRAINT UC_Supplier UNIQUE(SupplierID, SupplierEmail, SupplierName)
);
CREATE TABLE Plant(
    PlantID mediumint unsigned NOT NULL AUTO_INCREMENT,
    LatinName varchar(30) NOT NULL,
    PopularName varchar(30) NOT NULL,
    ColourOfFoliage varchar(30) NOT NULL,
    ColourOfFlowers varchar(30) NOT NULL,
    Height float(6,2) NOT NULL,
    Price float(6, 2) NOT NULL,
    FloweringPeriod varchar(50) not NULL,
    Quantity int unsigned NOT NULL,
    CONSTRAINT PK_Plant
    PRIMARY KEY (PlantID),
    CONSTRAINT UC_Plant UNIQUE (PlantID, LatinName, PopularName)
);

-- Auto increment
ALTER TABLE CustomerOrder AUTO_INCREMENT = 100;
ALTER TABLE Staff AUTO_INCREMENT = 200;
ALTER TABLE PurchaseOrder AUTO_INCREMENT = 300;
ALTER TABLE Supplier AUTO_INCREMENT = 400;
ALTER TABLE Plant AUTO_INCREMENT = 500;
-- Auto increment

-- Deleting and Adding columns
ALTER TABLE Customer
DROP COLUMN CustomerAddress;

ALTER TABLE Customer
ADD COLUMN CustomerHouseNo smallint unsigned NOT NULL,
ADD COLUMN CustomerStreet varchar (50) NOT NULL,
ADD COLUMN CustomerCity varchar(50) NOT NULL,
ADD COLUMN CustomerPostCode varchar(8) NOT NULL;
    
ALTER TABLE Staff
DROP COLUMN StaffName;

ALTER TABLE Staff
ADD COLUMN StaffFirstName varchar(30) NOT NULL,
ADD COLUMN StaffLastName varchar(30) NOT NULL;

-- Deleting and Adding columns

-- Modifying columns
ALTER TABLE PurchaseOrder
MODIFY COLUMN POItemOrderedID mediumint unsigned NOT NULL;

ALTER TABLE Supplier
MODIFY COLUMN SupplierPostCode varchar(8) NOT NULL;

-- Modifying columns

-- Primary key
ALTER TABLE Customer
DROP PRIMARY KEY;
ALTER TABLE Customer
ADD CONSTRAINT PK_CustomerID PRIMARY KEY (CustomerID);

-- Primary key 
-- Foreign key
ALTER TABLE CustomerOrder
ADD CONSTRAINT FK_CustomerOrderCusEmail
FOREIGN KEY (COCustomerID) 
REFERENCES
Customer(CustomerID)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE CustomerOrder
ADD CONSTRAINT FK_CustomerOrderCOItemID
FOREIGN KEY (COItemOrderedID) 
REFERENCES
Plant(PlantID)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE PurchaseOrder
ADD CONSTRAINT FK_PurchaseOrderStaffID
FOREIGN KEY (POStaffID) 
REFERENCES
Staff(StaffID)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE PurchaseOrder
ADD CONSTRAINT FK_PurchaseOrderSupplierID
FOREIGN KEY (POSupplierID) 
REFERENCES
Supplier(SupplierID)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE PurchaseOrder
ADD CONSTRAINT FK_PurchaseOrderItemOrderedID
FOREIGN KEY (POItemOrderedID) 
REFERENCES
Plant(PlantID)
ON UPDATE CASCADE ON DELETE CASCADE;

-- Foreign key

-- Index
CREATE INDEX CustomerName ON Customer(CustomerFirstName, CustomerLastName);
CREATE INDEX StaffName ON Staff(StaffFirstName, StaffLastName);
-- Index

-- SET

SET @CurrentTimeDate = Now();
SET @DefaultCity = 'Lincoln';

-- SET

-- Inserting data
INSERT INTO Customer(
    CustomerEmail, CustomerFirstName, CustomerLastName, CustomerHouseNo, CustomerStreet, CustomerCity, CustomerPostCode
)
VALUES
('customer1@outlook.com', 'Bob', 'Dillison', '1', 'PepsiLane', @DefaultCity, 'LN1 1PL'),
('customer2@outlook.com', 'Dill', 'Bobbison', '2', 'FantaLane', @DefaultCity, 'LN2 1FL'),
('customer3@outlook.com', 'Clint', 'Dillison', '3', 'CokeLane', @DefaultCity, 'LN3 3CL'),
('customer4@outlook.com', 'Jon', 'Sand', '4', 'SummerLane', 'Derby', 'DE4 3SL'),
('customer5@outlook.com', 'Mary', 'Angel', '5', 'SpeedLane', 'Nottingham', 'NG5 5SL'),
('customer6@outlook.com', 'Paige', 'Robinsons', '6', 'BingoLane', @DefaultCity, 'LN6 6CL'),
('customer7@outlook.com', 'Jackson', 'Barnes', '7', 'MarsLane', @DefaultCity, 'LN7 7CL'),
('customer8@outlook.com', 'Holly', 'Stank', '8', 'LyxnLane', 'Derby', 'DE8 8SL'),
('customer9@outlook.com', 'Zack', 'Winters', '9', 'SpriteLane', @DefaultCity, 'LN9 9CL'),
('customer10@outlook.com', 'Clint', 'Barnes', '10', 'UnderLane', @DefaultCity, 'LN10 3CL');
INSERT INTO Plant(
    LatinName, PopularName, ColourOfFoliage, ColourOfFlowers, Height, Price, FloweringPeriod, Quantity
)
VALUES('Lorem', 'Sun Flower', 'Green', 'Yellow', '1.00', '3.99', '3 Weeks', '12'),
('Ipsum', 'Cereus repandus', 'Red', 'White', '3.00', '13.99', '52 Weeks', '5'),
('Dolor', 'Wild Flower', 'Blue', 'Purple', '0.10', '2.99', '1 Week', '1230'),
('Exercitation', 'Royal Blue', 'Blue', 'Blue', '0.05', '1.99', '2 Weeks', '56'),
('Eecteque', 'Royal Green', 'Green', 'Green', '0.05', '1.99', '2 Weeks', '50'),
('Volutpat ', 'Dicotyledon', 'Blue', 'Blue', '1.05', '4.99', '1 Weeks', '60'),
('Iudico', 'Magnoliids', 'Blue', 'Green', '2.05', '3.99', '5 Weeks', '40'),
('Abhorreant', 'Lauraceae', 'Red', 'Blue', '4.05', '2.99', '6 Weeks', '30');

INSERT INTO Staff(StaffEmail, StaffFirstName, StaffLastName)
VALUES('staff1@outlook.com', 'Steve', 'Richards'),
('staff2@outlook.com','Gary','Rodgers'),
('staff3@outlook.com','Susan','Harley'),
('staff4@outlook.com','Derek','Moyle'),
('staff5@outlook.com','Debbie','Bebbie');

INSERT INTO Supplier(SupplierEmail, SupplierName, SupplierBuilding, SupplierStreet, SupplierCity, SupplierPostCode)
VALUES('supplier1@outlook', 'Flowers r us', 'Building1', 'FlowerLane', @DefaultCity, 'LN1 1FL'),
('supplier2@outlook', 'Flower Co', 'Building2', 'FlowerLane', 'Portsmouth', 'PO2 2FL'),
('supplier3@outlook', 'Flowers Express', 'Building3', 'DillyLane', 'Southampton', 'SO3 3FL'),
('supplier4@outlook', 'Plant Co', 'Building4', 'PlantingLane', @DefaultCity, 'LN4 4FL'),
('supplier5@outlook', 'Budding Inc', 'Building5', 'BUddingLane', @DefaultCity, 'LN5 5FL');

INSERT INTO CustomerOrder(COCustomerID, COOrderStatus, COItemOrderedID, ItemAdditionalInfo, COQuantityOfItems, COItemPrice)
VALUES('1', 'Paid', '500', NULL, '5', '19.95'),
('1', 'Paid', '501', 'Despiked', '2', '27.98'),
('4', 'Sent', '503', NULL, '10', '19.90'),
('2', 'Pending', '507', NULL, '1', '6.99'),
('2', 'Received', '506', NULL, '2', '7.99'),
('5', 'Sent', '505', NULL, '3', '20.99'),
('5', 'Pending', '504', NULL, '4', '23.99'),
('5', 'Received', '504', NULL, '5', '2.99'),
('2', 'Received', '505', NULL, '6', '3.99'),
('4', 'Sent', '506', NULL, '7', '7.99');

INSERT INTO PurchaseOrder(POStaffID, POSupplierID, POOrderStatus, POOrderDateTime, POItemOrderedID, POQuantityOfItems, POItemPrice)
VALUES('200', '401', 'Paid', '2017-12-14 14:02:22', '500', '250', '897.75'),
('200', '400', 'Pending', @CurrentTimeDate, '501', '500', '62955.00'),
('201', '403', 'Sent', '2017-12-16 13:42:42', '504', '750', '34477.50'),
('203', '402', 'Received', @CurrentTimeDate, '505', '100', '4477.50'),
('203', '404', 'Sent', '2017-12-16 13:42:42', '507', '300', '65477.50'),
('203', '404', 'Received', @CurrentTimeDate, '507', '450', '73477.50');


-- Inserting data
-- Deleting data
DELETE FROM Customer
WHERE CustomerLastName LIKE '%d';

DELETE FROM Customer
WHERE CustomerID BETWEEN 7 AND 10;

DELETE FROM Plant
Where PlantID = 503;

DELETE FROM PurchaseOrder
WHERE POOrderStatus = 'Paid';

-- Deleting data
-- Updating Data
UPDATE CustomerOrder
SET COOrderStatus = 'Paid'
WHERE COItemOrderedID = 500;
UPDATE Plant
SET Quantity = 100
WHERE Quantity < 5;
UPDATE Staff
SET StaffLastName = 'Williams'
WHERE StaffLastName = 'r%';
-- Updating Data

-- Join statements
SELECT CustomerOrder.COCustomerID, Customer.CustomerFirstName, Customer.CustomerLastName
FROM CustomerOrder
INNER JOIN Customer ON CustomerOrder.COCustomerID = Customer.CustomerID
ORDER BY Customer.CustomerLastName;

SELECT PurchaseOrder.POStaffID, Staff.StaffFirstName, Staff.StaffLastName
FROM PurchaseOrder
LEFT JOIN Staff ON PurchaseOrder.POStaffID = Staff.StaffID
ORDER BY Staff.StaffLastName;

SELECT CustomerOrder.COCustomerID, Customer.CustomerFirstName, Customer.CustomerLastName
FROM CustomerOrder
RIGHT JOIN Customer ON CustomerOrder.COCustomerID = Customer.CustomerID
ORDER BY Customer.CustomerLastName;
-- Join statments

-- Union Statment
SELECT CustomerPostCode AS PostCode FROM Customer
UNION
SELECT SupplierPostCode AS PostCode FROM Supplier
ORDER BY PostCode;
-- Union Statment

-- Copy tables
CREATE TABLE copy_of_Customer LIKE Customer; 
INSERT copy_of_Customer SELECT * FROM Customer;
CREATE TABLE copy_of_Plant LIKE Plant; 
INSERT copy_of_Plant SELECT * FROM Plant;
CREATE TABLE copy_of_Staff LIKE Staff; 
INSERT copy_of_Staff SELECT * FROM Staff;
CREATE TABLE copy_of_Supplier LIKE Supplier; 
INSERT copy_of_Supplier SELECT * FROM Supplier;
CREATE TABLE copy_of_CustomerOrder LIKE CustomerOrder; 
INSERT copy_of_CustomerOrder SELECT * FROM CustomerOrder;
CREATE TABLE copy_of_PurchaseOrder LIKE PurchaseOrder; 
INSERT copy_of_PurchaseOrder SELECT * FROM PurchaseOrder;
-- Copy tables

-- Database User
CREATE USER 'user'@'localhost' IDENTIFIED by 'password';
GRANT SELECT ON lincolngardencenter.* TO 'user'@'localhost';
-- Database User

-- Stored procedures
DELIMITER //
CREATE PROCEDURE PlaceCustomerOrder(IN CusID mediumint unsigned, ItemOrderedID mediumint unsigned, Quantity smallint unsigned, AddInfo varchar(255), OUT OrderID mediumint unsigned)
BEGIN
SET @Price = (SELECT Price FROM Plant WHERE PlantID = ItemOrderedID) * Quantity;
SET @NewPrice = @Price * Quantity;
INSERT INTO CustomerOrder(COCustomerID, COOrderStatus, COItemOrderedID, ItemAdditionalInfo, COQuantityOfItems, COItemPrice)
VALUES(CusID, 'Pending', ItemOrderedID, AddInfo, Quantity, @NewPrice);
SET @OrderID = LAST_INSERT_ID();
END //
DELIMITER ;
CALL PlaceCustomerOrder(1, 501, 8, 'Extra spikes', @OrderID);
SELECT CONCAT(@OrderID, ' Has been created')  AS ConcatenatedString;


