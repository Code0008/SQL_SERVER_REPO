
use pvl
go 
select 
 CONVERT(VARCHAR(200),fec_nac_ben_da,100) as [fecha_nacimiento],
 DATEDIFF(DAY, fec_nac_ben_da, '20040731')/365 as edad1 , -- años
 DATEDIFF(DAY, fec_nac_ben_da, '20040731') as DIAS, -- dias
 CONVERT(int, DATEDIFF(DAY, fec_nac_ben_da, '20040731')/365) as eded -- dias en formato enteor
 from Beneficiario 
 where 
	convert(int , DATEDIFF(day, fec_nac_ben_da, '20040731')/365)
	<>
	convert(int , DATEDIFF(day, fec_nac_ben_da, '20040731'))

-- condicional IFF


select  * 
from Beneficiario



select pat_ben_vc, mat_ben_vc, nom_ben_vc,
		IIF(cod_sex_bi=1, 'Masculino', 'Femenino') AS SEXO,
		CONVERT(INT, DATEDIFF(DAY,fec_nac_ben_da, CONVERT(VARCHAR(200), GETDATE(), 112))/365) AS EDAD
from Beneficiario

SELECT CONVERT(VARCHAR(200), GETDATE(), 112)

select pat_ben_vc, mat_ben_vc, nom_ben_vc,
	case cod_sex_bi
	when 0 then 'femenena'
	when 1 then 'macheto'
	else 'transsexual transexual'
	end
	AS SEXO,
	CONVERT(INT, 
	DATEDIFF(DAY,fec_nac_ben_da,
	CONVERT(VARCHAR(200), 
	GETDATE(), 112))/365) AS EDAD
from Beneficiario


USE pvl
GO
SELECT
    cod_ben_in AS Código,
    pat_ben_vc AS Paterno,
    mat_ben_vc AS Materno,
    nom_ben_vc AS Nombres,
    CONVERT(CHAR(10), fec_nac_ben_da, 103) AS [Fecha de Nacimiento],
    dni_ben_ch AS DNI,
    CHOOSE(cod_sex_bi+1, 'FEMENINO', 'MASCULINO') Sexo,
    CONVERT(INT, DATEDIFF(DAY, fec_nac_ben_da, '20040731')/365.256363004) AS Edad
FROM Beneficiario
GO

USE [Northwind]
GO
SELECT
    LTRIM([EmployeeID]) AS Código
      ,[TitleOfCourtesy] + ' ' +[LastName] + ', ' +[FirstName] AS Cliente
      ,[Address]
      ,[City]
      ,[Region]
      ,[PostalCode]
      ,[Country]
      ,[HomePhone]
  FROM [dbo].[Employees]
UNION
SELECT  [CustomerID]
      ,[CompanyName]

      ,[Address]
      ,[City]
      ,[Region]
      ,[PostalCode]
      ,[Country]
      ,[Phone]
FROM [dbo].[Customers]
GO

select [Phone] from [dbo].[Customers]
union 
select [HomePhone] FROM [dbo].[Employees]


use pvl
go
SELECT TOP 5 pat_ben_vc as apellido,
count(*) as cantidad from (
	select pat_ben_vc 
	from  Beneficiario
	union all 
	select mat_ben_vc 
	from Beneficiario
) as SC
group by pat_ben_vc
order by 2 DESC

USE AdventureWorksDW2022
GO
SELECT TOP 5
    c.SpanishProductCategoryName AS Categoría,
	convert(DECIMAL(19,2),
	SUM(
		f.OrderQuantity * (
		f.UnitPrice *	(
		1-IIF(
				f.OrderDate >= p.StartDate
				and f.OrderDate <= p.EndDate 
				and f.OrderQuantity >= isnull(p.MinQty, 1)
				and f.OrderQuantity <= isnull(p.MaxQty, 100000),
				p.DiscountPct, 0
				)
		) - f.ProductStandardCost)
	)) as utilidad
FROM FactInternetSales f
INNER JOIN DimPromotion p
ON p.PromotionKey = f.PromotionKey
INNER JOIN DimProduct prd
ON f.ProductKey = prd.ProductKey
INNER JOIN DimProductSubcategory sc
ON sc.ProductSubcategoryKey = prd.ProductSubcategoryKey
INNER JOIN DimProductCategory c
ON c.ProductCategoryKey=sc.ProductCategoryKey
GROUP BY c.SpanishProductCategoryName


select OrderQuantity, PromotionKey from FactInternetSales 
