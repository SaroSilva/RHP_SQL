
select * from audit_dbamv.log_acesso_pep
/

select * from audit_dbamv.prestador
where cd_prestador in ('8636')
/

select * from audit_dbamv.paciente p 
where p.cd_paciente in ('59941')
and p.AUDIT_CD_USUARIO in ('101349','31002')
/

select * from audit_dbamv.paciente
where audit_cd_usuario in ('101349')
order by 1
/
select * from audit_dbamv.mov_prestador
where audit_cd_usuario in ('31002','101349')
/
select * from audit_dbamv.paciente
where audit_cd_usuario in ('31002')
order by 1
/
select * from Editor.editor-registo-campo
/
SELECT a.cd_convenio, c.nm_convenio,P.TP_PROIBICAO,count (a.cd_paciente) "TOTAL DE ATENDIMENTOS" FROM atendime a, convenio c, PROIBICAO P
WHERE c.cd_convenio = a.cd_convenio
AND P.CD_CONVENIO = C.CD_CONVENIO
AND A.CD_ORI_ATE IN (124,125)
GROUP BY a.cd_convenio, c.nm_convenio, P.TP_PROIBICAO
ORDER BY 4 desc
/
select * from colunas
where coluna like '%cd_id_%'

