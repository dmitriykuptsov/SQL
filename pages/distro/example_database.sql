USE shop;

CREATE TABLE Customers (
	Id INT PRIMARY KEY IDENTITY(1,1),
	FName NVARCHAR(100),
	LName NVARCHAR(100),
	Email NVARCHAR(100) UNIQUE,
	RegisteredAt DATETIME
);

CREATE TABLE Categories (
	Id INT PRIMARY KEY IDENTITY(1, 1),
	Name NVARCHAR(100) 
);

CREATE TABLE Products (
	Id INT PRIMARY KEY IDENTITY(1,1),
	ProductName NVARCHAR(100) NOT NULL,
	ProductCategoryId INT NOT NULL,
	Price REAL NOT NULL DEFAULT 0.0,
	CONSTRAINT FK_ProductsCategories
		FOREIGN KEY (ProductCategoryId) REFERENCES Categories(Id)
);

CREATE TABLE Orders (
	Id INT PRIMARY KEY IDENTITY(1, 1),
	CustomerId INT NOT NULL,
	OrderDate DATETIME NOT NULL,
	CONSTRAINT FK_OrdersCustomers
		FOREIGN KEY (CustomerId) REFERENCES Customers(Id)
);

CREATE TABLE OrderedProducts (
	Id INT PRIMARY KEY IDENTITY(1,1),
	ProductId INT NOT NULL,
	OrderId INT NOT NULL,
	CONSTRAINT FK_CustomersProducts_Products
		FOREIGN KEY (ProductId) REFERENCES Products(Id),
	CONSTRAINT FK_OrdersProducts_Customers
		FOREIGN KEY (OrderId) REFERENCES Orders(Id)
);

DECLARE @date DATETIME;
SET @date = SYSDATETIME();

INSERT INTO Customers(FName, LName, Email, RegisteredAt) VALUES(N'Иван', N'Иванов', 'ivan.ivanov@gmail.com', @date);
INSERT INTO Customers(FName, LName, Email, RegisteredAt) VALUES(N'Петр', N'Петров', 'petr.petrov@gmail.com', @date);
INSERT INTO Customers(FName, LName, Email, RegisteredAt) VALUES(N'Андрей', N'Андреев', 'andrei.andreev@gmail.com', @date);

INSERT INTO Categories(Name) VALUES(N'Бытовая химия');
INSERT INTO Categories(Name) VALUES(N'Продукты питания');
INSERT INTO Categories(Name) VALUES(N'Бытовая техника');

INSERT INTO Products(ProductName, ProductCategoryId, Price) VALUES(N'Мыло хозяйственное', (SELECT Id FROM Categories WHERE Name LIKE 'Бытовая химия'), 0.7);
INSERT INTO Products(ProductName, ProductCategoryId, Price) VALUES(N'Яблоки', (SELECT Id FROM Categories WHERE Name LIKE 'Продукты питания'), 1.1);
INSERT INTO Products(ProductName, ProductCategoryId, Price) VALUES(N'Сыр', (SELECT Id FROM Categories WHERE Name LIKE 'Продукты питания'), 7.2);
INSERT INTO Products(ProductName, ProductCategoryId, Price) VALUES(N'Стиральная машина', (SELECT Id FROM Categories WHERE Name LIKE 'Бытовая техника'), 399.99);
INSERT INTO Products(ProductName, ProductCategoryId, Price) VALUES(N'Посудомоечная машина', (SELECT Id FROM Categories WHERE Name LIKE 'Бытовая техника'), 599.99);
INSERT INTO Products(ProductName, ProductCategoryId, Price) VALUES(N'Телевизор', (SELECT Id FROM Categories WHERE Name LIKE 'Бытовая техника'), 599.99);

INSERT INTO Orders(CustomerId, OrderDate) VALUES((SELECT Id FROM Customers WHERE FName LIKE N'Иван' AND LName LIKE N'Иванов'), @date);

INSERT INTO OrderedProducts(ProductId, OrderId) VALUES((SELECT Id FROM Products WHERE ProductName LIKE N'Мыло хозяйственное'), 
	(SELECT o.Id FROM Orders o INNER JOIN Customers c ON o.CustomerId = c.Id WHERE c.LName LIKE N'Иванов' AND c.FNAME LIKE 'Иван' AND o.OrderDate = @date));
INSERT INTO OrderedProducts(ProductId, OrderId) VALUES((SELECT Id FROM Products WHERE ProductName LIKE N'Сыр'), 
	(SELECT o.Id FROM Orders o INNER JOIN Customers c ON o.CustomerId = c.Id WHERE c.LName LIKE N'Иванов' AND c.FNAME LIKE 'Иван' AND o.OrderDate = @date));
INSERT INTO OrderedProducts(ProductId, OrderId) VALUES((SELECT Id FROM Products WHERE ProductName LIKE N'Телевизор'), 
	(SELECT o.Id FROM Orders o INNER JOIN Customers c ON o.CustomerId = c.Id WHERE c.LName LIKE N'Иванов' AND c.FNAME LIKE 'Иван' AND o.OrderDate = @date));