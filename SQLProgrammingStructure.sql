/*
	SQL PROGRAMLAMA YAPISI
*/
/*
-- Deðiþken tanýmlama
DECLARE @FirstName varchar(100) = NULL;
DECLARE @LastName varchar(100);
DECLARE @BirthDate datetime = NULL;
DECLARE @Gender bit;
DECLARE @FullName varchar(100);

-- Deðer Atama
SET @FirstName = 'Jax';
SET @LastName = 'Teller';
SET @BirthDate = '1990-11-24 11:10:55.222';
SET @Gender = 1;
-- Set @Gender = 'True'; de olur
--SET @FullName = @FirstName + ' ' + @LastName; -- birisi null ise toplamlarý null döner
SET @FullName = CONCAT(@FirstName, ' ', @LastName); -- birisi null ise toplamlarý null olmayanlardýr

PRINT @FullName

SELECT @FullName FullName, @FirstName FirstName, @LastName LastName, @BirthDate [Birth Date], @Gender Gender
*/

/*
-- IF - ELSE IF - ELSE
IF condition1 AND condition2 OR condition3
BEGIN -- {
	PRINT 'If sample text'
	IF condition4
	BEGIN
		PRINT 'New sample text'
	END
	ELSE
	BEGIN
		PRINT 'Another sample text'
	END
END -- }
ELSE IF condition5 AND condition6
BEGIN
	PRINT 'Else if sample text'
END
ELSE
BEGIN
	PRINT 'Else sample text'
END
*/

/*
DECLARE @FirstName varchar(50)
DECLARE @LastName varchar(50)
DECLARE @Gender bit = NULL
DECLARE @FullName varchar(100)

SET @FirstName = 'Brian'
SET @LastName = 'Longman'
SET @Gender = 'True'

-- Karþýlaþtýrma
-- <, >, <=, <=, =(eþittir), <>(farklýdýr)
-- IF @FirstName <> NULL ---------> Hatalý
IF @FirstName IS NOT NULL AND @LastName IS NOT NULL -- Doðru
BEGIN
	SET @FullName = @FirstName + ' ' + @LastName
	PRINT @FullName 
END
ELSE
BEGIN
	PRINT 'NULL values exist'
END
*/
/*
USE NORTHWIND
GO -- Buraya kadar olan bütün kodlarý çalýþtýr
SELECT * FROM Employees

-- Veri tipleri tablodakilerle eþleþiyor olmalý
DECLARE @EmployeeID int
DECLARE @FirstName varchar(100)
DECLARE @LastName varchar(100)
DECLARE @Title varchar(100)
-- Deðiþkenlere tablolarýmdaki verileri atýyorum
SELECT @EmployeeID = EmployeeID, @FirstName = FirstName, @LastName = LastName, @Title =  Title 
FROM Employees
WHERE EmployeeID = 5 -- Koþul olmazsa tablodaki son elementi alacaktýr

PRINT 'Employee ID: ' + CAST(@EmployeeID AS varchar(10))-- Tip dönüþümü yapmam lazým
PRINT 'First Name: ' + @FirstName
PRINT 'LastName: ' + @LastName
PRINT 'Title: ' + @Title
*/
/*
--SELECT * FROM Orders WHERE OrderID = 10273
--SELECT * FROM [Order Details] WHERE OrderID = 10273
DECLARE @OrderID int
DECLARE @ProductID int
DECLARE @UnitPrice money
DECLARE @Quantity smallint
DECLARE @Discount real
DECLARE @TotalPrice money

SELECT @OrderID = OrderID, @ProductID = ProductID, @UnitPrice = UnitPrice, @Quantity = Quantity, @Discount = Discount
FROM [Order Details]
WHERE Discount = 0 AND OrderID = 10273

IF @Discount = 0 OR @Discount IS NOT NULL
BEGIN
	SET @TotalPrice = @UnitPrice * @Quantity
	PRINT @TotalPrice
END
*/
/*
SELECT OrderID, ProductID, UnitPrice, Quantity, Discount,
-- Aþaðýda sorguda daha çekerken hesaplama yapýyorum
(UnitPrice * Quantity) ListPrice,
(UnitPrice * Quantity * Discount) DiscountPrice,
(UnitPrice * Quantity) * (1 - Discount) TotalPrice
INTO #TmpOrderDetails -- Bu tabloyu bir temp table'a alacaðým. Bazen kod içersinde geçici tablo oluþturup verilerle iþlem yapma ihtiyacým olabiliyor (WHERE kapattýk bunu yaparken)
FROM [Order Details]
--WHERE OrderID = 10273
 
-- Birçok kez çaðýracaðým kod varsa bu þekilde temp ile iþlemler yapmak maliyet açýsýndan iyi olacaktýr. (Deðiþkene deðer atamak gibi) Bellekte ve hýzlý çalýþýr tempdb
-- TotalPrice en fazla olan elemaný bulacaðým
--SELECT * FROM #TmpOrderDetails -- Burada yukardaki veriye ulaþabilirim. Ýþim bitince Drop ile silerim veya sayfamý kapatýnca kapanýr
DECLARE @ProductID int
DECLARE @OrderID int
DECLARE @TotalPrice money

SELECT TOP 1 @OrderID = OrderID, @ProductID = ProductID, @TotalPrice = TotalPrice
FROM #TmpOrderDetails
ORDER BY TotalPrice DESC

IF @ProductID IS NOT NULL
BEGIN
	SELECT *, @OrderID OrderID, @TotalPrice TotalPrice
	FROM Products
	WHERE ProductID = @ProductID
END

DROP TABLE #TmpOrderDetails

SELECT * FROM [Order Details] WHERE OrderID = 10981 AND ProductID = 38 --Kontrol ettik doðruluðunu
*/

/*
-- CASE WHEN
--SELECT * FROM Products

SELECT ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel,
CASE 
	WHEN UnitsInStock < ReorderLevel 
		THEN 'New orders required' 
		ELSE 'There are enough products in stock' 
END StockState
FROM Products
*/

/*
--SELECT * FROM Categories 

SELECT ProductId, ProductName, CategoryID,
CASE CategoryID
	WHEN 1 THEN 'Beverages'
	WHEN 2 THEN 'Condiments'
	WHEN 3 THEN 'Confections'
	WHEN 4 THEN 'Dairy Products'
	WHEN 5 THEN 'Grains/Cereals'
	WHEN 6 THEN 'Meat/Poultry'
	WHEN 7 THEN 'Produce'
	WHEN 8 THEN 'Seafood'
END CategoryName
FROM Products
*/
/*
WHILE condition
BEGIN
	PRINT 'Sample text'
END
*/

DECLARE @num1 int = 1
DECLARE @num2 int = 100
DECLARE @sum int = 0
/*
WHILE @num1 <= @num2
BEGIN
	IF @num1 % 2 = 0
	BEGIN
		SET @sum = @sum + @num1 
	END
	SEt @num1 = @num1 + 1
END

SELECT @sum RESULTS
*/

WHILE (@num1 <= @num2)
BEGIN
	IF @num1 >= 75
	BEGIN
		break
	END

	IF @num1 % 2 = 1
	BEGIN
		SET @num1 = @num1 + 1
		CONTINUE
	END
	ELSE
	BEGIN
		SET @sum = @sum + @num1
		SET @num1 = @num1 + 1
	END
END
SELECT @sum RESULTS 