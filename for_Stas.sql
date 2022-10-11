GO
create or alter function GetGrade1(@auppm AS DECIMAL(18, 9), @type AS NVARCHAR(10))
RETURNS NVARCHAR(10)
AS
BEGIN
	DECLARE @res NVARCHAR(10);
	SET @res = (SELECT CASE
		WHEN (@auppm < 0.7) THEN 'Low'
		WHEN (@auppm >= 0.5 AND @auppm < 1) THEN 'Medium'
		ELSE 'High'
		END AS class); 
	RETURN @res;
END
GO
use shop
declare @res nvarchar(10);
set @res = dbo.GetGrade1(0.8, 'Au')
select @res;

SELECT dbo.GetGrade(sa.AuPpm, 'Au') AS GradeAu, sa.name, sa.AuPpm FROM Sample sa;

declare @min_ DECIMAL(18, 9);
SET @min_ = (select AVG(sa.AuPpm) - 0.5*STDEV(sa.AuPpm) As min_ FROM Sample sa);
declare @max_ DECIMAL(18, 9);
SET @max_ = (select AVG(sa.AuPpm) + 0.5*STDEV(sa.AuPpm) As max_ FROM Sample sa);
SELECT DrillHoleId FROM Sample group by DrillHoleId HAVING AuPpm > @min_ AND AuPpm < @max_;

SELECT * FROM Sample WHERE AuPpm > 
	(select AVG(sa.AuPpm) - 0.5*STDEV(sa.AuPpm) As min_ FROM Sample sa) AND 
	AuPpm < (select AVG(sa.AuPpm) + 0.5*STDEV(sa.AuPpm) As max_ FROM Sample sa);


GO
CREATE OR ALTER PROCEDURE SelectAllOrdersOfACustomer 
@FName NVARCHAR(100),
@LName NVARCHAR(100)
AS
BEGIN
SELECT o.Id, o.OrderDate FROM Orders AS o
		INNER JOIN Customers AS c ON o.CustomerId = c.Id
			WHERE c.FName = @FName AND c.LName = @LName
--RETURN;
END

GO
CREATE OR ALTER PROCEDURE Test 
@FName NVARCHAR(100),
@LName NVARCHAR(100)
AS
BEGIN
	declare @res nvarchar(100);
	set @res = 'this is my string';
	select @res;
	RETURN ;
END
go
declare @res1 nvarchar(100);
exec @res1 = dbo.Test @Fname = 'Петр', @Lname = 'Петров'

declare @ss table (id int, date datetime)

insert into @ss exec SelectAllOrdersOfACustomer  @Fname = 'Петр', @Lname = 'Петров';

select * from @ss;

EXEC SelectAllOrdersOfACustomer @Fname = 'Петр', @Lname = 'Петров';






