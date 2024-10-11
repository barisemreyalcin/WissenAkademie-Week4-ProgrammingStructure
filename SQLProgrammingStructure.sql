/*
	SQL PROGRAMLAMA YAPISI
*/
/*
-- De�i�ken tan�mlama
DECLARE @FirstName varchar(100) = NULL;
DECLARE @LastName varchar(100);
DECLARE @BirthDate datetime = NULL;
DECLARE @Gender bit;
DECLARE @FullName varchar(100);

-- De�er Atama
SET @FirstName = 'Jax';
SET @LastName = 'Teller';
SET @BirthDate = '1990-11-24 11:10:55.222';
SET @Gender = 1;
-- Set @Gender = 'True'; de olur
--SET @FullName = @FirstName + ' ' + @LastName; -- birisi null ise toplamlar� null d�ner
SET @FullName = CONCAT(@FirstName, ' ', @LastName); -- birisi null ise toplamlar� null olmayanlard�r

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

-- Kar��la�t�rma
-- <, >, <=, <=, =(e�ittir), <>(farkl�d�r)
-- IF @FirstName <> NULL ---------> Hatal�
IF @FirstName IS NOT NULL AND @LastName IS NOT NULL -- Do�ru
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
GO -- Buraya kadar olan b�t�n kodlar� �al��t�r
SELECT * FROM Employees

-- Veri tipleri tablodakilerle e�le�iyor olmal�
DECLARE @EmployeeID int
DECLARE @FirstName varchar(100)
DECLARE @LastName varchar(100)
DECLARE @Title varchar(100)
-- De�i�kenlere tablolar�mdaki verileri at�yorum
SELECT @EmployeeID = EmployeeID, @FirstName = FirstName, @LastName = LastName, @Title =  Title 
FROM Employees
WHERE EmployeeID = 5 -- Ko�ul olmazsa tablodaki son elementi alacakt�r

PRINT 'Employee ID: ' + CAST(@EmployeeID AS varchar(10))-- Tip d�n���m� yapmam laz�m
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
-- A�a��da sorguda daha �ekerken hesaplama yap�yorum
(UnitPrice * Quantity) ListPrice,
(UnitPrice * Quantity * Discount) DiscountPrice,
(UnitPrice * Quantity) * (1 - Discount) TotalPrice
INTO #TmpOrderDetails -- Bu tabloyu bir temp table'a alaca��m. Bazen kod i�ersinde ge�ici tablo olu�turup verilerle i�lem yapma ihtiyac�m olabiliyor (WHERE kapatt�k bunu yaparken)
FROM [Order Details]
--WHERE OrderID = 10273
 
-- Bir�ok kez �a��raca��m kod varsa bu �ekilde temp ile i�lemler yapmak maliyet a��s�ndan iyi olacakt�r. (De�i�kene de�er atamak gibi) Bellekte ve h�zl� �al���r tempdb
-- TotalPrice en fazla olan eleman� bulaca��m
--SELECT * FROM #TmpOrderDetails -- Burada yukardaki veriye ula�abilirim. ��im bitince Drop ile silerim veya sayfam� kapat�nca kapan�r
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

SELECT * FROM [Order Details] WHERE OrderID = 10981 AND ProductID = 38 --Kontrol ettik do�rulu�unu
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