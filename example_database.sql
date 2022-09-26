USE shop;

CREATE TABLE Customer (
	Id INT PRIMARY KEY IDENTITY(1,1),
	FName NVARCHAR(100),
	LName NVARCHAR(100),
	Email NVARCHAR(100),
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

CREATE TABLE CustomerProducts (
	Id INT PRIMARY KEY IDENTITY(1,1),
	ProductId INT NOT NULL,
	CustomerId INT NOT NULL,
	CONSTRAINT FK_CustomersProducts_Products
		FOREIGN KEY (ProductId) REFERENCES Products(Id),
	CONSTRAINT FK_CustomersProducts_Customers
		FOREIGN KEY (CustomerId) REFERENCES Customer(id)
)

INSERT INTO Customer(FName, LName, Email, RegisteredAt) VALUES(N'Иван', N'Иванов', 'ivan.ivanov@gmail.com', SYSDATETIME());
INSERT INTO Customer(FName, LName, Email, RegisteredAt) VALUES(N'Петр', N'Петров', 'petr.petrov@gmail.com', SYSDATETIME());

INSERT INTO Categories(Name) VALUES(N'Бытовая химия');
INSERT INTO Categories(Name) VALUES(N'Продукты питания');
INSERT INTO Categories(Name) VALUES(N'Бытовая техника');

INSERT INTO Products(ProductName, ProductCategoryId, Price) VALUES(N'Мыло хозяйственное', (SELECT Id FROM Categories WHERE Name LIKE 'Бытовая химия'), 0.7);
INSERT INTO Products(ProductName, ProductCategoryId, Price) VALUES(N'Яблоки', (SELECT Id FROM Categories WHERE Name LIKE 'Продукты питания'), 1.1);
INSERT INTO Products(ProductName, ProductCategoryId, Price) VALUES(N'Сыр', (SELECT Id FROM Categories WHERE Name LIKE 'Продукты питания'), 7.2);
INSERT INTO Products(ProductName, ProductCategoryId, Price) VALUES(N'Стиральная машина', (SELECT Id FROM Categories WHERE Name LIKE 'Бытовая техника'), 399.99);
INSERT INTO Products(ProductName, ProductCategoryId, Price) VALUES(N'Посудомоечная машина', (SELECT Id FROM Categories WHERE Name LIKE 'Бытовая техника'), 599.99);
INSERT INTO Products(ProductName, ProductCategoryId, Price) VALUES(N'Телевизор', (SELECT Id FROM Categories WHERE Name LIKE 'Бытовая техника'), 599.99);

INSERT INTO CustomerProducts(ProductId, CustomerId) VALUES((SELECT Id FROM Products WHERE ProductName LIKE N'Мыло хозяйственное'), 
	(SELECT Id FROM Customer WHERE LName LIKE N'Иванов' AND FNAME LIKE 'Иван'));
INSERT INTO CustomerProducts(ProductId, CustomerId) VALUES((SELECT Id FROM Products WHERE ProductName LIKE N'Сыр'), 
	(SELECT Id FROM Customer WHERE LName LIKE N'Иванов' AND FNAME LIKE 'Иван'));
INSERT INTO CustomerProducts(ProductId, CustomerId) VALUES((SELECT Id FROM Products WHERE ProductName LIKE N'Телевизор'), 
	(SELECT Id FROM Customer WHERE LName LIKE N'Иванов' AND FNAME LIKE 'Иван'));
