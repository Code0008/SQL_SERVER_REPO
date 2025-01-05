use NorthwindSQL
go

with fibonnaci(num, val , previous) 
as(
	select 1 as num, 0 as val, 1 as previous 

	union all
	-- N,V,P
	-- 1, 0, 1
	-- 2, 1, 1
	-- 3, 1, 2
	-- 4, 2, 3
	-- 5, 3, 5
	select 
	(num+1) as num,
	previous as val , 
	(val+previous) as previous
	from fibonnaci	
	where num < 200
)

select * from fibonnaci

USE Northwind
go
WITH CategorySales AS (
    SELECT P.CategoryID, SUM(OD.Quantity) AS TotalSales
    FROM [Order Details] OD
    JOIN Products P ON OD.ProductID = P.ProductID
    GROUP BY P.CategoryID
),
AvgCategorySales AS (
    SELECT CategoryID, AVG(TotalSales) AS AvgSales
    FROM CategorySales
    GROUP BY CategoryID
)
SELECT P.ProductName, P.CategoryID, SUM(OD.Quantity) AS SalesQuantity
FROM [Order Details] OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductName, P.CategoryID
HAVING SUM(OD.Quantity) > (SELECT AvgSales FROM AvgCategorySales WHERE CategoryID = P.CategoryID)
ORDER BY P.CategoryID, SalesQuantity DESC;



with CategorySales as(
	
	select P.CategoryID, sum(od.Quantity) as ventas_totales
	from [Order Details] as od 
	join Products as P 
	on od.ProductID = p.ProductID
	group by P.CategoryID

), promedio_ventas as (
	select CategoryID, avg(ventas_totales) as ventas_priomedio
	from CategorySales
	group by CategoryID

) 
select P.ProductName, P.CategoryID, sum(od.Quantity) as quan
from [Order Details] od
join Products p
on od.ProductID = p.ProductID
group by p.ProductName, P.CategoryID
HAVING SUM(od.Quantity) > (select ventas_priomedio from
							promedio_ventas 
							where CategoryID = P.CategoryID)
order by P.CategoryID


-- producto con mayor de unidades vendidas por categoria

select * from [Order Details];
select * from Categories;
select * from Products;
with agrupamiento as (
	select od.ProductID as id_producto, sum(od.Quantity) as cantidad, c.CategoryID, ProductName
	from [Order Details] od
	inner join Products p
	on od.ProductID = p.ProductID
	INNER JOIN Categories c
	on p.CategoryID = c.CategoryID
	group by od.ProductID, p.ProductName, c.CategoryID

	
), MAXIMO as (
	select max(cantidad) as maximo, CategoryID
	from agrupamiento
	group by  CategoryID
)
select * from maximo

SELECT *fwith agrupamiento as (
	select od.ProductID as id_producto, sum(od.Quantity) as cantidad, c.CategoryID, ProductName
	from [Order Details] od
	inner join Products p
	on od.ProductID = p.ProductID
	INNER JOIN Categories c
	on p.CategoryID = c.CategoryID
	group by od.ProductID, p.ProductName, c.CategoryID

	
), MAXIMO as (
	select max(cantidad) as maximo, CategoryID
	from agrupamiento
	group by CategoryID, CategoryID
)
select * from maximo









--  conectar orders con custumers y sacart
-- la cantidad de order details
select * from [Order Details];
select  * from  Orders;
select * from Customers;
with consulta as (
	select o.CustomerID, od.UnitPrice, sum(od.Quantity) as cantidad
	from Orders o
	inner join [Order Details] od
	on o.OrderID = od.OrderID
	group by o.CustomerID, o.OrderID, od.UnitPrice
), GASTADO AS (
	SELECT CustomerID,sum(UnitPrice*cantidad) as  gasto_toal
	from consulta 
	group by CustomerID
)
select TOP 5 * from GASTADO
order by gasto_toal desc

select * from Employees;


WITH EmployeeHierarchy AS (
    -- Parte base de la recursión: seleccionamos los empleados que tienen un gerente.
    SELECT EmployeeID, 
           FirstName, 
           LastName, 
           ReportsTo, 
           0 AS Level  -- Nivel 0 significa que son gerentes (en el nivel más alto)
    FROM Employees
    WHERE ReportsTo IS NULL  -- Seleccionamos los empleados que no tienen un gerente (top-level)

    UNION ALL

    -- Parte recursiva: seleccionamos los empleados y sus gerentes.
    SELECT e.EmployeeID, 
           e.FirstName, 
           e.LastName, 
           e.ReportsTo, 
           eh.Level + 1 AS Level  -- Aumentamos el nivel en cada iteración
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh 
	ON e.ReportsTo = eh.EmployeeID  -- Nos unimos a la jerarquía previa
)
SELECT EmployeeID, 
       FirstName, 
       LastName, 
       ReportsTo, 
       Level
FROM EmployeeHierarchy
ORDER BY Level, ReportsTo, LastName;


select * from products;
select round(AVG(UnitPrice),2) as promedio_categoria, CategoryID 
from Products
group by CategoryID;

with PROMEDIOS as (
	select round(AVG(UnitPrice),2) as promedio_categoria, CategoryID 
	from Products
	group by CategoryID
), [productos mayores al promedio] as( 
	SELECT p.CategoryID, p.UnitPrice, p.ProductName
	FROM Products p
	inner join PROMEDIOS pr on pr.CategoryID = p.CategoryID
	where p.UnitPrice > pr.promedio_categoria
)
select * 
from [productos mayores al promedio]
order by 1,2