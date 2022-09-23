USE master;
DROP DATABASE geology;

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'geology')
  BEGIN
    CREATE DATABASE geology;

    USE geology;

    CREATE TABLE DrillHoles (
        id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
        Name VARCHAR(100),
    );

	CREATE TABLE DrillHoleDepth (
		id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
		DrillHoleId INT NOT NULL,
		Depth FLOAT NOT NULL DEFAULT 0.0,
		FOREIGN KEY (DrillHoleId) REFERENCES DrillHoleDepth(id)
	);

	INSERT INTO DrillHoles(Name) VALUES('DrillHole1');
	INSERT INTO DrillHoles(Name) VALUES('DrillHole2');
	INSERT INTO DrillHoles(Name) VALUES('DrillHole3');
	INSERT INTO DrillHoleDepth(drillHoleId, Depth) VALUES((SELECT Id FROM DrillHoles WHERE Name LIKE '%Hole1%'), 20.5);
	INSERT INTO DrillHoleDepth(drillHoleId, Depth) VALUES((SELECT Id FROM DrillHoles WHERE Name LIKE '%Hole2%'), 10.7);

	SELECT a.Name, b.Depth FROM DrillHoles a INNER JOIN DrillHoleDepth b ON a.Id = b.drillHoleId WHERE a.Name IN ('DrillHole1', 'DrillHole2', 'DrillHole3');
	SELECT a.Name, b.Depth FROM DrillHoles a LEFT JOIN DrillHoleDepth b ON a.Id = b.drillHoleId WHERE a.Name IN ('DrillHole1', 'DrillHole2', 'DrillHole3');
  END
