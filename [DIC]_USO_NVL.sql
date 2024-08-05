select *
from dbamv.prestador
where ds_codigo_conselho = '26521'
/
select * from all_tables
where table_name like '%USUARI%'
AND OWNER <> 'DBAPS'
ORDER BY 2 DESC
/

select NVL(ds_email, usuario.ds_email) from dbamv.prestador
/

SELECT NVL(PD.DS_EMAIL,US.DS_EMAIL) AS DS_EMAIL
FROM DBAMV.PRESTADOR PD, DBASGU.USUARIOS US
WHERE US.CD_PRESTADOR(+) = PD.CD_PRESTADOR
AND US.CD_USUARIO = '&<PAR_USUARIO_LOGADO>'