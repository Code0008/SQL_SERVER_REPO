use Northwind

select * from Categories
select * from [Order Details]
select * from Products



SELECT p.ProductName, p.UnitPrice, c.CategoryName
from Products p
join Categories c
on p.CategoryID = c.CategoryID
where p.UnitPrice = (
	select max(UnitPrice)
	from Products
	where  CategoryID = p.CategoryID
)


select c.CompanyName, c.CustomerID
from Customers c
where c.CustomerID not in (select CustomerID from Orders)


select c.CompanyName, c.CustomerID
from Customers c
left  outer join Orders e
on c.CustomerID = e.CustomerID
where e.OrderID IS NULL;


select * from Employees
select * from [Order Details]
SELECT * FROM ORDERS