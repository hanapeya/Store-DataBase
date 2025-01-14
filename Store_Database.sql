-- drop database `store`;
-- CREATE DATABASE IF NOT EXISTS `store`;

CREATE TABLE IF NOT EXISTS `Users`(
	UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(100) NOT NULL UNIQUE,
    Email VARCHAR(225) UNIQUE,
    JoinDate DATE 
);

CREATE TABLE IF NOT EXISTS `Products`(
	ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(225) NOT NULL,
    Catagory VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2),
    Stock INT DEFAULT 0,
    Descriptions TEXT NULL
);

CREATE TABLE IF NOT EXISTS `Orders`(
	OrderID INT PRIMARY KEY AUTO_INCREMENT, 
    UserID INT NOT NULL,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY(UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `OrderDetails`(
	OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL, 
    Quantity INT NOT NULL,
    Price DECIMAL(10,2),
    FOREIGN KEY(ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `Reviews`(
	ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT NOT NULL,
    ProductID INT NOT NULL,
    Rating INT NOT NULL,
    ReviewText TEXT NULL,
    ReviewDate DATE NOT NULL,
    CONSTRAINT constraint_rate CHECK (Rating BETWEEN 1 AND 5)
);

SELECT * FROM `Users`;
INSERT INTO `Users` (UserID, Username, Email, JoinDate) VALUES (1, 'John Doe', 'john@example.com', '2024-01-10');
INSERT INTO `Users` (Username, Email, JoinDate) VALUES ('Jane Smith', 'jane@example.com', '2024-01-15');
INSERT INTO `Users` (Username, Email, JoinDate) VALUES ('Sam Williams' , 'sam@example.com', '2024-01-20');
INSERT INTO `Users` (Username, Email, JoinDate) VALUES ('Lisa Johnson', 'lisa@example.com', '2024-01-22');

SELECT * FROM `Products`;
INSERT INTO `Products` (ProductName, Catagory, Price, Stock) VALUES ('Smatsphone X', 'Electronics', 699.99, 50);
INSERT INTO `Products` (ProductName, Catagory, Price, Stock) VALUES ('Wireless Headphones', 'Accessories', 199.99, 200);
INSERT INTO `Products` (ProductName, Catagory, Price, Stock) VALUES ('Gaming Laptop', 'Electronics', 1499.99, 30);
INSERT INTO `Products` (ProductName, Catagory, Price, Stock) VALUES ('Smartwatch', 'Accessories', 299.99, 100);
INSERT INTO `Products` (ProductName, Catagory, Price, Stock, Descriptions) VALUES ('Bluetooth Speaker', 'Accessories', 79.99, 200, 'Portable Bluetooth speaker.');

SET SQL_SAFE_UPDATES = 0;
UPDATE `Products` SET Descriptions = 'Multifunctional smartwatch.' WHERE ProductName = 'Smartwatch';

SELECT * FROM `Orders`;
INSERT INTO `Orders` (UserID, OrderDate, TotalAmount) VALUES (1, '2024-02-01', 899.98);
INSERT INTO `Orders` (UserID, OrderDate, TotalAmount) VALUES (3, '2024-02-05', 1679.98);
INSERT INTO `Orders` (UserID, OrderDate, TotalAmount) VALUES (4, '2024-02-01', 299.99);

SELECT * FROM `OrderDetails`;
INSERT INTO `OrderDetails` (OrderID, ProductID, Quantity, Price) VALUES (1, 1, 1, 699.99);
INSERT INTO `OrderDetails` (OrderID, ProductID, Quantity, Price) VALUES (1, 1, 2, 199.99);
INSERT INTO `OrderDetails` (OrderID, ProductID, Quantity, Price) VALUES (2, 3, 1, 1499.99);
INSERT INTO `OrderDetails` (OrderID, ProductID, Quantity, Price) VALUES (2, 4, 1, 299.99);
INSERT INTO `OrderDetails` (OrderID, ProductID, Quantity, Price) VALUES (3, 4, 1, 299.99);


SELECT * FROM `Reviews`;
INSERT INTO `Reviews` (UserID, ProductID, Rating, ReviewText, ReviewDate) VALUES (3, 3, 4, 'Great laptop for gaming!', '2024-02-10');
INSERT INTO `Reviews` (UserID, ProductID, Rating, ReviewText, ReviewDate) VALUES (4, 4, 5, 'Love the features!', '2024-02-12');
INSERT INTO `Reviews` (UserID, ProductID, Rating, ReviewText, ReviewDate) VALUES (1, 2, 3, 'Good sound quality', '2024-02-13');

SET SQL_SAFE_UPDATES = 1;
-- Advanced Queries and Reports --> Sales Reports: Generate reports to see the total sales for a given period, the most popular products, etc.

-- Top Products: Identify top-selling products.
SELECT ProductName, COUNT(Quantity) AS Total_Sales
FROM Products
JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY ProductName
ORDER BY Total_Sales DESC;

-- User Activity Insights --> Active Users: Find the most active users based on the number of orders placed.
SELECT Username, COUNT(Orders.UserID) AS Order_Count
FROM Orders
JOIN Users ON Orders.UserID = Users.UserId
GROUP BY Username
ORDER BY Order_Count DESC;

-- Product Management --> Restock Alerts: List products with low stock levels.
SELECT ProductName, Stock
FROM Products
WHERE Stock<100;

