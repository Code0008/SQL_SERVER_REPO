use pvl
go
select * from dbo.Beneficiario;

select 
(select COUNT(pat_ben_vc)
from dbo.Beneficiario 
WHERE pat_ben_vc ='QUISPE'
group by pat_ben_vc) as quispe_paternos,
(select COUNT(mat_ben_vc)
from dbo.Beneficiario 
WHERE mat_ben_vc ='QUISPE'
group by mat_ben_vc)  as quispe_maternos
SELECT 
    SUM(CASE WHEN pat_ben_vc = 'QUISPE' THEN 1 ELSE 0 END) AS CountPat,
    SUM(CASE WHEN mat_ben_vc = 'QUISPE' THEN 1 ELSE 0 END) AS CountMat
FROM dbo.Beneficiario;
select count(*), cod_sex_bi from dbo.Beneficiario group by cod_sex_bi


use pvl
go
select * from dbo.Beneficiario

select nom_ben_vc, cod_com_si 
from dbo.Beneficiario 
where cod_com_si = (select max(cod_com_si)
					from dbo.Beneficiario
					)

select TOP 1 count(zon_ben_vc) as contador, zon_ben_vc
from dbo.Beneficiario 
group by zon_ben_vc
ORDER BY contador DESC



SELECT contador, zon_ben_vc 
FROM 
(select count(pat_ben_vc) as contador, zon_ben_vc
from dbo.Beneficiario 
where pat_ben_vc = 'GONZALES'
group by zon_ben_vc) as CONSULTA 
where contador>5


select * from dbo.Beneficiario

SELECT fec_nac_ben_da, nom_ben_vc
from  dbo.Beneficiario
where fec_nac_ben_da <=  (select TOP 1 fec_nac_ben_da 
from dbo.Beneficiario
WHERE pat_ben_vc = 'AYALA'
ORDER BY fec_nac_ben_da  DESC)
ORDER BY fec_nac_ben_da DESC


SELECT DATEDIFF(YEAR, fec_nac_ben_da, getdate() ) as edad
FROM dbo.Beneficiario

select avg(DATEDIFF(YEAR, fec_nac_ben_da, getdate())) as promedio_edad
from dbo.Beneficiario
where zon_ben_vc like '%caja%'








(select zon_ben_vc --nom_ben_vc, cod_cen_ate_ben_in
from dbo.Beneficiario 
group by zon_ben_vc)
select *--nom_ben_vc, cod_cen_ate_ben_in
from dbo.Beneficiario 

SELECT cod_ben_in, nom_ben_vc, zon_ben_vc, nro_km_mza_ben_vc
FROM dbo.Beneficiario b1
WHERE (
    SELECT COUNT(*)
    FROM dbo.Beneficiario b2
    WHERE b2.zon_ben_vc = b1.zon_ben_vc 
      AND b2.nro_km_mza_ben_vc = b1.nro_km_mza_ben_vc
) = 1;

 



select nom_ben_vc
from dbo.Beneficiario
where cod_cen_ate_ben_in IN
(SELECT cod_cen_ate_ben_in
    FROM dbo.Beneficiario
    GROUP BY cod_cen_ate_ben_in
    HAVING COUNT(*) > 1000) 