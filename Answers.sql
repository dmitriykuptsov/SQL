SELECT AVG(Price), STDEV(Price) FROM Products

SELECT SUBSTRING(Email, CHARINDEX('@', Email)+1, LEN(Email)) AS Domain, 
	COUNT(SUBSTRING(Email, CHARINDEX('@', Email)+1, LEN(Email))) AS Domain
		FROM Customers GROUP BY SUBSTRING(Email, CHARINDEX('@', Email)+1, LEN(Email)) 
			HAVING COUNT(SUBSTRING(Email, CHARINDEX('@', Email)+1, LEN(Email))) >= 2

SELECT * FROM Products ORDER BY Price DESC;