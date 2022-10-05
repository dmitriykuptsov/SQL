CREATE DATABASE DrillHoles;
GO
USE DrillHoles;
GO
CREATE TABLE DrillHole (
	Id INT PRIMARY KEY IDENTITY(1, 1),
	Name NVARCHAR(100) NOT NULL,
	X DECIMAL(16, 8) NOT NULL,
	Y DECIMAL(16, 8) NOT NULL,
	Z DECIMAL(16, 8) NOT NULL
);

CREATE TABLE Sample(
	Id INT PRIMARY KEY IDENTITY(1, 1),
	DrillHoleId INT NOT NULL,
	Name NVARCHAR(100) NOT NULL UNIQUE,
	FromDepth DECIMAL(16, 8),
	ToDepth DECIMAL(16, 8),
	CuPpm DECIMAL(16, 8),
	AuPpm DECIMAL(16, 8),
	AgPpm DECIMAL(16, 8),
	CONSTRAINT Sample_DrillHole
		FOREIGN KEY (DrillHoleId)
			REFERENCES DrillHole(Id)
);

CREATE TABLE Lithology_Types(
	Id INT PRIMARY KEY IDENTITY(1, 1),
	Description NVARCHAR(200)
);

CREATE TABLE Lithology(
	Id INT PRIMARY KEY IDENTITY(1, 1),
	DrillHoleId INT NOT NULL,
	LitTypeId INT NOT NULL,
	FromDepth DECIMAL(16, 8),
	ToDepth DECIMAL(16, 8),
	CONSTRAINT Lithology_DrillHole
		FOREIGN KEY (DrillHoleId)
			REFERENCES DrillHole(Id),
	CONSTRAINT Lithology_Lithology_Types
		FOREIGN KEY (LitTypeId)
			REFERENCES Lithology_Types(Id)
);

INSERT INTO Lithology_Types(Description) VALUES('Шунгит');
INSERT INTO Lithology_Types(Description) VALUES('Гранит');
INSERT INTO Lithology_Types(Description) VALUES('Известняк');
INSERT INTO Lithology_Types(Description) VALUES('Песчаник');
INSERT INTO Lithology_Types(Description) VALUES('Базальт');

INSERT INTO DrillHole(Name, X, Y, Z) VALUES('C-01', 10, 10, 35.6);
INSERT INTO DrillHole(Name, X, Y, Z) VALUES('C-02', 10, 20, 40.2);
INSERT INTO DrillHole(Name, X, Y, Z) VALUES('C-03', 10, 30, 35.2);
INSERT INTO DrillHole(Name, X, Y, Z) VALUES('C-04', 20, 10, 35.6);
INSERT INTO DrillHole(Name, X, Y, Z) VALUES('C-05', 20, 20, 41.2);
INSERT INTO DrillHole(Name, X, Y, Z) VALUES('C-06', 20, 30, 39.1);
INSERT INTO DrillHole(Name, X, Y, Z) VALUES('C-07', 30, 10, 35.1);
INSERT INTO DrillHole(Name, X, Y, Z) VALUES('C-08', 30, 20, 33.1);
INSERT INTO DrillHole(Name, X, Y, Z) VALUES('C-09', 30, 30, 40.1);

INSERT INTO Sample(DrillHoleId, Name, FromDepth, ToDepth, CuPpm, AuPpm, AgPpm) VALUES((SELECT Id FROM DrillHole WHERE Name = 'C-01'), 'Обр-1-С-01', 30, 32, 3, 1.2, 2.0);
INSERT INTO Sample(DrillHoleId, Name, FromDepth, ToDepth, CuPpm, AuPpm, AgPpm) VALUES((SELECT Id FROM DrillHole WHERE Name = 'C-01'), 'Обр-2-С-01', 32, 34, 1.2, 2.2, 2.1);
INSERT INTO Sample(DrillHoleId, Name, FromDepth, ToDepth, CuPpm, AuPpm, AgPpm) VALUES((SELECT Id FROM DrillHole WHERE Name = 'C-01'), 'Обр-3-С-01', 34, 36, 2.2, 2.4, 2.6);
INSERT INTO Sample(DrillHoleId, Name, FromDepth, ToDepth, CuPpm, AuPpm, AgPpm) VALUES((SELECT Id FROM DrillHole WHERE Name = 'C-01'), 'Обр-4-С-01', 36, 38, 3.1, 0.5, 1.6);
INSERT INTO Sample(DrillHoleId, Name, FromDepth, ToDepth, CuPpm, AuPpm, AgPpm) VALUES((SELECT Id FROM DrillHole WHERE Name = 'C-01'), 'Обр-5-С-01', 38, 40, 2.7, 0.4, 0.8);
INSERT INTO Sample(DrillHoleId, Name, FromDepth, ToDepth, CuPpm, AuPpm, AgPpm) VALUES((SELECT Id FROM DrillHole WHERE Name = 'C-01'), 'Обр-6-С-01', 42, 44, 2.8, 0.3, 0.9);
INSERT INTO Sample(DrillHoleId, Name, FromDepth, ToDepth, CuPpm, AuPpm, AgPpm) VALUES((SELECT Id FROM DrillHole WHERE Name = 'C-01'), 'Обр-7-С-01', 44, 46, 1.9, 0.1, 0.01);

INSERT INTO Sample(DrillHoleId, Name, FromDepth, ToDepth, CuPpm, AuPpm, AgPpm) VALUES((SELECT Id FROM DrillHole WHERE Name = 'C-02'), 'Обр-1-С-02', 30, 32, 2.8, 1.2, 2.1);
INSERT INTO Sample(DrillHoleId, Name, FromDepth, ToDepth, CuPpm, AuPpm, AgPpm) VALUES((SELECT Id FROM DrillHole WHERE Name = 'C-02'), 'Обр-2-С-02', 32, 34, 2.2, 1.1, 2.6);
INSERT INTO Sample(DrillHoleId, Name, FromDepth, ToDepth, CuPpm, AuPpm, AgPpm) VALUES((SELECT Id FROM DrillHole WHERE Name = 'C-02'), 'Обр-3-С-02', 34, 36, 1.2, 1.3, 1.6);
INSERT INTO Sample(DrillHoleId, Name, FromDepth, ToDepth, CuPpm, AuPpm, AgPpm) VALUES((SELECT Id FROM DrillHole WHERE Name = 'C-02'), 'Обр-4-С-02', 36, 38, 1.1, 0.7, 1.2);
INSERT INTO Sample(DrillHoleId, Name, FromDepth, ToDepth, CuPpm, AuPpm, AgPpm) VALUES((SELECT Id FROM DrillHole WHERE Name = 'C-02'), 'Обр-5-С-02', 38, 40, 1.7, 0.6, 0.7);
INSERT INTO Sample(DrillHoleId, Name, FromDepth, ToDepth, CuPpm, AuPpm, AgPpm) VALUES((SELECT Id FROM DrillHole WHERE Name = 'C-02'), 'Обр-6-С-02', 42, 44, 1.8, 0.8, 0.8);
INSERT INTO Sample(DrillHoleId, Name, FromDepth, ToDepth, CuPpm, AuPpm, AgPpm) VALUES((SELECT Id FROM DrillHole WHERE Name = 'C-02'), 'Обр-7-С-02', 44, 46, 1.9, 0.5, 0.1);

INSERT INTO Lithology(DrillHoleId, LitTypeId, FromDepth, ToDepth) VALUES((SELECT Id FROM DrillHole WHERE Name = N'C-01'), 
	(SELECT Id FROM Lithology_Types WHERE Description LIKE N'Известняк'), 30, 36);
INSERT INTO Lithology(DrillHoleId, LitTypeId, FromDepth, ToDepth) VALUES((SELECT Id FROM DrillHole WHERE Name = N'C-02'), 
	(SELECT Id FROM Lithology_Types WHERE Description LIKE N'Песчаник'), 30, 36);