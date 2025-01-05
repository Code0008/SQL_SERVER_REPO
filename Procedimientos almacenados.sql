-- Procedimiento almacenado es un conjunto de instrucciones
-- que se alamcena en la db y se ejcuta como unidad

-- permite encapsular la logica del negocio y operaciones complejas 
-- de la aplicacion

-- Conocer los tipos de datos :V

USE Northwind
GO
SELECT
	concat(xusertype,'|',
	name, '|',
	xtype,'|',
	length,'|', 
	xprec, '|' ,-- precision
	xscale) -- escala
FROM systypes
ORDER BY xtype
GO
-- la mayoria de las db comparten los tipos de datos

-------------------------


-- creacion de propios tipos de datos hijos de tipos de datos de sql


USE Northwind
GO
-- Creación de tipos de datos del usuario
IF EXISTS
(
    SELECT name
    FROM systypes
    WHERE name = 'td_codigo'
)
DROP TYPE td_codigo
GO
CREATE TYPE td_codigo FROM INT
GO
IF EXISTS
(
    SELECT name
    FROM systypes
    WHERE name = 'td_apellido'
)
DROP TYPE td_apellido
GO
CREATE TYPE td_apellido FROM VARCHAR(40)
GO
IF EXISTS
(
    SELECT name
    FROM systypes
    WHERE name = 'td_nombre'
)
DROP TYPE td_nombre
GO
CREATE TYPE td_nombre FROM VARCHAR(35)
GO
IF EXISTS
(
    SELECT name
    FROM systypes
    WHERE name = 'td_direccion'
)
DROP TYPE td_direccion
GO
CREATE TYPE td_direccion FROM VARCHAR(200)
GO
IF EXISTS
(
    SELECT name
    FROM systypes
    WHERE name = 'td_razon_social'
)
DROP TYPE td_razon_social
GO
CREATE TYPE td_razon_social FROM VARCHAR(150)
GO

SELECT CONCAT(t2.name,': ',t1.name,'(',t2.length,')') AS [Tipo de datos definidos por el usuario]
FROM systypes t1
INNER JOIN systypes t2
ON t1.xusertype = t2.xtype
WHERE t2.name LIKE 'td%'
GO



-- CREACION DE VARUIABLES T-SQL

use Northwind
go
-- promedio de precios de los productos

DECLARE @PROMEDIO float ;
select 
	@PROMEDIO = AVG(UnitPrice)
from Products

select @PROMEDIO
go
--------------
declare @PROMEDIO float;
set @PROMEDIO  =
(
	select  avg(UnitPrice)
	from Products
)
go
----------------------
declare @promedio float = (
	select avg(UnitPrice)
	from Products
)

go

------------------------

-- PROCEDIMIENTOS ALMACENADOS SIN PARAMETrOS
/*
	USANDO NORTHWIND
	CREE UN PROCEDIMENTO ALMACENADO 
	QUE MUESTRE EL STOCK DE LOS PRODUCTOS
*/
use Northwind
go

if exists(
	select 
		name 
	from sys.procedures
	where name='usp_stock'
)
drop procedure usp_stock
go
create procedure usp_stock
as
begin 
	select ProductID, ProductName, UnitsInStock as stock 
	from Products
	where UnitsInStock <10
	ORDER BY 3 desc
	return 0
end
go
execute usp_stock

-- 
-- CAPITAN PAVO 🦃🦃/
/*
	PROCEDIMIENTO ALMACENADO QUE MUESTRE LAS VENTAS POR AÑO
*/

if exists(
	select 
		name 
	from sys.procedures
	where name='usp_venta_anual'
)
DROP PROCEDURE usp_venta_anual
go
CREATE PROCEDURE usp_venta_anual
as 
BEGIN
	select 
		YEAR(o.OrderDate) as año,
		convert(
			DECIMAL(12,2),
			sum(od.Quantity * od.UnitPrice * (1 - od.Discount))
			) as ventas
	from Orders o
	inner join [Order Details] od
	on o.OrderID = od.OrderID
	GROUP BY YEAR(o.OrderDate)
END


execute usp_venta_anual;


select * from Orders -- solo para traza


use pvl
go
select *
from dbo.Comite

use pvl
go
select *
from dbo.Pueblo


use pvl
go
select *
from dbo.Beneficiario;

with contador_por_pueblo as (
	select TOP 5
		count(com.cod_pue_si) as cantidad, 
		com.cod_pue_si as codigo
	from Comite com
	group by com.cod_pue_si 
	order by 1 desc
)
select * from contador_por_pueblo coun_p
inner join Pueblo pue
on coun_p.codigo = pue.cod_pue_si
-- 🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃 --
-- 🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃 --
-- 🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃 --
-- 🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃 --
-- 🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃 --
-- 🦃🦃🦃🦃🦃 S Y D A  🦃🦃🦃🦃🦃🦃 --
-- 🦃🦃🦃🦃🦃 S Y D A  🦃🦃🦃🦃🦃🦃 --
-- 🦃🦃🦃🦃🦃 S Y D A  🦃🦃🦃🦃🦃🦃 --
-- 🦃🦃🦃🦃🦃 S Y D A  🦃🦃🦃🦃🦃🦃 --
-- 🦃🦃🦃🦃🦃 S Y D A  🦃🦃🦃🦃🦃🦃 --
-- 🦃🦃🦃🦃🦃 S Y D A  🦃🦃🦃🦃🦃🦃 --
-- 🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃 --
-- 🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃 --
-- 🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃 --
-- 🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃🦃 --

use AdventureWorks2022


select table_name from INFORMATION_SCHEMA.tables
select column_name from INFORMATION_SCHEMA.COLUMNS where table_name='vSalesPerson'

-- Procedimento almacenado que muestr las ventas por año de la db adventure works


if exists(
	select	
		name
	from sys.procedures
	where name = 'psu_ventas_por_ano_adw22'

)
drop procedure psu_ventas_por_ano_adw22
go
create procedure psu_ventas_por_ano_adw22
as 
begin 
	select 
		year(sh.OrderDate) as año,
		convert(
				decimal(12,1), 
				SUM(
					sod.OrderQty * sod.UnitPrice *
								(1-
										IIF(
										sh.OrderDate>= so.StartDate 
										and
										sh.OrderDate<=so.EndDate
										and
										sod.OrderQty >= so.MinQty 
										and 
										sod.OrderQty <= ISNULL(so.MaxQty, 999999),
										so.DiscountPct, -- correcto
										0 -- INCORRECTO
										)
								)
					)
		) as venta_total
	from Sales.SalesOrderHeader sh
	inner join sales.SalesOrderDetail sod
	on sh.SalesOrderID = sod.SalesOrderID
	inner join sales.SpecialOfferProduct spo
	on sod.ProductID = spo.ProductID
	inner join sales.SpecialOffer so
	on spo.SpecialOfferID = so.SpecialOfferID
	group by year(sh.OrderDate)
	return 0
END

execute psu_ventas_por_ano_adw22;

/*
	PROCEDIMIENTOS ALMACENADOS CON UN SOLO PARAMETRO 
*/
USE PVL
GO
IF EXISTS
(
    SELECT name
    FROM sys.procedures
    WHERE name = 'usp_beneficiario_consulta'
)
DROP PROCEDURE usp_beneficiario_consulta
GO
CREATE PROCEDURE usp_beneficiario_consulta
(
    @parametro AS VARCHAR(115) = NULL
)
AS
BEGIN
    IF @parametro IS NULL
        SELECT TOP 20
            cod_ben_in AS CÓDIGO,
            pat_ben_vc AS PATERNO,
            mat_ben_vc AS MATERNO,
            nom_ben_vc AS NOMBRE,
            CONVERT(CHAR(10), fec_nac_ben_da, 103) AS [FECHA DE NACIMIENTO],
            dni_ben_ch,
            IIF(cod_sex_bi=0, 'FEMENINO', 'MASCULINO') AS SEXO
        FROM Beneficiario
    ELSE
        IF ISNUMERIC(@parametro)=1 AND @parametro NOT LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
            SELECT
                cod_ben_in AS CÓDIGO,
                pat_ben_vc AS PATERNO,
                mat_ben_vc AS MATERNO,
                nom_ben_vc AS NOMBRE,
                CONVERT(CHAR(10), fec_nac_ben_da, 103) AS [FECHA DE NACIMIENTO],
                dni_ben_ch,
                IIF(cod_sex_bi=0, 'FEMENINO', 'MASCULINO') AS SEXO
            FROM Beneficiario
            WHERE cod_ben_in = @parametro
        ELSE
            IF @parametro LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
                SELECT
                    cod_ben_in AS CÓDIGO,
                    pat_ben_vc AS PATERNO,
                    mat_ben_vc AS MATERNO,
                    nom_ben_vc AS NOMBRE,
                    CONVERT(CHAR(10), fec_nac_ben_da, 103) AS [FECHA DE NACIMIENTO],
                    dni_ben_ch,
                    IIF(cod_sex_bi=0, 'FEMENINO', 'MASCULINO') AS SEXO
                FROM Beneficiario
                WHERE dni_ben_ch = @parametro
            ELSE
                IF @parametro LIKE ('[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]')
                    SELECT
                        cod_ben_in AS CÓDIGO,
                        pat_ben_vc AS PATERNO,
                        mat_ben_vc AS MATERNO,
                        nom_ben_vc AS NOMBRE,
                        CONVERT(CHAR(10), fec_nac_ben_da, 103) AS [FECHA DE NACIMIENTO],
                        dni_ben_ch,
                        IIF(cod_sex_bi=0, 'FEMENINO', 'MASCULINO') AS SEXO
                    FROM Beneficiario
                    --WHERE fec_nac_ben_da = CONVERT(DATE, @parametro, 103)
                    WHERE fec_nac_ben_da = CAST(@parametro AS DATE)
END

GO
usp_beneficiario_consulta '07066071'
GO
