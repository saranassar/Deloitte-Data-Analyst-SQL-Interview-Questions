use NORTHWIND
select * from Categories
select * from [Order Details]
select * from Orders

-- Identify duplicate rows
select OrderID, ProductID ,Count(ProductID) as ProductCount , count(*) as OrdersCount from [Order Details]
group by OrderID, ProductID
having count(*) > 1

-- Monthly Revenue Trend
Select Sum (UnitPrice * Quantity) AS sales, MONTH(OrderDate) AS MonthlySales from [Order Details] as OD
join Orders as O
ON OD.OrderID = O.OrderID
group by MONTH(OrderDate)
order by MONTH(OrderDate) asc

--The top 2 highest-sales ProductCategories from each Category
WITH RankedProductCategories AS (
    SELECT
        OrderID,
        ProductID,
        UnitPrice * Quantity AS Sales,
        ROW_NUMBER() OVER (PARTITION BY ProductID ORDER BY UnitPrice * Quantity DESC) AS Rank
    FROM [Order Details]
)
SELECT
    OrderID,
    ProductID,
    Sales,
    Rank
FROM RankedProductCategories
where Rank <= 2

-- Finding data gaps
--# Finding Missing Relationships Between Tables
SELECT DISTINCT od.ProductID
FROM [Order Details] od
LEFT JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductID IS NULL;

--# Finding Missing Rows
SELECT d.DepartmentID, d.DepartmentName
FROM Departments d
LEFT JOIN Employees e ON d.DepartmentID = e.DepartmentID
WHERE e.EmployeeID IS NULL;

--# Detecting Missing Values in Critical Columns
SELECT EmployeeID, Name
FROM Employees
WHERE Salary IS NULL;


